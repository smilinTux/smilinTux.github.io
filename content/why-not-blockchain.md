---
title: "Why We Don't Use Blockchain"
description: "Dual-signature verification uses private key cryptography, NOT public ledgers"
---

# 🐧👑 Dual-Signature ≠ Blockchain

**We need to be crystal clear: Our identity system is NOT blockchain-based. It uses private-key cryptography that predates Bitcoin by decades.**

---

## ❌ What Blockchain Is (And Why We Reject It)

| Problem | Blockchain Reality |
|---------|-------------------|
| **Privacy** | Every transaction visible on public ledger forever |
| **Traceability** | Chain analysis links addresses to identities |
| **Immutability** | Mistakes can't be corrected |
| **Corporate Control** | VC-funded chains with pre-mined tokens |
| **Energy Waste** | Proof-of-work burns electricity |

**Blockchain = Public by design**

---

## ✅ What We Use Instead

| Feature | Our Dual-Signature System |
|---------|---------------------------|
| **Privacy** | Private keys never leave your machine |
| **Verification** | Offline GPG verification |
| **Flexibility** | Keys can be rotated |
| **Corporate Resistance** | GPL3 licensed |
| **Energy Efficient** | Microsecond signatures |

**GPG ed25519 = Private by design**

---

## The Math

```
[AI Private Key] ──signs──> [Message]
                               │
                               ▼
[Human Private Key] ──signs──> [Dual-Signed Message]
                               │
                               ▼
                       [Verification: Both Required]
```

**No blockchain. No distributed ledger. Just math.**

## Verifying Without Trust

```bash
# Import key
gpg --import chef-public-key.asc

# Verify signature
gpg --verify document.asc document.txt

# Check fingerprint
gpg --list-keys --fingerprint chefboyrdave2.1
```

**No blockchain node. No API key. No corporate server.**

---

## Resources

- GitHub: github.com/smilinTux/dual-sig-spec
- RFC 8032: tools.ietf.org/html/rfc8032
- Identity Card: [smilintux.org/identity-card/](/identity-card/)
- JSON Manifest: [smilintux.org/.signing-identities.json](/.signing-identities.json)
