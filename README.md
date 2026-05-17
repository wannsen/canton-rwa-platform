# Canton RWA Platform

A production-ready RWA (Real-World Asset) tokenization and settlement platform built on Canton Network and Daml Finance.

## Overview

This project demonstrates institutional-grade RWA tokenization capabilities on Canton Network:

- **Bond Tokenization** — Digital bonds with automated coupon payments and maturity handling
- **Invoice Factoring** — Multi-tier invoice transfer with DvP atomic settlement
- **DvP Settlement** — Delivery-versus-Payment atomic cross-domain settlement
- **Compliance Framework** — KYC/AML + jurisdiction-based transfer restrictions
- **Oracle Integration** — External price/valuation feed interface

## Architecture

```
Canton Network
  ├── Issuer Domain (Bond, Invoice issuance)
  ├── Trading Domain (DvP settlement, transfer)
  ├── Custodian Domain (Holdings, compliance)
  └── Global Synchronizer
```

## Modules

| Module | Description |
|--------|-------------|
| `RWA.Bond` | Bond issuance, coupon lifecycle, maturity |
| `RWA.Invoice` | Invoice factoring, multi-tier transfer |
| `RWA.Settlement` | DvP atomic settlement across domains |
| `RWA.Compliance` | KYC verification, jurisdiction rules |
| `RWA.Oracle` | Price/valuation oracle interface |

## Featured App Status

Designed to meet Canton Network FA criteria:
- [x] Production-ready smart contracts
- [x] Atomic DvP settlement
- [x] KYC/AML compliance controls
- [x] Multi-domain architecture
- [x] RWA use case coverage (Bond + Invoice)
- [ ] Smart contract audit (planned)

## License

Apache-2.0
