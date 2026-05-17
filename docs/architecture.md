# Architecture Deep Dive

## 1. System Overview

The Canton RWA Platform provides institutional-grade tokenization of real-world assets on Canton Network, leveraging:

- **Daml smart contracts** for programmable financial logic
- **Canton privacy protocol** for need-to-know data isolation
- **Global Synchronizer** for cross-domain composability
- **Daml Finance library** for standard financial primitives

## 2. Module Architecture

```
RWA.Main
  ├── RWA.Bond         — Bond issuance, coupon lifecycle, maturity
  ├── RWA.Invoice      — Invoice factoring, multi-tier transfer
  ├── RWA.Settlement   — DvP atomic settlement across domains
  ├── RWA.Compliance   — KYC verification, jurisdiction rules
  └── RWA.Oracle       — Price/valuation oracle interface
         │
         ▼
  Daml Finance Library
         │
         ▼
  Canton Network (Global Synchronizer)
```

## 3. Cross-Domain Settlement Flow

```
Domain A (Issuer)          Domain B (Trading)          Domain C (Custodian)
     │                           │                           │
     │  [Bond.Issue]             │                           │
     │────────                   │                           │
     │         [Invoice.Create]  │                           │
     │────────────────────────▶  │                           │
     │                           │                           │
     │         [DvP.Propose]     │                           │
     │────────────────────────▶  │                           │
     │                           │  [DvP.BuyerAccept]         │
     │◀────────────────────────  │─────────────────────────▶│
     │                           │                           │
     │  (Asset transferred)      │  (Funds transferred)      │
     │  (Atomic — both or none) │  (Atomic — both or none) │
```

## 4. Privacy Model

| Data | Visibility |
|------|-------------|
| Bond terms | Issuer + Holders + Designated Observers |
| Invoice terms | Current Creditor + Debtor + Compliance |
| Transfer amounts | Transacting parties only |
| Aggregate stats | Regulatory observer only |
| Prior creditor identities | Not visible (privacy) |

## 5. Compliance Gates

All asset transfers pass through compliance checks:

```
Transfer Request → KYC Check → Jurisdiction Check → DvP Execute
```

## 6. Deployment Topology

```
┌─────────────────────────────────────────────────────┐
│              Canton Validator Network               │
│                                                     │
│  Validator A   Validator B   Validator C  ...      │
│        └────────────┴────────────┘                 │
│                   Global Synchronizer               │
└──────────────────────────┼──────────────────────────┘
                           │
         ┌─────────────────┼─────────────────┐
         ▼                 ▼                 ▼
   ┌──────────┐     ┌──────────┐     ┌──────────┐
   │  Issuer  │     │  Factor  │     │ Custodian│
   └──────────┘     └──────────┘     └──────────┘
```
