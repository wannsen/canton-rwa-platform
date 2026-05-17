# Canton RWA Platform

> 基于 Canton Network 和 Daml Finance 构建的生产级 RWA（真实世界资产）代币化和结算平台

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)
[![Daml SDK](https://img.shields.io/badge/Daml%20SDK-3.0.0-green)](https://docs.daml.com/)

---

## 🎯 项目目标

本项目旨在展示如何在 **Canton Network** 上实现机构级 RWA 代币化，为开发者提供可参考的智能合约实现模式。代码覆盖债券发行、发票保理、跨域结算、合规验证等核心场景。

---

## ✨ 核心功能

| 模块 | 说明 | 状态 |
|------|------|------|
| **债券代币化** | 数字债券，带自动化票息支付和到期处理 | ✅ |
| **发票保理** | 多层发票转让，带 DvP 原子结算 | ✅ |
| **跨域 DvP 结算** | 跨域交付-versus-付款原子结算 | ✅ |
| **合规框架** | KYC/AML + 司法管辖区转账限制 | ✅ |
| **预言机集成** | 外部价格/估值馈送接口 | ✅ |

---

## 🏗️ 系统架构

```
Canton Network
  ├── Issuer Domain (债券、发票发行)
  ├── Trading Domain (DvP 结算，转让)
  ├── Custodian Domain (持仓，合规)
  └── Global Synchronizer

RWA.Main
  ├── RWA.Bond ────────→ 债券发行、票息生命周期、到期处理
  ├── RWA.Invoice ─────→ 发票保理、多层转让
  ├── RWA.Settlement ─→ 跨域原子交付对付（DvP）
  ├── RWA.Compliance ─→ KYC 验证、司法管辖区规则
  └── RWA.Oracle ─────→ 价格/估值预言机接口
           │
           ▼
  Daml Finance Library
           │
           ▼
  Canton Network (Global Synchronizer)
```

---

## 🚀 快速开始

### 前置要求

| 依赖 | 版本 |
|------|------|
| Daml SDK | 3.0.0+ |
| Git | 任意版本 |
| macOS / Linux | - |

### 安装步骤

```bash
# 1. 克隆项目
git clone https://github.com/wannsen/canton-rwa-platform.git
cd canton-rwa-platform

# 2. 安装依赖
chmod +x scripts/get-dependencies.sh
./scripts/get-dependencies.sh

# 3. 编译
daml build

# 4. 运行测试
daml test
```

详细说明请查看 [快速入门指南](./docs/quick-start.md)

---

## 📚 文档

| 文档 | 说明 |
|------|------|
| [📖 快速入门](./docs/quick-start.md) | 5 分钟跑起来 |
| [📚 完整教程](./docs/tutorial.md) | 债券发行全流程演示 |
| [🔧 操作指南](./docs/how-to.md) | 常见开发任务 |
| [🏗️ 架构设计](./docs/architecture.md) | 系统设计详解 |
| [📋 API 参考](./docs/api-reference.md) | 模板和 Choice 详解 |
| [📜 合规模型](./docs/compliance.md) | KYC/AML 合规框架 |
| [🚀 部署指南](./docs/deployment.md) | 多环境部署 |

---

## 📁 项目结构

```
canton-rwa-platform/
├── README.md              # 本文件
├── LICENSE                # Apache-2.0 许可证
├── daml.yaml              # Daml 项目配置
├── CONTRIBUTING.md        # 贡献指南
├── SUPPORT.md             # 支持与反馈
├── scripts/
│   └── get-dependencies.sh # 依赖安装脚本
├── src/daml/
│   └── RWA/
│       ├── Main.daml       # 公共 API 入口
│       ├── Bond.daml       # 债券代币化
│       ├── Invoice.daml    # 发票保理
│       ├── Settlement.daml # DvP 结算
│       ├── Compliance.daml # 合规管理
│       └── Oracle.daml     # 预言机集成
└── docs/
    ├── quick-start.md      # 快速入门
    ├── tutorial.md         # 完整教程
    ├── how-to.md           # 操作指南
    ├── architecture.md      # 架构设计
    ├── api-reference.md    # API 参考
    ├── compliance.md       # 合规模型
    └── deployment.md       # 部署指南
```

---

## 🔧 技术栈

| 技术 | 说明 |
|------|------|
| **Daml** | 智能合约语言 |
| **Daml Finance** | 金融原语库 |
| **Canton Network** | 隐私优先区块链 |
| **Global Synchronizer** | 跨域可组合性 |

---

## 🎓 适用场景

- ✅ Canton Network **Featured App (FA)** 申请参考
- ✅ 学习 Daml 智能合约开发
- ✅ RWA 代币化架构设计参考
- ✅ 金融机构区块链选型评估

---

## 🤝 贡献

欢迎贡献代码！请阅读 [贡献指南](./CONTRIBUTING.md)。

---

## 📄 许可证

本项目采用 [Apache-2.0](./LICENSE) 许可证。

---

## 🙏 支持

如有问题，请提交 [Issue](https://github.com/wannsen/canton-rwa-platform/issues) 或查看 [支持页面](./SUPPORT.md)。

---

*Built with ❤️ for the Canton Network ecosystem*