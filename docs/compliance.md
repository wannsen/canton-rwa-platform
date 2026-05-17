# Compliance Model

## 1. KYC/AML Framework

### KYC Verification States

```
Pending → Verified → Expired | Revoked | Blacklisted
```

- **Verified**: KYC passed; party may transact
- **Expired**: Annual renewal overdue; transactions blocked
- **Revoked**: Compliance issue found; transactions blocked
- **Blacklisted**: Sanctions match; permanent block

## 2. Jurisdiction Rules

Cross-border transfers are subject to jurisdiction restrictions:

- **Whitelist**: Only transfers between approved jurisdictions allowed
- **Blacklist**: Transfers involving restricted parties blocked

**Supported Jurisdictions:** US, EU, HK, SG, UAE

## 3. Privacy vs. Compliance Balance

| What Regulators CAN See | What Regulators CANNOT See |
|------------------------|---------------------------|
| Aggregate transaction volumes | Individual transaction details |
| Number of active participants | Party identities |
| Total assets under management | Specific contract terms |
| Geographic distribution | Prior creditor identities |

## 4. Audit Trail

```
Contract State Change → Daml Transaction → Cryptographic Hash → Validator Signatures → Immutable Audit Record
```
