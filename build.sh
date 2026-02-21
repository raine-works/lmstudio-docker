#!/bin/bash

set -e  # Exit on any error

echo "Starting LM Studio Docker image build..."

# Get package information
PACKAGE_NAME=$(jq -r .name package.json)
VERSION=$(jq -r .version package.json)
GITHUB_USERNAME="raine-works"

echo "Package: $PACKAGE_NAME"
echo "Version: $VERSION"

# Check if docker buildx is available
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    exit 1
fi

# Check if buildx is available
if ! docker buildx ls &> /dev/null; then
    echo "Creating docker buildx builder..."
    docker buildx create --name container --driver=docker-container || true
fi

echo "Using existing builder or created new one."

# Build and push the image
echo "Building and pushing Docker image..."
docker buildx build \
    -f ./Dockerfile \
    --platform linux/amd64,linux/arm64 \
    -t ghcr.io/${GITHUB_USERNAME}/${PACKAGE_NAME}:latest \
    -t ghcr.io/${GITHUB_USERNAME}/${PACKAGE_NAME}:${VERSION} \
    --builder=container \
    --push \
    .

if [ $? -eq 0 ]; then
    echo "Successfully built and pushed Docker image!"
    echo "Tags:"
    echo "  ghcr.io/${GITHUB_USERNAME}/${PACKAGE_NAME}:latest"
    echo "  ghcr.io/${GITHUB_USERNAME}/${PACKAGE_NAME}:${VERSION}"
else
    echo "Error: Failed to build and push Docker image"
    exit 1
fi

echo "Build process completed successfully!"
