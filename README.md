[README.md](https://github.com/user-attachments/files/32649353/README.md)
# NetAudit AI

**AI-Driven Multi-Vendor Network Security Compliance Auditor**

**Smart India Hackathon 2026 — Problem Statement: SIH26155**

NetAudit AI is a multi-vendor network security compliance auditing platform designed to analyze network configurations, normalize vendor-specific syntax, identify security-policy violations, correlate evidence, detect configuration drift, and provide lockout-safe remediation workflows.

The system is designed with an **air-gapped / sovereign deployment model** so that sensitive network configuration data can remain inside the organization's environment.

---

## Key Capabilities

- Multi-vendor configuration auditing
  - Cisco IOS-XE
  - Fortinet FortiOS
  - Palo Alto PAN-OS
- AST-based indentation de-nesting for hierarchical CLI configurations
- YANG-style normalized representation
- Deterministic compliance evaluation
- OPA/Rego policy-oriented compliance architecture
- BYOD vendor-manual ingestion and local RAG workflow
- Active-learning uncertainty gate for unmapped syntax
- SHA-256 based temporal configuration drift detection
- Line-level forensic evidence and provenance
- Lockout-safe remediation using dependency-aware DAG execution
- Role-oriented views for:
  - Network Engineer
  - SOC Analyst
  - CISO
- Single-device compliance audit reporting
- Air-gapped/local deployment architecture

---

## Architecture

```text
┌──────────────────────────────────────────────────────────────┐
│                    NetAudit AI                               │
├──────────────────────────────────────────────────────────────┤
│  Configs + Vendor Manuals                                    │
│             │                                                │
│             ▼                                                │
│  AST Indentation De-Nester                                   │
│             │                                                │
│             ▼                                                │
│  YANG-Style Normalization                                    │
│             │                                                │
│             ▼                                                │
│  Active RAG / Uncertainty Gate                               │
│             │                                                │
│             ▼                                                │
│  Deterministic Compliance / OPA-Rego Policies                │
│             │                                                │
│       ┌─────┴──────────────┐                                 │
│       ▼                    ▼                                 │
│  Drift Analytics     Lockout-Safe DAG                        │
│       │                    │                                 │
│       └──────────┬─────────┘                                 │
│                  ▼                                           │
│       Audit Console / PDF Report                             │
└──────────────────────────────────────────────────────────────┘
```

---

## Technology Stack

### Frontend
- HTML / JavaScript interface
- Tailwind CSS
- Font Awesome
- Role-based audit console

### Backend
- Python 3.11+
- FastAPI
- Pydantic
- Uvicorn

### Compliance & Network Processing
- AST-style configuration parsing
- YANG-style normalization
- OPA/Rego policy architecture
- Netmiko / NAPALM integration architecture

### RAG / NLP
- Sentence Transformers
- ChromaDB
- Local SLM / Ollama architecture
- PyMuPDF for vendor documentation extraction

### Persistence / Analytics
- PostgreSQL
- Redis
- SHA-256 configuration fingerprints

---

## Supported Vendor Configuration Examples

### Cisco IOS-XE

```text
hostname CORE-ROUTER-01

line vty 0 4
 transport input telnet ssh
 no exec-timeout
```

### Fortinet FortiOS

```text
config system global
    set hostname EDGE-FW-01
    set admintimeout 0
end
```

### Palo Alto PAN-OS

```text
set deviceconfig system hostname PA-DC-01
set cli timeout 0
set ssh enable
```

These configurations can be used to demonstrate detection of insecure management settings and compliance violations.

---

## Example Security Controls

NetAudit AI can evaluate security intents such as:

| Security Intent | Example Finding |
|---|---|
| Administrative timeout | Missing or disabled inactivity timeout |
| Secure management transport | Telnet enabled alongside SSH |
| Configuration hardening | Vendor-specific hardening control not satisfied |
| Configuration drift | Current configuration differs from baseline |
| Evidence provenance | Finding linked to the exact configuration line |

---

## Lockout-Safe Remediation

Network remediation must not accidentally disconnect the administrator.

The remediation workflow therefore follows dependency-aware execution:

```text
Verify RSA / Cryptographic Keys
              ↓
Enable / Validate SSH
              ↓
Reachability & Lockout-Safety Gate
              ↓
Disable Legacy Telnet
              ↓
Commit / Rollback Checkpoint
```

The objective is to ensure that a safer management channel is validated before an insecure channel is removed.

---

## Configuration Drift

NetAudit AI uses configuration fingerprints to compare historical snapshots.

```text
Baseline Configuration
        │
        ▼
    SHA-256 Hash
        │
        ▼
Current Configuration
        │
        ▼
    SHA-256 Hash
        │
        ▼
Drift Detection
        │
        ▼
Line-Level Difference / Evidence
```

This supports identification of configuration changes between audit points.

---

## Active Learning / RAG Workflow

Vendor documentation can be supplied locally.

```text
Vendor PDF
    ↓
PyMuPDF Extraction
    ↓
Sentence-Transformer Embeddings
    ↓
ChromaDB
    ↓
Semantic Matching
    ↓
Uncertainty Gate
    ↓
Analyst Binding for Unknown Syntax
```

The architecture is intended to allow new vendor syntax and documentation knowledge to be incorporated without changing the complete application architecture.

---

## Repository Structure

```text
NetAudit-AI/
│
├── backend/
│   ├── main.py
│   └── requirements.txt
│
├── frontend/
│   ├── index.html
│   └── assets/
│
├── test_files/
│   ├── cisco_bad_config.cfg
│   ├── fortinet_bad_config.conf
│   ├── paloalto_bad_config.conf
│   ├── drift_T0_baseline.cfg
│   └── drift_T1_current.cfg
│
├── RUN_NETAUDIT_AI.bat
├── FIX_BACKEND_DEPENDENCIES.bat
└── README.md
```

---

## Quick Start — Windows

### 1. Clone the repository

```bash
git clone https://github.com/yeshwanth80/NetAudit-AI.git
cd NetAudit-AI
```

### 2. Start NetAudit AI

Run:

```text
RUN_NETAUDIT_AI.bat
```

The launcher starts the backend and local frontend required for the demonstration.

### 3. Open the application

The launcher will provide the local URL. Open it in a browser.

For a typical local setup:

```text
http://127.0.0.1:8000
```

---

## Backend Manual Start

If the launcher is not used:

```bash
cd backend
python -m pip install -r requirements.txt
uvicorn main:app --host 127.0.0.1 --port 8000
```

The backend health endpoint is:

```text
http://127.0.0.1:8000/api/v1/health
```

---

## API Endpoints

The demonstration backend exposes the following API routes:

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/api/v1/health` | Backend health check |
| POST | `/api/v1/audit` | Audit a network configuration |
| POST | `/api/v1/dag/execute` | Execute remediation DAG workflow |
| POST | `/api/v1/rag/index` | Index vendor documentation |
| POST | `/api/v1/active-learning/bind` | Bind previously unknown syntax |
| GET | `/api/v1/active-learning/query` | Query active-learning information |
| POST | `/api/v1/drift/compare` | Compare configuration snapshots |

---

## Testing

The repository includes sample configurations for demonstration.

### Cisco test

Upload:

```text
test_files/cisco_bad_config.cfg
```

Expected examples include insecure Telnet exposure and disabled VTY inactivity timeout.

### Fortinet test

Upload:

```text
test_files/fortinet_bad_config.conf
```

Expected example includes an administrative timeout configuration requiring compliance evaluation.

### Palo Alto test

Upload:

```text
test_files/paloalto_bad_config.conf
```

Expected example includes CLI timeout and SSH-related configuration.

### Drift test

Use:

```text
test_files/drift_T0_baseline.cfg
test_files/drift_T1_current.cfg
```

The two configurations demonstrate a baseline/current configuration comparison.

---

## Security Design

NetAudit AI follows a defense-oriented architecture:

1. Network configuration data is processed locally.
2. Vendor syntax is normalized before policy evaluation.
3. Compliance decisions are designed to be deterministic.
4. Findings retain configuration evidence.
5. Remediation follows dependency-aware execution.
6. Drift analysis uses cryptographic configuration fingerprints.
7. External AI/API dependency is not required for the core demonstration architecture.

---

## Intended Users

### Network Engineer
- Configuration analysis
- Line-level findings
- Configuration differences
- Remediation commands

### SOC Analyst
- Security findings
- Severity triage
- Configuration drift
- Evidence correlation

### CISO
- Compliance overview
- Fleet-level security posture
- Control coverage
- Risk and drift visibility

---

## Compliance / Reference Frameworks

The architecture documentation references alignment with:

- NCIIPC Critical Information Infrastructure guidance
- CIS Benchmarks
- NIST SP 800-53 Rev. 5
- DISA STIGs
- ISO/IEC 27001:2022

These references describe the intended compliance mapping architecture; individual controls should be validated against the applicable version and organizational requirements before production use.

---

## Research & Innovation Areas

The project focuses on combining:

- Multi-vendor configuration normalization
- Deterministic compliance evaluation
- Local RAG-assisted vendor knowledge
- Active learning for unmapped syntax
- Temporal configuration drift
- Line-level forensic provenance
- Lockout-safe remediation DAGs
- Air-gapped cybersecurity deployment

---

## Project

**NetAudit AI**  
Smart India Hackathon 2026  
**Problem Statement:** SIH26155 — AI-Driven Multi-Vendor Network Security Compliance Auditor

Repository:

https://github.com/yeshwanth80/NetAudit-AI

