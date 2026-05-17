# API Reference — Canton RWA Platform

## Bond Module (`RWA.Bond`)

### Templates
#### `Bond`
| Field | Type | Description |
|-------|------|-------------|
| `issuer` | `Party` | Issuing institution |
| `id` | `Text` | ISIN or internal ID |
| `currency` | `Text` | Settlement currency |
| `faceValue` | `Decimal` | Per-unit face value |
| `couponSchedule` | `[CouponPoint]` | Scheduled coupon payments |

#### `CouponPoint`
| Field | Type | Description |
|-------|------|-------------|
| `couponDate` | `Date` | Scheduled payment date |
| `annualRate` | `Decimal` | Annual rate (e.g. 0.0375 = 3.75%) |

### Choices
| Choice | Controller | Returns |
|--------|-----------|--------|
| `BondHolding` | issuer | `ContractId BondHolding` |
| `CouponPayout` | issuer | `ContractId PendingCoupon` |
| `SkipCoupon` | issuer | `ContractId PendingCoupon` |
| `BuyerAccept` | buyer | `ContractId BondTransferProposal` |

---

## Invoice Module (`RWA.Invoice`)

### Templates
#### `Invoice`
| Field | Type | Description |
|-------|------|-------------|
| `debtor` | `Party` | Buyer / obligor |
| `creditor` | `Party` | Current holder of claim |
| `amount` | `Decimal` | Face value |
| `status` | `InvoiceStatus` | Current state |

### Status Machine
```
Issued → Confirmed → Transferred → Settled
                ↘ Disputed
```

---

## Settlement Module (`RWA.Settlement`)

### Templates
#### `DvPSettlement`
| Field | Type | Description |
|-------|------|-------------|
| `seller` | `Party` | Asset deliverer |
| `buyer` | `Party` | Asset receiver |
| `assetType` | `Text` | Asset class (BOND/INVOICE) |
| `paymentNetwork` | `Text` | Payment rail |
| `status` | `SettlementStatus` | Current state |

### Status Machine
```
Proposed → Settled (both consent)
Proposed → Aborted (rejected/cancelled)
```

---

## Compliance Module (`RWA.Compliance`)

### KYC Status Flow
```
Pending → Verified → Expired | Revoked | Blacklisted
```

---

## Oracle Module (`RWA.Oracle`)

### Price Status Flow
```
Pending → Confirmed (or Disputed / Expired)
```
