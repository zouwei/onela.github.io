

---
title: Moraya AI 时代极简 Markdown 编辑器
tags:
  - Rust
  - Tauri
  - MCP
---

## toc

当隐私优先遇上 AI 能力，一款仅 10MB 的 Rust + Tauri v2 编辑器如何成为你的本地 AI Agent 平台？本文全面介绍 Moraya 的核心功能、技术架构、MCP 生态与安全设计。

## 前言

在 AI 浪潮席卷一切的今天，我们使用的写作工具也在经历一场深刻变革。市面上不乏优秀的 Markdown 编辑器——Typora、Obsidian、VS Code……但它们要么缺乏原生 AI 集成，要么过于臃肿，要么在隐私保护上令人担忧。

**Moraya** 的出现，给出了一个令人耳目一新的答案：一款仅约 **10MB** 的超轻量级所见即所得 Markdown 编辑器，基于 **Rust + Tauri v2** 构建，不仅拥有极致的编辑体验，还深度整合了 **本地 AI 生态** 和 **MCP（Model Context Protocol）** 能力——让你的编辑器摇身一变，成为一个强大的、隐私优先的 AI Agent 平台。

> **Moraya** 这个名字取自拉丁语 *mora*（一刻）与中文"雅"的结合——优雅的一刻。

---

## 一、为什么选择 Moraya？

### 1.1 超轻量 & 原生性能

Moraya 的安装包仅约 **10MB**，得益于 Tauri v2 的架构优势，它直接调用系统原生 WebView 而非捆绑 Chromium，启动几乎瞬间完成，内存占用极低。对比 Electron 应用动辄 200MB+ 的体积，这是一个数量级的差距。

### 1.2 真正的即时所见即所得

输入 `# `       立即看到标题渲染——这背后是 **Milkdown v7**（基于 ProseMirror）引擎的强大能力。不同于"预览面板"式的伪所见即所得，Moraya 实现了真正的即时渲染编辑。

### 1.3 最强本地 AI 集成

这是 Moraya 最令人兴奋的部分：

- **多模型多供应商**：支持 Claude、OpenAI、Gemini、DeepSeek、Ollama 以及任何 OpenAI 兼容端点

- **71+ AI 模板**：覆盖写作、翻译、学生、营销、专业等 10 大类别

- **AI 图像生成**：5 种模式 × 10 种风格，支持 DALL-E、Grok 等

- **AI + MCP 工具调用**：LLM 可以自主调用 MCP 工具，实现自动化工作流

### 1.4 领先的 MCP 生态

MCP（Model Context Protocol）是连接 AI 与外部工具的桥梁，Moraya 在这方面做到了业界领先：

- **动态 MCP 容器**：AI 可以即时创建 MCP 服务

- **一键市场安装**：集成官方注册表、LobeHub、Smithery 三大数据源

- **完全自托管**：所有 MCP 服务都在本地运行

### 1.5 安全设计

- API 密钥存储在操作系统原生密钥链（macOS Keychain / Windows Credential Manager / Linux Secret Service）

- 所有外部 API 调用通过 Rust 后端代理，密钥永远不会暴露在 WebView 中

- 严格的 CSP 策略、路径遍历保护、HTML 导出消毒

---

## 二、核心功能深度解析

### 2.1 编辑器——三种模式，随心切换

Moraya 提供三种编辑模式，通过 `Cmd+/`（macOS）或 `Ctrl+/`（Windows/Linux）快速切换：

| 模式              | 说明             |
| --------------- | -------------- |
| **Visual（可视化）** | 所见即所得，输入即渲染    |
| **Source（源码）**  | 原始 Markdown 编辑 |
| **Split（分屏）**   | 左右同步，支持块级滚动锚定  |

**Markdown 支持**方面，Moraya 覆盖了 CommonMark + GFM 扩展的全部能力：

- ✅ 表格（带浮动工具栏）

- ✅ 任务列表

- ✅ 删除线、Emoji

- ✅ LaTeX 数学公式（KaTeX 渲染）

- ✅ 代码块（25+ 语言高亮，语言选择下拉，一键复制）

- ✅ **Mermaid 图表**——支持 9 种图表类型（流程图、时序图、甘特图、状态图、类图、ER 图、饼图、思维导图、旅程图），编辑/预览双模式，懒加载渲染

### 2.2 AI 驱动的智能写作

#### 多供应商配置

打开设置（`Cmd+,`），选择 AI 标签页即可配置：

| 供应商              | 是否需要 API Key | 备注                                 |
| ---------------- | ------------ | ---------------------------------- |
| Anthropic Claude | 是            | claude-opus-4.5, claude-sonnet-4 等 |
| OpenAI           | 是            | gpt-4o, gpt-4o-mini, o1 等          |
| Google Gemini    | 是            | gemini-2.0-flash, gemini-1.5-pro   |
| DeepSeek         | 是            | deepseek-chat, deepseek-reasoner   |
| Ollama（本地）       | 否            | 需本地运行 Ollama                       |
| 自定义 API          | 可选           | 任何 OpenAI 兼容端点                     |

#### 71+ AI 模板系统

Moraya 内置了 **10 大类别、71+ AI 模板**，覆盖了几乎所有写作场景：

1. **写作** — 文章润色、扩写、缩写、改写
2. **翻译** — 多语言互译
3. **学生** — 论文辅助、学习笔记
4. **儿童** — 故事创作、趣味学习
5. **营销** — 文案生成、社媒内容
6. **专业** — 技术文档、代码解释
7. **个人** — 日记、邮件
8. **中文游戏** — 成语接龙等
9. **英文游戏** — 词汇练习等
10. **测验** — 知识问答

模板支持 **5 种流类型**：自动、输入、选择、参数化、交互式，满足不同交互需求。

#### AI 图像生成

Moraya 集成了 AI 图像生成能力：

- **5 种模式**：文章配图、设计稿、故事板、产品图、情绪板

- **每种模式 10 种风格**

- **7 种宽高比 + 3 种分辨率**

- 支持 OpenAI DALL-E、Grok 及自定义供应商

### 2.3 MCP 生态——编辑器变身 AI Agent 平台

MCP（Model Context Protocol）是 Moraya 最具前瞻性的设计。它让你的编辑器不再只是一个写作工具，而是一个可以连接任意外部能力的 **AI Agent 平台**。

#### 三种传输协议

```text
stdio  — 标准输入输出（最常见）
SSE    — Server-Sent Events
HTTP   — HTTP 请求
```

#### MCP 市场

一键浏览和安装 MCP 服务器，集成三大数据源：

- **Official Registry** — MCP 官方注册表

- **LobeHub** — 社区贡献

- **Smithery** — 第三方生态

#### 动态 MCP 容器

这是 Moraya 最"黑科技"的功能之一——**AI 可以在运行时动态创建 MCP 服务**。基于轻量级 Node.js 运行时，提供 4 个内部工具：

1. `create` — 创建服务
2. `save` — 持久化保存
3. `list` — 列出所有服务
4. `remove` — 删除服务

这意味着 AI 可以根据你的需求，**自主创建工具**来完成任务——真正的 AI Agent 体验。

#### 内置预设

开箱即用的 MCP 服务器：

- **Filesystem** — 文件系统操作

- **Fetch** — 网络请求

- **Git** — Git 操作

- **Memory** — 记忆存储

还支持直接导入 **Claude Desktop JSON 配置**，无缝迁移。

### 2.4 发布工作流

Moraya 不止于写作，还覆盖了完整的发布流程：

- **多目标发布** — 发布到 GitHub 仓库或自定义 API，支持 front matter 和文件命名模板

- **SEO 助手** — AI 自动生成标题、摘要、标签、slug、meta 描述

- **图床集成** — 自动上传到 SM.MS、Imgur、GitHub 或自定义图床

- **RSS 订阅** — 发布时自动更新 RSS 2.0 feed（零依赖 XML 生成）

---

## 三、技术架构

Moraya 的架构设计清晰而优雅：

```text
┌────────────────────────────────────────┐
│         Tauri WebView (Frontend)       │
│   Svelte 5 + Milkdown + TypeScript    │
│                                        │
│  ┌───────────┐ ┌───────┐ ┌──────────┐  │
│  │  Editor   │ │  AI   │ │ Settings │  │
│  │(Milkdown) │ │ Panel │ │  Panel   │  │
│  │ + Source  │ │       │ │ (tabbed) │  │
│  └─────┬─────┘ └──┬────┘ └────┬─────┘  │
│        │          │           │        │
│  ┌─────┴──────────┴───────────┴──────┐ │
│  │       Services & Stores           │ │
│  │  (file, AI, MCP, settings, i18n)  │ │
│  └───────────────┬───────────────────┘ │
│                  │ Tauri IPC (invoke)  │
└──────────────────┼─────────────────────┘
                   │
┌──────────────────┼─────────────────────┐
│         Rust Backend (Tauri)           │
│                                        │
│  ┌────────────┐ ┌──────────┐ ┌──────┐  │
│  │ File I/O   │ │ MCP Proc │ │ Menu │  │
│  │ Commands   │ │ Manager  │ │      │  │
│  └────────────┘ └──────────┘ └──────┘  │
└────────────────────────────────────────┘
```

### 技术栈一览

| 层级   | 技术                        | 版本              |
| ---- | ------------------------- | --------------- |
| 运行时  | Tauri v2                  | >=2.9, <2.10    |
| 后端   | Rust                      | 2021 edition    |
| 前端   | Svelte 5 + SvelteKit（SPA） | ^5.0.0 / ^2.9.0 |
| 编辑引擎 | Milkdown v7（ProseMirror）  | ^7.18.0         |
| 数学渲染 | KaTeX                     | ^0.16.28        |
| 图表   | Mermaid（懒加载）              | ^11.x           |
| 构建工具 | Vite                      | ^6.0.3          |
| 包管理器 | pnpm                      | 10.x            |
| 语言   | TypeScript（严格模式）          | \~5.6.2         |

### 为什么选择这个技术栈？

**Tauri v2 + Rust** 的组合带来了几个关键优势：

1. **极致轻量**：不捆绑 Chromium，直接使用系统 WebView
2. **安全性**：Rust 的内存安全特性 + Tauri 的沙箱模型
3. **性能**：原生级别的启动速度和运行效率
4. **跨平台**：一套代码，macOS / Windows / Linux 全覆盖

**Svelte 5** 作为前端框架，编译时优化带来了更小的 bundle 和更快的运行时性能。

**Milkdown v7** 基于 ProseMirror，提供了工业级的富文本编辑能力，同时保持了良好的可扩展性。

---

## 四、隐私与安全——Moraya 的核心承诺

在 AI 时代，隐私是最容易被忽视、却最不应该被忽视的问题。Moraya 在这方面做出了坚定的承诺：

### BYOK（Bring Your Own Key）

你使用自己的 API 密钥，密钥仅存储在操作系统原生安全存储中，静态加密，永远不会传输到任何 Moraya 服务器。

### 无中间服务器

AI 提示和内容**直接从你的设备发送到供应商 API**。数据路径极其简单：

```text
你的设备 → 供应商 API
```

Moraya 不运营任何中继或代理服务器。认证信息由本地 Rust 后端在请求离开你的设备之前注入。

### 安全加固清单

| 安全措施           | 说明                                   |
| -------------- | ------------------------------------ |
| OS Keychain 存储 | API 密钥使用系统级安全存储                      |
| Rust AI 代理     | 所有外部调用经由 Rust 后端路由                   |
| CSP 强制执行       | `script-src 'self'`，`connect-src` 锁定 |
| MCP 加固         | 命令验证、启动确认、环境变量过滤、僵尸进程防护              |
| 路径遍历保护         | 所有文件操作验证并规范化路径                       |
| HTML 导出消毒      | 基于 DOMParser 的 XSS 防护                |

---

## 五、快速上手

### 安装

直接从 [GitHub Releases](https://github.com/nicepkg/moraya/releases) 下载最新版本。

> **macOS 用户注意**：应用未签名，如果遇到"Moraya 已损坏，无法打开"的提示，在终端执行：

```bash
xattr -cr /Applications/Moraya.app
```

### 开发环境搭建

如果你想参与开发，需要以下环境：

- [Rust](https://www.rust-lang.org/tools/install)（stable）

- [Node.js](https://nodejs.org/)（>=18）

- [pnpm](https://pnpm.io/)（v10.x）

- Tauri v2 系统依赖

```bash
# 安装依赖
pnpm install

# 启动开发服务器（热重载）
pnpm tauri dev

# 仅前端（不启动 Tauri shell）
pnpm dev

# 生产构建
pnpm tauri build
```

### 常用快捷键

| 操作       | macOS         | Windows/Linux  |
| -------- | ------------- | -------------- |
| 新建       | `Cmd+N`       | `Ctrl+N`       |
| 打开       | `Cmd+O`       | `Ctrl+O`       |
| 保存       | `Cmd+S`       | `Ctrl+S`       |
| 设置       | `Cmd+,`       | `Ctrl+,`       |
| 查找       | `Cmd+F`       | `Ctrl+F`       |
| 切换可视化/源码 | `Cmd+/`       | `Ctrl+/`       |
| 切换分屏     | `Cmd+Shift+/` | `Ctrl+Shift+/` |
| 切换 AI 面板 | `Cmd+Shift+I` | `Ctrl+Shift+I` |
| 标题 1–6   | `Cmd+1`–`6`   | `Ctrl+1`–`6`   |
| 加粗       | `Cmd+B`       | `Ctrl+B`       |
| 斜体       | `Cmd+I`       | `Ctrl+I`       |
| 代码块      | `Cmd+Shift+K` | `Ctrl+Shift+K` |

---

## 六、发展路线图

Moraya 的迭代节奏清晰而高效，已完成的版本包括：

- ✅ **v0.1.0** — 核心平台：WYSIWYG 编辑器、数学渲染、多供应商 AI 聊天、MCP 客户端

- ✅ **v0.2.0** — 发布工作流：SEO 助手、AI 图像生成、多目标发布

- ✅ **v0.3.0** — MCP 生态增强：AI 工具调用、预设、知识同步

- ✅ **v0.3.1** — MCP 市场：多源注册表浏览、一键安装

- ✅ **v0.4.0** — 动态 MCP 容器：AI 驱动的动态服务创建

- ✅ **v0.5.0** — RSS 订阅：发布时自动更新 RSS feed

- ✅ **v0.6.0** — 安全加固：Keychain 存储、Rust AI 代理、CSP 加固

- ✅ **v0.8.0** — AI 模板系统：10 大类别、71+ 模板

- ✅ **v0.9.0** — 代码块增强：语言选择器、复制按钮

- ✅ **v0.10.0** — Mermaid 图表：9 种图表类型、懒加载渲染

- ✅ **v0.11.0** — 侧边栏增强：目录记忆、实时刷新、列表/树双视图

---

## 七、总结与思考

Moraya 代表了一种新的编辑器设计哲学：

1. **极简不等于简陋** — 10MB 的体积下，藏着完整的 AI Agent 平台
2. **隐私不是妥协** — BYOK + 无中间服务器 + 本地优先，证明了强大功能和隐私保护可以兼得
3. **MCP 是未来** — 通过标准化协议连接 AI 与工具，编辑器的边界被无限拓展
4. **Rust + Tauri 是正确的选择** — 在性能、安全、体积三个维度上全面优于 Electron

如果你正在寻找一款兼具**优雅写作体验**和**强大 AI 能力**的 Markdown 编辑器，同时又重视**隐私和安全**，Moraya 值得一试。

---

**项目地址**：[GitHub - Moraya](https://github.com/zouwei/moraya)

**许可证**：Apache License 2.0