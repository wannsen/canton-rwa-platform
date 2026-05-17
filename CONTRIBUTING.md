# Contributing Guide | 贡献指南

感谢你关注 Canton RWA Platform！欢迎贡献代码和文档。

---

## 如何贡献

### 报告问题

通过 [GitHub Issues](https://github.com/wannsen/canton-rwa-platform/issues) 报告：

- 🐛 Bug 报告
- 💡 功能建议
- 📖 文档改进

### 提交代码

1. **Fork 仓库**
   ```bash
   git clone https://github.com/wannsen/canton-rwa-platform.git
   cd canton-rwa-platform
   ```

2. **创建分支**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **开发 & 测试**
   ```bash
   daml build
   daml test
   ```

4. **提交**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   git push origin feature/your-feature-name
   ```

5. **创建 Pull Request**

---

## 代码规范

### Daml 代码风格

```daml
-- ✅ 推荐：清晰的命名和注释
-- 创建债券并设置观察者
bondCid <- submit bank do
  createCmd Bond with
    issuer = bank
    id = "BOND-001"
    -- ...

-- ❌ 避免：模糊的变量名
b <- submit x do
  createCmd Bond with i = "B"
```

### 提交信息格式

```
<type>(<scope>): <description>

[可选正文]

[可选脚注]
```

类型：
- `feat`: 新功能
- `fix`: 修复 Bug
- `docs`: 文档变更
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 杂项

示例：
```
feat(bond): add callable bond feature

- Add Bond.Call choice for early redemption
- Update maturity calculation logic

Closes #12
```

---

## 模块责任

| 模块 | 负责人 | 说明 |
|------|--------|------|
| `RWA.Bond` | @wannsen | 债券发行核心逻辑 |
| `RWA.Invoice` | @wannsen | 发票保理流程 |
| `RWA.Settlement` | @wannsen | DvP 结算引擎 |
| `RWA.Compliance` | @wannsen | 合规框架 |
| `RWA.Oracle` | @wannsen | 预言机集成 |

---

## 测试要求

- 所有新功能必须有对应的测试
- 运行完整测试套件：
  ```bash
  daml test --all
  ```
- 测试覆盖率目标：80%+  

---

## 许可

贡献的代码将采用 [Apache-2.0](../LICENSE) 许可证。

---

## 行为准则

我们承诺营造一个友好的社区环境：
- 尊重他人
- 建设性反馈
- 关注代码而非人身

感谢每一位贡献者！