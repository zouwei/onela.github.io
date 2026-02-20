***

title: 我写了一个极简又强大的 AI Markdown 编辑器：Moraya
tags:

* Moraya

* AI

* Markdown

* MCP

***

## toc

我写了一个极简又强大的 AI Markdown 编辑器：Moraya

## 前言

作为一个长期用 Markdown 写技术笔记和博客的人，我一直在寻找一个**真正好用**的 Markdown 编辑器。市面上的编辑器要么太臃肿，要么 AI 能力只是个噱头，要么就是对本地文件系统支持不好。于是我决定自己动手，写一个**极简但强大**的 AI Markdown 编辑器 —— [Moraya](https://github.com/zouwei/moraya)。

## Moraya 是什么？

**Moraya** 是一款基于 Electron 的桌面端 AI Markdown 编辑器，核心理念是：

> **极简设计 + AI 原生 + MCP 协议扩展 = 无限可能**

它不是又一个套壳的 Markdown 编辑器，而是一个将 AI 能力深度融入写作工作流的生产力工具。你可以把它理解为一个**会思考、能操作、可扩展的写作助手**。

## 核心特性

### 🎯 极简 Markdown 编辑

* 基于 CodeMirror 6 构建的高性能编辑器

* 实时预览，所见即所得

* 支持 GFM（GitHub Flavored Markdown）语法

* 代码块语法高亮

* 本地文件系统直接读写，无需导入导出

### 🤖 AI 原生集成

这是 Moraya 最核心的能力。内置 AI 助手可以：

* **辅助写作**：帮你润色、续写、总结、翻译文档内容

* **智能对话**：基于当前文档上下文进行对话，AI 真正"读懂"你正在写的内容

* **文档操作**：AI 不仅能聊天，还能直接编辑、创建、修改你的 Markdown 文件

支持配置多种大语言模型（LLM），包括 OpenAI、Anthropic Claude、Google Gemini 等主流模型，通过标准的 API 接口接入。

### 🔌 MCP 协议支持（Model Context Protocol）

这是 Moraya 的**杀手级特性**。MCP 是 Anthropic 提出的开放协议，让 AI 模型能够安全地与外部工具和数据源交互。Moraya 完整支持 MCP 协议：

* **内置文件系统 MCP Server**：AI 可以直接读写本地文件、浏览目录结构

* **支持添加第三方 MCP Server**：一键接入数据库、API、搜索引擎等各种外部工具

* **动态创建 MCP 服务**：无需安装任何东西，AI 可以在运行时动态创建临时的 MCP 服务来调用 HTTP API

* **stdio 和 HTTP/SSE 双传输协议**：兼容几乎所有 MCP Server 实现

这意味着你可以让 AI 在写作过程中：

* 查询数据库获取数据

* 调用 REST API 获取实时信息

* 搜索网络资料

* 操作 GitHub、Notion 等第三方服务

* 甚至自定义任何你需要的工具

### 🖥️ 跨平台桌面应用

* 基于 Electron 构建

* 支持 **macOS**、**Windows**、**Linux** 三大平台

* 原生文件系统集成，像操作本地文件一样自然

## 技术架构

Moraya 的技术栈非常现代：

| 层级    | 技术                                |
| ----- | --------------------------------- |
| 框架    | Electron                          |
| 前端    | React + TypeScript                |
| 编辑器   | CodeMirror 6                      |
| AI 集成 | Anthropic Claude SDK / OpenAI SDK |
| 工具协议  | MCP (Model Context Protocol)      |
| 构建工具  | Vite + electron-builder           |

整体架构分为三层：

1. **编辑器层**：负责 Markdown 的编辑、预览、语法高亮
2. **AI 层**：负责与大语言模型通信、管理对话上下文、处理工具调用
3. **MCP 层**：负责管理 MCP Server 的生命周期、工具发现与调用

## 为什么选择 Moraya？

### 对比其他编辑器

| 特性       | Moraya | Typora | Obsidian | VS Code |
| -------- | ------ | ------ | -------- | ------- |
| AI 原生集成  | ✅      | ❌      | 插件       | 插件      |
| MCP 协议支持 | ✅      | ❌      | ❌        | 插件      |
| 动态创建工具   | ✅      | ❌      | ❌        | ❌       |
| 本地文件直接操作 | ✅      | ✅      | ✅        | ✅       |
| 极简设计     | ✅      | ✅      | ❌        | ❌       |
| 免费开源     | ✅      | ❌      | 部分       | ✅       |

Moraya 的独特优势在于：**它不只是一个编辑器，而是一个 AI 驱动的写作平台**。通过 MCP 协议，它的能力边界几乎是无限的。

## 快速开始

### 安装

前往 [GitHub Releases](https://github.com/zouwei/moraya/releases) 下载对应平台的安装包：

* **macOS**：`.dmg` 文件

* **Windows**：`.exe` 安装程序

* **Linux**：`.AppImage` 或 `.deb` 包

### 配置 AI 模型

安装后，你需要配置至少一个 AI 模型：

1. 打开设置页面
2. 添加你的 LLM 提供商（如 OpenAI、Anthropic 等）
3. 填入 API Key
4. 选择模型（推荐 Claude Sonnet 或 GPT-4o）

### 开始使用

1. 打开一个本地文件夹作为工作目录
2. 创建或打开一个 `.md` 文件
3. 开始写作，随时呼唤 AI 助手帮忙

## 使用场景

* **技术博客写作**：AI 帮你查资料、润色文字、生成代码示例

* **学习笔记整理**：AI 帮你总结、归纳、生成知识框架

* **项目文档编写**：通过 MCP 连接代码仓库，AI 自动生成 API 文档

* **日常写作**：翻译、改写、扩写，让 AI 成为你的写作搭档

## 开源与社区

Moraya 是一个完全开源的项目，代码托管在 GitHub：

🔗 **仓库地址**：<https://github.com/zouwei/moraya>

欢迎 Star ⭐、Fork 🍴、提 Issue 和 PR！

如果你也在寻找一个**简洁、强大、AI 原生**的 Markdown 编辑器，不妨试试 Moraya。

## 最后

写 Moraya 的初衷很简单：**我想要一个真正懂我的编辑器**。它不需要花哨的功能，但每一个功能都要真正好用。AI 不应该是一个独立的聊天窗口，而应该融入到写作的每一个环节中。

有趣的是，**这篇文章就是用 Moraya 写的** 😄。
