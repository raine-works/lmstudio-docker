# LM Studio CUDA

This project provides a complete Dockerized environment for running LM Studio with NVIDIA CUDA support. The container includes all necessary components to run LM Studio with GPU acceleration, SSH access, and pre-configured CLI tools.

## Features
- Run LM Studio in headless mode (GUI-less) with full NVIDIA CUDA GPU support
- Access the LM Studio API via SSH terminal or directly from host machine
- Built-in SSH server for remote access and debugging
- Pre-configured with LM Studio CLI tools and dependencies
- Multi-architecture support (AMD64, ARM64)

## Prerequisites

- Docker installed on your system
- NVIDIA GPU with drivers installed (for GPU support)

## Quick Start

### Using Docker Run

```bash
docker run -d \
  --name lmstudio-cuda \
  --gpus all \
  -p 22:22 \
  -p 1234:1234 \
  -e PORT=1234 \
  ghcr.io/raine-works/lmstudio-cuda:latest
```

## Access Methods

### SSH Access

Connect via SSH to get terminal access:
```bash
ssh root@localhost -p 22
# Default password is 'root'
```

### Accessing the LM Studio API

The container runs a headless LM Studio API server on port 1234. You can interact with it via:

**From inside the container (via SSH):**
```bash
ssh root@localhost -p 22
# Then use lms commands:
lms ls                 # List downloaded models
lms get <model-id>     # Download a model
lms load <model-id>    # Start the headless server
```

**From your host machine (after running container):**
```bash
# Test API endpoint (list models)
curl http://localhost:1234/v1/models

# Make a chat completion request
curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"meta-llama/Meta-Llama-3-8B-Instruct","messages":[{"role":"user","content":"Hello!"}]}'
```

## Ports

- `22` - SSH access
- `1234` - LM Studio API server (headless, no web interface)

## Headless Mode

This container runs LM Studio in headless mode (GUI-less operation) as documented on the [LM Studio docs](https://lmstudio.ai/docs/developer/core/headless). Key features:

- Server starts automatically via entrypoint script with `lms server start`
- No web interface - use SSH for terminal access or the REST API for programmatic access

## License

This project is licensed under the MIT License - see the LICENSE file for details.
