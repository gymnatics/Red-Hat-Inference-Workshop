# Red Hat OpenShift AI — Model Deployment Workshop

A hands-on workshop (~2 hours) for deploying AI models on Red Hat OpenShift AI (RHOAI) 3.4, enabling tool calling with vLLM, deploying Open WebUI as a chat interface, and connecting MCP servers for live cluster querying.

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
| `RHOAI-MODEL-DEPLOYMENT-WORKSHOP.md` | Workshop guide (12 parts) |
| `manifests/llamastack.yaml` | LlamaStack deployment (Secret + ConfigMap + LlamaStackDistribution) |
| `manifests/open-webui.yaml` | Open WebUI v0.9.0 + mcpo proxy (8 resources in one manifest) |
| `manifests/mcp-server.yaml` | Kubernetes MCP server (ServiceAccount + RoleBinding + Deployment + Service) |
| `show-urls.sh` | Helper script that prints all URLs participants need |
| `images/` | Screenshots for the guide |

## Tech Stack

- RHOAI 3.4, OCP 4.20+
- Qwen3-4B (vLLM with tool calling)
- LlamaStack 0.7.2 (operator v0.4.0)
- Open WebUI v0.9.0
- mcpo proxy (MCP-to-OpenAPI bridge)
- Kubernetes MCP Server

## Instructor Setup

Use the [RHOAI Toolkit](https://github.com/gymnatics/RHOAI-Toolkit) for automated setup:

```bash
./rhoai-toolkit.sh
# Select: Workshop Demo Setup > Complete Workshop Setup
```

See Appendix C of the workshop guide for manual setup steps.
