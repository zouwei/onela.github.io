---
title: Ubuntu无需重启PVE，解决PCIE直通后找不到硬盘的问题
tags:
  - PCIE
---

## toc
添加了一块固态硬盘，PCIE转M.2硬盘，挂在硬盘使用lsblk找不到对应硬盘，无法挂载。



## 1、查找驱动、卸载与绑定驱动

### 1. 确定设备ID以及当前驱动状态

```
lspci -k
...
04:00.0 Non-Volatile memory controller: Yangtze Memory Technologies Co.,Ltd Device 0081 (rev 01)
        Subsystem: Yangtze Memory Technologies Co.,Ltd Device 0081
        Kernel driver in use: vfio-pci
        Kernel modules: nvme
...
```

这里的 `81:00.0` 是设备的ID，后面会用到。
同时可以发现当前驱动是 `vfio-pci`，这意味着设备仍然被 VFIO 保留，因此宿主机无法访问这个HBA卡下的硬盘。
在确定问题后，我们卸载这个驱动并重新绑定正确驱动。

### 2.卸载驱动及重新绑定

### 获取IOMMU组

使用上一步获取的设备ID，找到对应的IOMMU组。

```shell
find /sys/kernel/iommu_groups/ -type l | grep "04:00.0"
# 输出如下
/sys/kernel/iommu_groups/92/devices/0000:04:00.0
```

这里的 `92` 就是IOMMU组的ID，不过不用单独记录，
直接把输出的完整路径复制下来就行。

### 卸载 vfio 驱动

这里直接利用上一步获取的路径进行操作。

```shell
echo "0000:04:00.0" | tee /sys/kernel/iommu_groups/92/devices/0000:04:00.0/driver/unbind
```

正常输出设备ID。

```shell
0000:04:00.0
```

### 重新绑定驱动

路径中的 `nvme` 是驱动名, 注意根据你的实际情况自行调整。

```shell
echo "0000:04:00.0" | tee /sys/bus/pci/drivers/nvme/bind
```

正常输出设备ID

```shell
0000:04:00.0
```

### 再次查看设备驱动状态

```
lspci -k
```

可以发现之前的 `vfio-pci` 已经被替换为 `nvme` 了。

```
04:00.0 Non-Volatile memory controller: Yangtze Memory Technologies Co.,Ltd Device 0081 (rev 01)
        Subsystem: Yangtze Memory Technologies Co.,Ltd Device 0081
        Kernel driver in use: nvme
        Kernel modules: nvme
```



### 重新扫描磁盘

已经正确实别到了硬盘，挂载硬盘以及控制台添加硬盘过程省略。

~~~shell
lsblk
nvme1n1                      259:5    0   3.6T  0 disk 
└─nvme1n1p1                  259:6    0    16M  0 part 
~~~



## 2、Proxmox VE pve硬盘直通

当pve宿主机出现重启之后，配置没有保存，又会恢复到最开始的状态。

~~~shell
# 加载对应的内核模块
echo vfio_virqfd >> /etc/modules
~~~

