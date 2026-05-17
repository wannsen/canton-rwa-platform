# Deployment Guide

## Prerequisites

- Daml SDK 3.x
- Canton CLI 2.x
- Canton Network connectivity (MainNet or TestNet)
- Node.js 18+ (for UI components)

## 1. Build

```bash
cd canton-rwa-platform
./scripts/get-dependencies.sh
daml build
```

## 2. Deploy to Canton Ledger

### Local Sandbox (Development)

```bash
canton -c canton.conf
```

### TestNet

```bash
canton -c canton-testnet.conf
```

## 3. Upload DAR Package

```bash
daml upload_dar ./.dist-dir/*.dar --host localhost --port 6865
```

## 4. Allocate Parties

```bash
canton participants.local participants.admin.parties.create "issuer"
canton participants.local participants.admin.parties.create "factor"
canton participants.local participants.admin.parties.create "custodian"
canton participants.local participants.admin.parties.create "compliance"
canton participants.local participants.admin.parties.create "regulator"
```

## 5. Smart Contract Audit

Before applying for FA designation, engage a qualified auditor:

- Quantstamp
- Trail of Bits
- OpenZeppelin (via Digital Asset referral)
