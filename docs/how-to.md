# How-to Guide | 操作指南

> 解决常见开发任务的实用指南

---

## 目录

- [发行新债券](#发行新债券)
- [修改票息计划](#修改票息计划)
- [添加观察者](#添加观察者)
- [处理转让争议](#处理转让争议)
- [查询持有人列表](#查询持有人列表)
- [批量发行发票](#批量发行发票)
- [配置司法管辖区限制](#配置司法管辖区限制)
- [集成预言机价格](#集成预言机价格)

---

## 发行新债券

### 基本步骤

```daml
-- 1. 定义票息计划
let coupons = [
    CouponPoint with couponDate = date 2026 6 30; annualRate = 0.04; dayCountBasis = "ACT/360",
    CouponPoint with couponDate = date 2026 12 31; annualRate = 0.04; dayCountBasis = "ACT/360"
  ]

-- 2. 创建债券
bondCid <- submit issuer do
  createCmd Bond with
    issuer = myBank
    id = "MY-BOND-001"
    description = "My First Digital Bond"
    currency = "USD"
    faceValue = 5000.0
    issueDate = date 2026 1 1
    maturityDate = date 2027 1 1
    couponSchedule = coupons
    observers = [regulator]
```

### 参数说明

| 参数 | 必填 | 说明 |
|------|------|------|
| `id` | ✅ | 唯一标识符，建议使用 ISIN 格式 |
| `faceValue` | ✅ | 面值，Decimal 类型 |
| `couponSchedule` | ❌ | 空列表表示零息债券 |
| `observers` | ❌ | 默认为空列表 |

---

## 修改票息计划

### 场景：调整利率

债券发行后，利率通常不可直接修改（防止篡改）。但可以通过**再融资**方式：

```daml
-- 创建新债券替换旧债券
newBondCid <- submit issuer do
  createCmd Bond with
    issuer = myBank
    id = "MY-BOND-002"  -- 新 ID
    description = "My First Digital Bond (Refinanced)"
    currency = "USD"
    faceValue = 5000.0
    issueDate = date 2026 7 1
    maturityDate = date 2027 1 1
    couponSchedule = [CouponPoint with couponDate = date 2026 12 31; annualRate = 0.045; dayCountBasis = "ACT/360"]
    observers = [regulator]
```

---

## 添加观察者

### 场景：审计员需要查看债券交易

```daml
-- 给现有债券添加观察者
updatedBondCid <- submit issuer do
  exerciseCmd bondCid AddObserver with
    newObserver = auditor
```

### 查看当前观察者

```daml
-- 查询债券详情
bondDetails <- queryContractId @Bond bondCid
-- bondDetails.observers 返回当前观察者列表
```

---

## 处理转让争议

### 场景：买方声称未收到券

```daml
-- 查看转让提案状态
proposals <- query @BondTransferProposal
  |> filter (\\p -> p.seller == myParty)

-- 如果需要，卖方可以取消提案
submit seller do
  exerciseCmd transferCid SellerCancel
```

### 争议预防措施

```
✓ 在转让前验证持仓数量
✓ 确认买方账户余额充足
✓ 使用预授权机制
```

---

## 查询持有人列表

### 获取所有债券持有人

```daml
-- 查询所有 BondHolding 合约
allHoldings <- query @BondHolding
  |> filter (\\(_, h) -> h.bond == bondCid)

-- 汇总每个持有人的份额
let holderSummary = allHoldings
  |> map (\\(_, h) -> (h.holder, h.units))
  |> groupBy fst
  |> map (\\(party, units) -> party -> sum units)
```

---

## 批量发行发票

### 场景：一次发行 100 张发票

```daml
-- 生成发票批次
let invoiceData = map (\\i ->
  InvoiceData with
    id = "INV-2026-" <> show i
    debtor = clientA
    amount = 10000.0 + fromIntegral i * 100
    dueDate = date 2026 6 30
  ) [1..100]

-- 批量创建
invoiceCids <- submit factoringCompany do
  createMultipleCmd $ map (\\inv ->
    Invoice with
      originalCreditor = factoringCompany
      debtor = inv.debtor
      invoiceId = inv.id
      amount = inv.amount
      currency = "USD"
      issueDate = date 2026 1 1
      dueDate = inv.dueDate
      isDisputed = False
      previousHolders = []
    ) invoiceData
```

---

## 配置司法管辖区限制

### 场景：限制某些地区投资者

```daml
-- 创建司法管辖区规则
regionCid <- submit complianceOfficer do
  createCmd JurisdictionRestriction with
    jurisdiction = "US"
    allowedParties = [usQualifiedInvestor1, usQualifiedInvestor2]
    restrictedParties = [nonQualifiedInvestor]
    complianceOfficer = complianceOfficer

-- 在转让时自动检查
submitMustFail nonQualifiedInvestor do
  exerciseCmd transferCid BuyerAccept  -- 会被拒绝
```

---

## 集成预言机价格

### 场景：获取实时美元/人民币汇率

```daml
-- 预言机发布价格
priceCid <- submit oracle do
  createCmd PriceOracle with
    provider = oracle
    baseCurrency = "USD"
    quoteCurrency = "CNY"
    rate = 7.25  -- 1 USD = 7.25 CNY
    timestamp = time (DA.Date.date 2026 5 17) 0 0 0

-- 债券相关方读取价格
priceData <- fetch @PriceOracle priceCid
let currentRate = priceData.rate
```

---

## 调试技巧

### 查看所有活跃合约

```daml
-- 在 Daml REPL 中
ledger dump
```

### 追踪特定合约

```daml
-- 按 ID 搜索
let targetBondId = "BOND-2026-001"
bonds <- query @Bond
matched <- filter (\\(_, b) -> b.id == targetBondId) bonds
```

### 模拟错误场景

```daml
-- 测试权限不足
submitMustFail unauthorizedParty do
  exerciseCmd bondCid AddObserver with newObserver = someParty
```

---

## 最佳实践

| 场景 | 建议 |
|------|------|
| 债券 ID | 使用 ISIN 标准格式：`XX1234567890` |
| 金额精度 | 使用 Decimal，建议 2 位小数 |
| 票息计算 | 采用 "ACT/360" 国际标准 |
| 观察者 | 仅添加必要方，保护隐私 |
| 测试 | 先用 Daml Script 写端到端测试 |

---

## 相关文档

- 📖 [完整教程](./tutorial.md) — 概念和流程
- 🏗️ [架构文档](./architecture.md) — 系统设计
- 📋 [API 参考](./api-reference.md) — 模板和 Choice 详解