# Red Hat OpenShift AI — Model Deployment Workshop

A hands-on workshop (~2 hours) for deploying AI models on Red Hat OpenShift AI (RHOAI) 3.4, with LlamaStack and Open WebUI for chat and RAG — plus a live instructor demo of MCP tool calling via the AI Playground.

## Quick Start

Participants clone this repo in the OpenShift Web Terminal, then follow the guide:

```bash
git clone https://github.com/gymnatics/Red-Hat-Inference-Workshop.git
cd Red-Hat-Inference-Workshop
```

See [RHOAI-MODEL-DEPLOYMENT-WORKSHOP.md](RHOAI-MODEL-DEPLOYMENT-WORKSHOP.md) for the full workshop guide.

## What's in This Repo

| File | Purpose |
|------|---------|
| `RHOAI-MODEL-DEPLOYMENT-WORKSHOP.md` | Workshop guide (9 hands-on parts + instructor demos) |
| `manifests/open-webui.yaml` | Open WebUI v0.9.0 (5 resources) |
| `manifests/mcp-server.yaml` | Kubernetes MCP server (reference — used by instructor setup) |
| `manifests/llamastack.yaml` | LlamaStack deployment (reference — not used in hands-on) |
| `show-urls.sh` | Helper script that prints all URLs participants need |
| `images/` | Screenshots for the guide |

## Workshop Flow

**Hands-on (Parts 1-9):** Participants deploy a model and Open WebUI — then test LLM chat and RAG.

**Instructor Demos:** The instructor demonstrates MCP tool calling via the AI Playground and walks through observability dashboards.

## Tech Stack

- RHOAI 3.4, OCP 4.20+
- Qwen3-4B (vLLM with tool calling)
- Open WebUI v0.9.0
- Kubernetes MCP Server (instructor demo)

## Instructor Setup

Use the [RHOAI Toolkit](https://github.com/gymnatics/RHOAI-Toolkit) for automated setup:

```bash
./rhoai-toolkit.sh
# Select: Workshop Demo Setup > Complete Workshop Setup
```

This sets up the cluster, users, model, MCP server, and AI Playground — so the instructor can demo MCP tool calling live. See Appendix C of the workshop guide for manual setup steps.
