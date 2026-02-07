#!/bin/bash
# deploy/setup.sh - Automated Environment Validator

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🛠️ Starting Project Setup..."

# 1. Check for uv (Python Manager)
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh | sh
else
    echo -e "${GREEN}✓ uv found${NC}"
fi

# 2. Check for jq (Required for 'make sync')
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq not found. Install it with 'brew install jq' or 'sudo apt install jq'${NC}"
    exit 1
fi

# 3. Check for Docker
if ! docker info &> /dev/null; then
    echo -e "${RED}Error: Docker is not running. Please start Docker Desktop OR Docker not running: Start Docker Desktop. ${NC}"
    exit 1
fi

# 4. Initialize Local Python Environment
echo "📦 Installing Python dependencies..."
uv sync

# 5. Create .env if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env from .env.example..."
    cp .env.example .env
    echo -e "${GREEN}✓ .env created. Update it with your real API keys!${NC}"
fi

# 6. Check Kubernetes (kubectl, Interactive))
echo -e "\n${YELLOW}Would you like to verify/setup Kubernetes for local testing? (y/N):${NC} "
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	echo "☸️ Checking Kubernetes (kubectl)..."
	if ! command -v kubectl &> /dev/null; then
		echo "Installing kubectl..."
		# Mac example (Brew); Script can be branched for Windows/Linux
		brew install kubectl || curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
	else
		echo -e "${GREEN}✓ kubectl found${NC}"
	fi

	# 7. Verify Docker Desktop K8s Status
	echo "☸️ Verifying Cluster Status..."
	if ! kubectl cluster-info &> /dev/null; then
		echo -e "${RED}Error: Kubernetes is not running in Docker Desktop.${NC}"
		echo "Please go to: Docker Desktop > Settings > Kubernetes > Enable Kubernetes"
		exit 1
	else
		# Automatically switch to the correct local context
		kubectl config use-context docker-desktop &> /dev/null
		echo -e "${GREEN}✓ Kubernetes cluster is Ready (docker-desktop context active)${NC}"
	fi
else
	echo -e "${YELLOW}Skipping Kubernetes setup. You can still use non-k8 commands for Docker Compose.${NC}"
fi

    


echo -e "\n${GREEN}================================================================================${NC}"
echo -e "${GREEN}🚀 SETUP COMPLETE!${NC}"
echo -e "${GREEN}==================================================================================${NC}"
echo -e "Next Steps:"
echo -e "   1. Start Dev Mode (with hot reload):		${YELLOW}make -f deploy/Makefile dev${NC}"
echo -e "   2. Deploy to K8s:							${YELLOW}make -f deploy/Makefile k8s-deploy${NC}"
echo -e "   3. Sync Packages (scan new code imports):	${YELLOW}make -f deploy/Makefile sync${NC}"
echo -e "${GREEN}==================================================================================${NC}"
echo -e "${GREEN}🚀 System is Ready!${NC}"