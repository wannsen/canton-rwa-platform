# Quick Start Guide | 快速入门

> 5 分钟内在本地运行 Canton RWA Platform

---

## 前置要求

| 依赖 | 版本 | 说明 |
|------|------|------|
| Daml SDK | 3.0.0+ | [官方安装指南](https://docs.daml.com/getting-started/installation.html) |
| Git | 任意版本 | 代码管理 |
| macOS / Linux | - | Windows 需 WSL2 |

---

## 第一步：克隆项目

```bash
git clone https://github.com/wannsen/canton-rwa-platform.git
cd canton-rwa-platform
```

---

## 第二步：安装依赖

```bash
chmod +x scripts/get-dependencies.sh
./scripts/get-dependencies.sh
```

此脚本会自动：
- 验证 Daml SDK 版本
- 下载 daml-finance 依赖
- 配置项目环境

---

## 第三步：编译项目

```bash
daml build
```

预期输出：
```
✓ Compiling RWA.Bond
✓ Compiling RWA.Invoice
✓ Compiling RWA.Settlement
✓ Compiling RWA.Compliance
✓ Compiling RWA.Oracle
✓ Compiling RWA.Main
Build succeeded.
```

---

## 第四步：运行测试

```bash
daml test
```

这会执行所有模块的内置测试，包括：
- 债券发行和票息支付
- 发票创建和转让
- DvP 原子结算
- KYC 合规检查

---

## 第五步：启动 Sandbox（可选）

```bash
daml sandbox
```

在浏览器打开 `http://localhost:7500` 可用 Daml REPL 交互探索合约。

---

## 下一步

- 📖 [完整教程](./tutorial.md) — 一步步构建债券发行场景
- 🔧 [操作指南](./how-to.md) — 常见开发任务
- 🏗️ [架构文档](./architecture.md) — 系统设计详解

---

## 遇到问题？

| 问题 | 解决方案 |
|------|----------|
| `daml: command not found` | 重新安装 Daml SDK 并配置 PATH |
| `dependency not found` | 运行 `./scripts/get-dependencies.sh` |
| 编译报错 | 确认 SDK 版本为 3.0.0+ |

如仍有问题，欢迎提交 [Issue](https://github.com/wannsen/canton-rwa-platform/issues)。