#!/bin/bash

# 配置参数
OWNER="zouwei"  # 仓库所有人，可自行更改
REPO="onela.github.io"  # GitHub 仓库，可自行更改
EXTRACT_DIR="onela.cn"   # 解压目标目录，可自行更改

# 获取最新 Release 的信息
echo "Fetching the latest release from $REPO..."
RELEASE_INFO=$(curl -s https://api.github.com/repos/$OWNER/$REPO/releases/latest)

# 提取 tar.gz 文件的下载链接和文件名
LATEST_RELEASE_URL=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | endswith(".tar.gz")) | .browser_download_url')
FILENAME=$(echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | endswith(".tar.gz")) | .name')

# 检查是否找到 tar.gz 文件
if [ -z "$LATEST_RELEASE_URL" ]; then
  echo "Error: No tar.gz file found in the latest release of $REPO."
  exit 1
fi

# 提取版本号（用于日志）
VERSION=$(echo "$RELEASE_INFO" | jq -r '.tag_name')

echo "Latest version: $VERSION"
echo "FILENAME: $FILENAME"
echo "Download URL: $LATEST_RELEASE_URL"

# 下载 tar.gz 文件
echo "Downloading $FILENAME to $DOWNLOAD_DIR..."
curl -L -o "./$FILENAME" "$LATEST_RELEASE_URL"

# 检查下载是否成功
if [ $? -ne 0 ]; then
  echo "Error: Failed to download $FILENAME."
  exit 1
fi

# 验证文件是否存在
if [ ! -f "./$FILENAME" ]; then
  echo "Error: Downloaded file not found at ./$FILENAME."
  exit 1
fi

# 解压 tar.gz 文件到指定目录
echo "Extracting $FILENAME to $EXTRACT_DIR..."
tar -xzf "./$FILENAME" -C "$EXTRACT_DIR"

# 检查解压是否成功
if [ $? -ne 0 ]; then
  echo "Error: Failed to extract $FILENAME."
  exit 1
fi

echo "Successfully downloaded and extracted $FILENAME to $EXTRACT_DIR."

# 可选：清理下载的 tar.gz 文件
rm "./$FILENAME"
echo "Cleaned up: $FILENAME removed from $DOWNLOAD_DIR."
