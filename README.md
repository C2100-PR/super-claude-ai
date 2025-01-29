# Super Claude AI 🤖

A streamlined setup and configuration tool for Claude Engineer v3, designed to simplify the installation process and get you up and running quickly with Claude's advanced capabilities.

## Quick Start 🚀

### One-Command Setup (Recommended)

For Unix-based systems (macOS/Linux):
```bash
curl -sSL https://raw.githubusercontent.com/C2100-PR/super-claude-ai/main/setup.sh | bash
```

For Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/C2100-PR/super-claude-ai/main/setup.ps1 | iex
```

### What it Does

The setup script automatically:
1. Checks and installs Python 3.8+ if needed
2. Installs the UV package manager
3. Sets up a virtual environment
4. Clones and configures Claude Engineer v3
5. Guides you through API key setup
6. Launches the web interface

## Prerequisites 📋

- Operating System: Windows 10/11, macOS 10.15+, or Linux
- Internet connection
- Basic familiarity with command line operations
- Anthropic account for API access
- E2B account for code execution features

## API Keys Setup 🔑

1. **Anthropic API Key**:
   - Visit [Anthropic Console](https://console.anthropic.com/)
   - Create an account or sign in
   - Generate an API key in your dashboard

2. **E2B API Key**:
   - Visit [E2B](https://e2b.dev)
   - Create an account
   - Generate an API key in your dashboard

## Manual Installation Guide 📖

If you prefer to install components manually:

1. **Check Python Installation**:
   ```bash
   python --version  # Should be 3.8 or higher
   ```

2. **Install UV Package Manager**:
   ```bash
   # Unix-based systems
   curl -LsSf https://astral.sh/uv/install.sh | sh

   # Windows (PowerShell)
   irm https://astral.sh/uv/install.ps1 | iex
   ```

3. **Clone and Setup**:
   ```bash
   git clone https://github.com/C2100-PR/super-claude-ai.git
   cd super-claude-ai
   ./setup.sh  # or .\setup.ps1 on Windows
   ```

## Usage 🖥️

### Web Interface

```bash
super-claude start-web
```
Then open your browser to http://localhost:5000

### CLI Interface

```bash
super-claude start-cli
```

## Features ✨

- 🔄 One-command installation and setup
- 🛠️ Automated dependency management
- 📊 Interactive API key configuration
- 💻 Choice between web and CLI interfaces
- 🔍 Built-in troubleshooting tools
- 📝 Comprehensive logging
- 🚀 Quick-start templates

## Troubleshooting 🔧

Common issues and solutions:

1. **Permission Errors**:
   ```bash
   # Unix-based systems
   sudo chmod +x setup.sh
   ```

2. **Python Not Found**:
   The setup script will automatically install Python if not found. For manual installation:
   - Windows: Download from python.org
   - macOS: `brew install python`
   - Linux: `sudo apt install python3`

3. **API Key Issues**:
   Run the configuration tool:
   ```bash
   super-claude configure
   ```

## Contributing 🤝

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

## License 📄

MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 🙏

- Built on top of [Claude Engineer v3](https://github.com/Doriandarko/claude-engineer)
- Powered by Anthropic's Claude 3.5 Sonnet
- E2B for secure code execution

## Support 💬

- 📚 [Documentation](docs/README.md)
- 🐛 [Issue Tracker](../../issues)
- 💡 [Feature Requests](../../issues/new)
