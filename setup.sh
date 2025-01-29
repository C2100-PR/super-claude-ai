#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Error handling
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo -e "${RED}❌ Command \"${last_command}\" failed with exit code $?.${NC}"' EXIT

# Logging function
log() {
    echo -e "${GREEN}==>${NC} ${BOLD}$1${NC}"
}

# Check function
check() {
    echo -e "${YELLOW}==>${NC} Checking $1..."
}

# Welcome message
echo -e "${GREEN}=================================${NC}"
echo -e "${GREEN}  Super Claude AI Setup Script    ${NC}"
echo -e "${GREEN}=================================${NC}"

# Check Python installation
check "Python installation"
if ! command -v python3 &> /dev/null; then
    log "Python 3 not found. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install python
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        sudo apt update
        sudo apt install -y python3 python3-pip
    else
        echo -e "${RED}Unsupported operating system${NC}"
        exit 1
    fi
fi

# Install UV package manager
check "UV package manager"
if ! command -v uv &> /dev/null; then
    log "Installing UV package manager..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Create project directory
log "Creating project directory..."
mkdir -p ~/super-claude-ai
cd ~/super-claude-ai

# Clone Claude Engineer v3
check "Claude Engineer repository"
if [ ! -d "claude-engineer" ]; then
    log "Cloning Claude Engineer v3..."
    git clone https://github.com/Doriandarko/claude-engineer.git
    cd claude-engineer
else
    log "Claude Engineer repository already exists. Updating..."
    cd claude-engineer
    git pull origin main
fi

# Setup virtual environment
log "Setting up virtual environment..."
uv venv
source .venv/bin/activate

# Install dependencies
log "Installing dependencies..."
uv pip install -r requirements.txt

# Configure API keys
log "Configuring API keys..."
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo -e "${YELLOW}Please enter your Anthropic API key:${NC}"
    read -r anthropic_key
    echo -e "${YELLOW}Please enter your E2B API key:${NC}"
    read -r e2b_key
    
    # Update .env file
    sed -i.bak "s/ANTHROPIC_API_KEY=.*/ANTHROPIC_API_KEY=${anthropic_key}/" .env
    sed -i.bak "s/E2B_API_KEY=.*/E2B_API_KEY=${e2b_key}/" .env
    rm -f .env.bak
fi

# Create convenience scripts
log "Creating convenience scripts..."
cat > ~/super-claude-ai/start-web.sh << 'EOF'
#!/bin/bash
cd ~/super-claude-ai/claude-engineer
source .venv/bin/activate
uv run app.py
EOF

cat > ~/super-claude-ai/start-cli.sh << 'EOF'
#!/bin/bash
cd ~/super-claude-ai/claude-engineer
source .venv/bin/activate
uv run ce3.py
EOF

chmod +x ~/super-claude-ai/start-web.sh
chmod +x ~/super-claude-ai/start-cli.sh

# Add to PATH
if ! grep -q "super-claude-ai" ~/.bashrc; then
    echo 'export PATH="$PATH:$HOME/super-claude-ai"' >> ~/.bashrc
    source ~/.bashrc
fi

# Success message
echo -e "${GREEN}=================================${NC}"
echo -e "${GREEN}     Installation Complete!       ${NC}"
echo -e "${GREEN}=================================${NC}"
echo -e "\nTo start the web interface:"
echo -e "${YELLOW}./start-web.sh${NC}"
echo -e "\nTo start the CLI interface:"
echo -e "${YELLOW}./start-cli.sh${NC}"
echo -e "\nOpen your browser to ${BOLD}http://localhost:5000${NC} for the web interface."

# Remove error handling trap
trap - EXIT