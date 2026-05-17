# Tutorial | 完整教程

> 从零开始，完整体验 RWA 代币化流程

---

## 教程目标

本教程带你完成一个完整的**债券代币化**流程：
1. 发行一只数字债券
2. 投资者认购
3. 票息周期支付
4. 转让交易
5. 到期赎回

---

## 场景设定

```
发行方: Bank (银行)
投资者: Investor (投资机构)
监管方: Regulator (监管机构)
债券:   年利率 5%，每半年付息，3 年到期，面值 $10,000
```

---

## 第一课：发行债券

### 概念

债券发行方创建数字债券合约，定义债券的所有条款。

### 代码示例

```daml
-- 定义票息计划（每6个月支付一次）
let couponSchedule = [
    CouponPoint with couponDate = date 2026 6 30; annualRate = 0.05; dayCountBasis = "ACT/360",
    CouponPoint with couponDate = date 2026 12 31; annualRate = 0.05; dayCountBasis = "ACT/360",
    CouponPoint with couponDate = date 2027 6 30; annualRate = 0.05; dayCountBasis = "ACT/360",
    CouponPoint with couponDate = date 2027 12 31; annualRate = 0.05; dayCountBasis = "ACT/360",
    CouponPoint with couponDate = date 2028 6 30; annualRate = 0.05; dayCountBasis = "ACT/360",
    CouponPoint with couponDate = date 2028 12 31; annualRate = 0.05; dayCountBasis = "ACT/360"
  ]

-- 发行债券
bondCid <- submit bank do
  createCmd Bond with
    issuer = bank
    id = "BOND-2026-001"
    description = "Corporate Bond Series 2026"
    currency = "USD"
    faceValue = 10000.0
    issueDate = date 2026 1 1
    maturityDate = date 2029 1 1
    couponSchedule = couponSchedule
    observers = [regulator]
```

### 运行结果

```
✓ 债券 BOND-2026-001 已创建
  发行方: Bank
  面值: $10,000 USD
  年利率: 5%
  到期日: 2029-01-01
```

---

## 第二课：投资者认购

### 概念

投资者通过 `BondHolding` 模板持有债券份额。

### 代码示例

```daml
-- 投资者认购 10 单位
holdingCid <- submit investor do
  createCmd BondHolding with
    bond = bondCid
    holder = investor
    units = 10.0
    lastCouponDate = date 2026 1 1
```

---

## 第三课：票息支付

### 概念

债券发行方在票息日触发票息支付，资金自动分配给持有人。

### 代码示例

```daml
-- 创建待支付票息
couponCid <- submit bank do
  createCmd PendingCoupon with
    bond = bondCid
    holder = investor
    couponDate = date 2026 6 30
    amount = 250.0  -- $10,000 × 5% × 6/12 = $250

-- 投资者确认收到票息
submit investor do
  exerciseCmd couponCid CouponPayout
```

### 收益计算

```
面值: $10,000
年利率: 5%
票息期间: 6 个月
本次票息: $10,000 × 5% × (180/360) = $250
```

---

## 第四课：债券转让（带 DvP）

### 概念

投资者可以将债券转让给另一个投资者，通过 DvP 保证"券过款到"的原子性。

### 代码示例

```daml
-- 原持有人发起转让提案（附转让价格）
transferCid <- submit investor do
  createCmd BondTransferProposal with
    bond = bondCid
    seller = investor
    buyer = newInvestor
    units = 5.0
    price = 5000.0  -- 单价 $1000，共 5 单位
    settlementDate = date 2026 7 1

-- 买方接受，完成原子结算
submit newInvestor do
  exerciseCmd transferCid BuyerAccept
```

### DvP 原子性保证

```
传统结算风险:
  ✗ 买方付款后，卖方拒绝交券 → 买方损失
  ✗ 卖方交券后，买方拒绝付款 → 卖方损失

DvP 原子结算:
  ✓ 券和款同时转移，要么全部成功，要么全部回滚
```

---

## 第五课：到期赎回

### 概念

债券到期时，发行方偿还本金，持有人交回债券。

```daml
-- 到期后，持有人将债券转为赎回请求
submit investor do
  exerciseCmd holdingCid RequestMaturity with
    redemptionDate = date 2029 1 1

-- 发行方执行赎回
submit bank do
  exerciseCmd redemptionCid Redeem with
    principal = 10000.0
```

---

## 扩展：发票保理流程

除了债券，本平台也支持发票代币化。

```
核心流程:
1. 发票创建 (Invoice.Create)
2. 多层转让 (Invoice.Transfer)
3. 打包融资 (Invoice.Batch)
4. DvP 结算 (DvP.Settle)
```

详见 [API 参考](./api-reference.md)

---

## 清理环境

```bash
# 退出 Sandbox
# Ctrl + C

# 或重置测试数据
daml sandbox --reset
```

---

## 下一步

- 🔧 [操作指南](./how-to.md) — 如何修改票息、添加观察者
- 🏗️ [架构文档](./architecture.md) — 理解跨域结算原理
- 📋 [API 参考](./api-reference.md) — 所有模板字段和 Choice 详解

---

## 常见问题

**Q: 如何添加新的债券条款？**
A: 修改 `Bond.daml` 中的模板字段，或在 `CouponPoint` 中添加新的日期点。

**Q: 转让需要双方都签名吗？**
A: 是的。Daml 的权限模型要求控制者明确授权操作。

**Q: 能否批量创建多个债券？**
A: 可以，使用 `mapA` 或 `forA` 循环批量提交。