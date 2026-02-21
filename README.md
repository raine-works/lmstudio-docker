# LM Studio Docker

Docker image for running LM Studio, a desktop application for running and developing large language models locally.

## Features

- Run LM Studio in a containerized environment
- Access LM Studio through SSH terminal or web interface
- GPU support via NVIDIA CUDA
- Built-in SSH server for remote access
- Pre-configured with LM Studio CLI tools

## Prerequisites

- Docker installed on your system
- NVIDIA GPU with drivers installed (for GPU support)
- Docker Compose (optional, but recommended)

## Quick Start

### Using Docker Run

```bash
docker run -d \
  --name lmstudio \
  --gpus all \
  -p 22:22 \
  -p 1234:1234 \
  ghcr.io/raine-works/lmstudio-docker:latest
```

### Using Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'
services:
  lmstudio:
    image: ghcr.io/raine-works/lmstudio-docker:latest
    container_name: lmstudio
    ports:
      - "22:22"   # SSH access
      - "1234:1234" # LM Studio API
    volumes:
      - ./data:/root/.lmstudio  # Persist data
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

Then run:
```bash
docker-compose up -d
```

## Access Methods

### SSH Access

Connect via SSH to get terminal access:
```bash
ssh root@localhost -p 22
# Default password is 'root'
```

### LM Studio Web Interface

Access the LM Studio web interface at:
```
http://localhost:1234
```

## Environment Variables

The container can be configured using environment variables:

- `LM_API_TOKEN` - API token for LM Studio (optional)

## Ports

- `22` - SSH access
- `1234` - LM Studio API server

## Building Locally

### Prerequisites

Make sure you have the following installed:
- Docker
- Buildx support enabled

### Build Commands

```bash
# Build locally
npm run build:local

# Push to registry (requires authentication)
npm run auth:docker
npm run build
```

## GitHub Actions

This project includes a GitHub Actions workflow that automatically builds and publishes the Docker image when pushing to the main branch or creating a new tag.

### Workflow Details

The workflow:
1. Triggers on pushes to `main` branch or tags matching `v*`
2. Builds the Docker image for both AMD64 and ARM64 architectures
3. Pushes the image to GitHub Container Registry (GHCR)
4. Creates version tags based on semantic versioning

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.