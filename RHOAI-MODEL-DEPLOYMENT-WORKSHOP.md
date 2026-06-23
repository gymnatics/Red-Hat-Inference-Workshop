# Red Hat OpenShift AI — Model Deployment Workshop

> A hands-on guide for deploying AI models on Red Hat OpenShift AI (RHOAI) 3.4 via the web UI, and testing them with the AI Playground.

**Total time:** ~1.5 hours

---

## What You'll Learn

By the end of this workshop, you will:

- Create a Data Science project in OpenShift AI
- Deploy an AI model (Qwen3-4B) using the vLLM runtime via the dashboard
- Enable the AI Playground and chat with your model
- Understand hardware profiles and model serving configuration

### Workshop Structure


| Part                             | Type            | Duration |
| -------------------------------- | --------------- | -------- |
| Part 1: Access OpenShift AI      | Hands-on        | ~10 min  |
| Part 2: Create Your Project      | Hands-on        | ~5 min   |
| Part 3: Deploy a Model           | Hands-on        | ~15 min  |
| Part 4: Wait for Model & Monitor | Hands-on        | ~10 min  |
| Part 5: Test with AI Playground  | Hands-on        | ~15 min  |
| Part 6: Advanced Settings        | Instructor Demo | ~15 min  |
| Part 7: Cleanup                  | Hands-on        | ~5 min   |


---

## Prerequisites

Before starting, make sure the following are ready:

- A running OpenShift 4.20+ cluster with RHOAI 3.4 installed
- At least one GPU node available in the cluster (e.g., NVIDIA L4, L40S, or A100)
- A GPU hardware profile created by your administrator (`gpu-profile`)
- Your login credentials (username and password provided by your instructor)

> **Instructor note:** Use `scripts/install-rhoai-34.sh --skip-rhcl --skip-maas --setup-users --num-users <N>` to create workshop user accounts. RHCL and MaaS are not required for this workshop. See the [RHOAI 3.4 Installation Guide](rhoai-3.4/RHOAI-34-INSTALLATION.md) for full setup details.

---

## Your User Number

Throughout this guide, you'll see `user-XX`. **Replace XX with your assigned number.**

For example, if you are **user 5**, then:

- `user-XX` becomes `user-05`
- Your project name is `user-05`

> Always use two digits: user 5 = `user-05`, user 12 = `user-12`

**Write your user number here:** `user-____`

---

# Part 1: Access OpenShift AI (10 min)

## Step 1.1: Log into OpenShift

1. Open your web browser (Chrome or Firefox recommended)
2. Go to the OpenShift Console URL provided by your instructor
3. Select the login provider specified by your instructor (e.g., `workshop-users` or `htpasswd`)
4. Enter your username and password
5. Click **"Log in"**

You should now see the **OpenShift Console**.

> **Screenshot placeholder — OpenShift login screen**
>
> OpenShift Login
> *Add a screenshot of the OpenShift login page with the identity provider selection.*

> Can't log in? Double-check your username and password with your instructor.

---

## Step 1.2: Navigate to OpenShift AI

1. Look at the **top-right corner** of the OpenShift Console
2. Click the **grid icon** (the 3x3 application launcher)
3. Select **"Red Hat OpenShift AI"** from the dropdown

You should now see the **OpenShift AI Dashboard** with a left sidebar showing menu items like "Projects", "Model catalog", "Gen AI studio", etc.

> **Screenshot placeholder — Application launcher and OpenShift AI entry**
>
> Application Launcher
> *Add a screenshot showing the grid icon expanded with "Red Hat OpenShift AI" highlighted.*

> **Screenshot placeholder — OpenShift AI Dashboard home**
>
> RHOAI Dashboard
> *Add a screenshot of the OpenShift AI dashboard landing page.*

> **Tip:** You can always return to OpenShift AI by clicking the grid icon and selecting "Red Hat OpenShift AI". In RHOAI 3.4, the dashboard URL is `https://rh-ai.apps.<cluster-domain>`.

---

# Part 2: Create Your Project (5 min)

A "project" (also known as a Kubernetes namespace) is your workspace where you'll deploy models, create workbenches, and run experiments.

## Step 2.1: Create a New Project

1. Click **"Projects"** in the left sidebar
2. Click the **"Create project"** button (top right)
3. Fill in the form:

  | Field           | What to Enter                                         |
  | --------------- | ----------------------------------------------------- |
  | **Name**        | `user-XX` (use your assigned number, e.g., `user-05`) |
  | **Description** | `My workshop project` (optional)                      |

4. Click **"Create"**

> **Screenshot placeholder — Create project form**
>
> Create Project
> *Add a screenshot showing the "Create project" dialog with the name field filled in.*

You should now see your project `user-XX` listed in the Projects view, with tabs for **Overview**, **Deployments**, **Workbenches**, **Connections**, etc.

> **Screenshot placeholder — Project overview page**
>
> Project Overview
> *Add a screenshot of the newly created project's overview page showing the empty state.*

---

# Part 3: Deploy a Model (15 min)

In this section, you'll deploy the **Qwen3-4B** model using the **vLLM** serving runtime. The model is stored as an OCI (container) image, so no S3 storage credentials are needed.

## Step 3.1: Understanding Hardware Profiles (Instructor Demo)

> **This is a brief demo by your instructor** — you don't need to do anything, just watch and learn.

A **hardware profile** defines the compute resources (CPU, memory, GPU) allocated to a model deployment. It also includes tolerations that allow pods to schedule on GPU-tainted nodes.

**What the instructor will show:**

- Navigate to **Settings > Hardware profiles** in the RHOAI dashboard
- The pre-created `gpu-profile` that includes:
  - GPU resource limits (`nvidia.com/gpu`)
  - Node selector for GPU nodes (`nvidia.com/gpu.present: "true"`)
  - Tolerations for GPU node taints

> **Screenshot placeholder — Hardware profiles settings page**
>
> Hardware Profiles
> *Add a screenshot of the Settings > Hardware profiles page showing the gpu-profile.*

> **Important:** Only administrators can create or modify hardware profiles. As a workshop participant, you'll **select** the pre-created `gpu-profile` when deploying your model.

---

## Step 3.2: Start the Model Deployment

1. Click **"Projects"** in the left sidebar
2. Click on your project name (`user-XX`)
3. Click the **"Deployments"** tab
4. Click the **"Deploy model"** button

> **Screenshot placeholder — Empty deployments tab with "Deploy model" button**
>
> Deploy Model Button
> *Add a screenshot of the project Deployments tab showing the "Deploy model" button.*

---

## Step 3.3: Configure Model Details

The deployment wizard has multiple steps. Fill in the first section:

### Model details


| Field                     | What to Select/Enter                        |
| ------------------------- | ------------------------------------------- |
| **Model deployment name** | `qwen3-4b`                                  |
| **Serving runtime**       | `vLLM NVIDIA GPU ServingRuntime for KServe` |
| **Hardware profile**      | Select `gpu-profile`                        |
| **Model server replicas** | `1`                                         |


> **Screenshot placeholder — Model deployment form (top section)**
>
> Model Details
> *Add a screenshot showing the model deployment name, serving runtime dropdown, and hardware profile selection.*

### Model source


| Field           | What to Select/Enter                                                      |
| --------------- | ------------------------------------------------------------------------- |
| **Source type** | `URI`                                                                     |
| **URI**         | `oci://quay.io/redhat-ai-services/modelcar-catalog:qwen3-4b` |


> **Tip:** Copy the URI exactly as shown. This pulls the model as an OCI container image — no storage credentials are required.

> **Screenshot placeholder — URI model source configuration**
>
> Model Source
> *Add a screenshot showing the URI source type selected and the OCI URI filled in.*

---

## Step 3.4: Review and Deploy

1. Review the configuration summary
2. Ensure the following are correct:
   - **Serving runtime:** vLLM NVIDIA GPU
   - **Hardware profile:** gpu-profile
   - **Replicas:** 1
   - **Source URI:** The OCI URI you entered
3. Click **"Deploy"**

> **Screenshot placeholder — Deployment review/summary**
>
> ![Deploy Review](screenshots/workshop-10-deploy-review.png)
> *Add a screenshot of the deployment summary or the final step before clicking "Deploy".*

---

# Part 4: Wait for Model & Monitor (10 min)

The model needs a few minutes to pull the container image and start the vLLM server.

## Step 4.1: Monitor Deployment Status

1. After clicking Deploy, you'll be taken to the Deployments tab
2. Watch the status indicator next to `qwen3-4b`:


| Status          | What It Means                                        |
| --------------- | ---------------------------------------------------- |
| **Pending**     | Model pod is being scheduled                         |
| **Progressing** | Container image is being pulled and model is loading |
| **Available**   | Model is ready to serve requests                     |
| **Failed**      | Something went wrong (check events)                  |


> **Screenshot placeholder — Model deployment in progress**
>
> Deployment Progress
> *Add a screenshot showing the model deployment with a "Progressing" or loading status.*

> This typically takes **3–5 minutes** depending on image cache state and GPU availability. Feel free to stretch!

## Step 4.2: Verify the Model is Running

Once the status shows **Available** (green), your model is ready.

1. You should see the model listed under Deployments with a green status indicator
2. Click on the model name to see details including:
  - Inference endpoint URL
  - Resource utilization
  - Pod status

> **Screenshot placeholder — Model deployment showing "Available" status**
>
> Model Available
> *Add a screenshot showing the model with a green "Available" status indicator.*

> **Screenshot placeholder — Model deployment details page**
>
> Model Details Page
> *Add a screenshot of the model's detail page showing the inference endpoint and pod status.*

---

# Part 5: Test with AI Playground (15 min)

The **AI Playground** provides a chat interface to interact with your deployed model directly from the dashboard — no code required.

## Step 5.1: Enable Model as an AI Asset

To use your model in the Playground, it needs to be registered as an AI asset endpoint. If you checked **"Make deployed models available as AI assets"** during deployment, this is already done.

If not, you can add it manually:

1. Go to **"Projects"** > your project (`user-XX`)
2. Click the **"Deployments"** tab
3. Click on your model name (`qwen3-4b`)
4. Look for the option to **"Add as AI asset endpoint"** or verify it's already listed

> **Screenshot placeholder — AI asset endpoint toggle or confirmation**
>
> AI Asset Endpoint
> *Add a screenshot showing where the model is registered as an AI asset endpoint.*

---

## Step 5.2: Open the AI Playground

1. Click **"Gen AI studio"** in the left sidebar
2. Click **"Playground"**
3. You should see a chat interface
4. Select your model from the **model dropdown** if it's not already selected

> **Screenshot placeholder — Gen AI Studio > Playground**
>
> Playground
> *Add a screenshot of the AI Playground with the model selected in the dropdown.*

---

## Step 5.3: Chat with Your Model

Try these prompts to verify your model is working:

### Basic test

Type the following in the chat box and press Enter:

```
What is the capital of France?
```

You should receive a coherent answer about Paris.

### Creative test

```
Write a haiku about cloud computing.
```

### Reasoning test

```
Explain the difference between machine learning and deep learning in simple terms.
```

### Code generation test

```
Write a Python function that calculates the Fibonacci sequence up to n terms.
```

> **Screenshot placeholder — Playground conversation with responses**
>
> Playground Chat
> *Add a screenshot showing a conversation in the Playground with both the user prompt and the model's response visible.*

Your AI model is working! You can continue chatting with it about any topic.

---

## Step 5.4: Explore Playground Settings

The Playground offers several configuration options to tune model behavior:


| Setting           | What It Does                                          | Suggested Value     |
| ----------------- | ----------------------------------------------------- | ------------------- |
| **Temperature**   | Controls randomness (0 = deterministic, 1 = creative) | 0.7                 |
| **Max tokens**    | Maximum length of the response                        | 256–1024            |
| **Top P**         | Nucleus sampling threshold                            | 0.9                 |
| **System prompt** | Sets the model's persona/instructions                 | (try a custom one!) |


### Try a system prompt

In the system prompt field (if available), enter:

```
You are a helpful assistant that explains technical concepts using simple analogies. Always include a real-world analogy in your answers.
```

Then ask:

```
What is Kubernetes?
```

Notice how the response now includes an analogy!

> **Screenshot placeholder — Playground settings panel**
>
> Playground Settings
> *Add a screenshot showing the Playground settings panel with temperature, max tokens, and system prompt options.*

---

# Part 6: Advanced Settings (Instructor Demo)

> **The following sections are demonstrated by your instructor.** Watch and learn how to configure advanced model serving options.

---

## 6.1: Enabling Tool Calling

Tool calling allows the model to invoke external tools (APIs, databases, etc.) to answer questions with live data. This is configured via custom runtime arguments during model deployment.

**What the instructor will show:**

1. Navigate to the model deployment's **Advanced settings**
2. Under **"Configuration parameters"**, enable **"Add custom runtime arguments"**
3. Add the following arguments (each on its own line):
  ```
   --enable-auto-tool-choice
   --tool-call-parser=hermes
   --chat-template=/opt/app-root/template/tool_chat_template_hermes.jinja
  ```

> **Screenshot placeholder — Custom runtime arguments**
>
> Tool Calling Args
> *Add a screenshot of the Advanced settings showing the custom runtime arguments for tool calling.*

**What these arguments do:**


| Argument                         | Purpose                                                 |
| -------------------------------- | ------------------------------------------------------- |
| `--enable-auto-tool-choice`      | Allows the model to decide when to use tools            |
| `--tool-call-parser=llama3_json` | Tells vLLM how to parse Llama's tool call output        |
| `--chat-template=...`            | Uses the correct Jinja template for tool-calling format |


> **Note:** Different model families require different tool call parsers:
>
>
> | Model Family | Parser        |
> | ------------ | ------------- |
> | Llama        | `llama3_json` |
> | Qwen         | `hermes`      |
> | Mistral      | `mistral`     |
>

---

## 6.2: Using the Model Catalog (Optional)

RHOAI 3.4 includes a **Model Catalog** with pre-validated model configurations:

1. Click **"Model catalog"** in the left sidebar
2. Browse available models (Granite, Llama, Qwen, Mistral, etc.)
3. Click on a model to see details, recommended hardware, and deployment instructions
4. Click **"Deploy"** to start a pre-configured deployment

> **Screenshot placeholder — Model catalog page**
>
> Model Catalog
> *Add a screenshot of the Model Catalog showing available model cards.*

---

# Part 7: Cleanup (5 min)

When you're done with the workshop, delete your project to free up cluster resources (especially GPU).

## Option A: Via the Dashboard

1. Go to **"Projects"** in the left sidebar
2. Find your project (`user-XX`)
3. Click the **kebab menu** (three dots) next to your project
4. Select **"Delete project"**
5. Type the project name to confirm and click **Delete**

> **Screenshot placeholder — Delete project confirmation**
>
> Delete Project
> *Add a screenshot of the delete project confirmation dialog.*

## Option B: Via the Web Terminal

1. Click the **terminal icon** (`>_`) in the top-right corner of the OpenShift Console
2. Run:

```bash
oc delete project user-XX
```

Replace `user-XX` with your actual project name.

---

# Congratulations!

You've completed the Model Deployment Workshop!

## What You Accomplished


| Task                                                            | Status |
| --------------------------------------------------------------- | ------ |
| Logged into OpenShift AI                                        | Done   |
| Created a Data Science project                                  | Done   |
| Deployed a model with vLLM runtime                              | Done   |
| Monitored deployment status                                     | Done   |
| Tested the model via the AI Playground                          | Done   |
| Learned about advanced settings (tool calling, model catalog)   | Done   |


## What's Next?

After this workshop, you can explore:


| Topic                          | Where to Learn More                                                                                                                         |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **MCP Tools**                  | Connect external tools (Weather, HR, etc.) to extend your model's capabilities. See [MCP Server Setup](MCP-SERVER-SETUP.md)                 |
| **Models-as-a-Service (MaaS)** | API keys, subscriptions, and rate limiting for multi-tenant model access. See [MaaS Policy Enforcement](MAAS-POLICY-ENFORCEMENT.md)         |
| **NeMo Guardrails**            | Add safety guardrails to your model responses. See [RHCL + Guardrails Architecture](RHCL-GUARDRAILS-ARCHITECTURE.md)                        |
| **Model Registry**             | Version and manage your models. See [Model Registry](MODEL-REGISTRY.md)                                                                     |
| **AI Pipelines**               | Build automated ML workflows. See the [RHOAI documentation](https://docs.redhat.com/en/documentation/red_hat_openshift_ai_self-managed/3.4) |
| **LLM Evaluation**             | Benchmark your models with LMEval. See the [Demo Environment](DEMO-ENVIRONMENT.md)                                                          |


---

# Troubleshooting

## "Model stuck on Pending"

**Cause:** No GPU nodes available, or GPU is occupied by another deployment.

**Fix:**

- Check if GPU nodes exist: look for nodes labeled with `nvidia.com/gpu.present=true`
- Ask your instructor if GPUs are available

## "Model shows Failed status"

**Cause:** Various — could be image pull error, insufficient resources, or configuration issue.

**Fix:**

1. Click on the model name to see deployment details
2. Check the **Events** tab for error messages
3. Common issues:
  - Image pull errors: verify the OCI URI is correct
  - Insufficient GPU memory: the model may need more than available VRAM
  - Missing hardware profile: ensure `gpu-profile` exists

## "Playground not loading or no models available"

**Cause:** Model is not registered as an AI asset, or model is not fully ready.

**Fix:**

1. Verify your model shows **Available** status in the Deployments tab
2. Ensure the model is registered as an AI asset endpoint
3. Try refreshing the browser page
4. Wait 1–2 minutes after the model becomes Available

## Still stuck?

Raise your hand! The instructors are here to help.

---

# Quick Reference Card

## Your Info

- **Username:** `_______`_
- **Password:** `________`
- **Project name:** `user-____`

## Key URLs


| Resource          | URL                                                       |
| ----------------- | --------------------------------------------------------- |
| OpenShift Console | `https://console-openshift-console.apps.<cluster-domain>` |
| RHOAI Dashboard   | `https://rh-ai.apps.<cluster-domain>`                     |


## Key Terminal Commands

```bash
# Check your login
oc whoami

# Switch to your project
oc project user-XX

# Check model pods
oc get pods -n user-XX

# Check model status
oc get inferenceservice -n user-XX

# Check GPU availability
oc get nodes -l nvidia.com/gpu.present=true

# View model logs (if troubleshooting)
oc logs -n user-XX -l serving.kserve.io/inferenceservice=qwen3-4b --tail=50

# Delete your project (cleanup)
oc delete project user-XX
```

---

# Appendix: Instructor Setup Checklist

This section is for workshop instructors setting up the environment.

## Pre-workshop Setup

1. **Install RHOAI 3.4** using the automated script (no RHCL/MaaS needed):

   ```bash
   ./scripts/install-rhoai-34.sh --skip-rhcl --skip-maas --setup-users --num-users <N> --user-password <password>
   ```

   This installs RHOAI with direct model serving (Path A). Users will deploy models via the standard `InferenceService` path in the dashboard.

2. **Verify GPU nodes** are available:

   ```bash
   oc get nodes -l nvidia.com/gpu.present=true
   ```

3. **Verify hardware profile** exists:

   ```bash
   oc get hardwareprofile gpu-profile -n redhat-ods-applications
   ```

   If missing, create it:

   ```bash
   oc apply -f lib/manifests/rhoai/hardware-profile-gpu.yaml
   ```

4. **Verify dashboard features** are enabled:

   ```bash
   oc get odhdashboardconfig odh-dashboard-config -n redhat-ods-applications \
     -o jsonpath='{.spec.dashboardConfig}' | jq '{disableModelCatalog, genAiStudio}'
   ```

5. **Test a model deployment** yourself before the workshop to ensure images are cached on nodes.

6. **Prepare screenshots** for all placeholder sections marked with `> **Screenshot placeholder**` in this guide. Take screenshots from a `user-01` session and place them in a `screenshots/` directory alongside this guide.

## Workshop Credentials Template

Provide each participant with:


| Field                     | Value                                                     |
| ------------------------- | --------------------------------------------------------- |
| OpenShift Console URL     | `https://console-openshift-console.apps.<cluster-domain>` |
| Login provider            | `htpasswd` or `workshop-users`                            |
| Username                  | `userXX`                                                  |
| Password                  | (your chosen password)                                    |
| User number (for project) | `XX`                                                      |


---

**Reference:** [RHOAI 3.4 Documentation](https://docs.redhat.com/en/documentation/red_hat_openshift_ai_self-managed/3.4)