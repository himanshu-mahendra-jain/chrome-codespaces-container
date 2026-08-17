# Chrome Codespaces Container

A containerized Google Chrome development environment designed specifically for **GitHub Codespaces** that runs in a VNC-enabled container with a web-based interface. This project provides a complete Chrome browser environment that can be accessed through any web browser, making it ideal for development, testing, and remote access scenarios within GitHub Codespaces.

## 🚀 Features

- **Containerized Chrome**: Google Chrome running in a Docker container
- **Web-based Access**: Access Chrome through any web browser via noVNC
- **VNC Support**: Full VNC server for remote desktop access
- **Privacy-Focused**: Pre-configured Chrome policies for enhanced privacy
- **Development Ready**: Includes development tools and extensions support
- **Persistent Data**: Chrome profile data persists across container restarts
- **No Sandbox Mode**: Optimized for containerized environments

## 🏗️ Architecture

This project uses a multi-layered approach:

1. **Base Image**: Debian Trixie (slim)
2. **VNC Server**: TigerVNC for remote desktop access
3. **noVNC**: Web-based VNC client for browser access
4. **Desktop Environment**: Openbox window manager
5. **Chrome Browser**: Google Chrome with custom policies

### Port Configuration

- **Port 6901**: noVNC web interface (primary access method)
- **Port 5901**: Direct VNC access (for VNC clients)

## 📋 Prerequisites

- GitHub Codespaces access
- Modern web browser for accessing the noVNC interface

## 🛠️ Setup Instructions

### GitHub Codespaces Setup

1. **Fork or Clone the repository**:
   - Fork this repository to your GitHub account, or
   - Clone it locally if you have access

2. **Open in GitHub Codespaces**:
   - Navigate to the repository on GitHub
   - Click the green "Code" button
   - Select "Codespaces" tab
   - Click "Create codespace on main" (or your desired branch)

3. **Wait for container startup**:
   - The codespace will build and start automatically
   - VNC and noVNC services will initialize
   - You'll see the container building in the terminal

## 🌐 Accessing Google Chrome

After the GitHub Codespace is running, follow these steps to access Google Chrome:

### Step-by-Step Instructions

1. **Go to Ports**:
   - In VS Code, click on the "Ports" tab in the bottom panel
   - Or use the Command Palette: `Ports: Focus on Ports View`

2. **Open the Web Interface**:
   - Click on the **globe icon** next to port **6901**
   - This will open the noVNC interface in your browser

3. **Access the VNC Interface**:
   - In the opened browser tab, click on the **`vnc.html`** file
   - Click the **"Connect"** button to establish the VNC connection

4. **Launch Google Chrome**:
   - Right-click on the desktop in the VNC interface
   - Hover over **Applications** → **Internet** → **Google Chrome**
   - Click to launch Chrome

## ⚙️ Configuration

### Chrome Policies

The container includes pre-configured Chrome policies located in `.devcontainer/chrome_policies.json`:

- **Privacy Enhanced**: Disabled telemetry and data collection
- **Developer Mode**: Enabled extension developer mode
- **Security**: Enhanced safe browsing and cookie policies
- **Performance**: Memory saver and high efficiency modes enabled

### Customization

To modify Chrome behavior, edit `.devcontainer/chrome_policies.json` and rebuild the container.

## 🔧 Development Features

- **Extension Support**: Developer mode enabled for Chrome extensions
- **File System Access**: Persistent Chrome profile data
- **Network Access**: Full internet connectivity
- **Shared Memory**: Optimized for Chrome's memory requirements

## 📁 Project Structure

```
chrome-container/
├── .devcontainer/
│   ├── Containerfile         # Docker container definition
│   ├── devcontainer.json     # VS Code Dev Container configuration
│   ├── start.sh              # Container startup script
│   └── chrome_policies.json  # Chrome browser policies
├── LICENSE                   # GNU GPL v3 License
└── README.md                 # This file
```

## 🔍 Troubleshooting

### Common Issues

1. **Codespace Build Issues**:
   - Ensure you have sufficient GitHub Codespaces quota
   - Check the build logs in the terminal for errors
   - Try rebuilding the codespace if needed

2. **Chrome Won't Start**:
   - Check the terminal output for any error messages
   - Verify the VNC services are running properly
   - Restart the codespace if necessary

3. **VNC Connection Issues**:
   - Ensure port forwarding is working correctly
   - Try accessing via different browser
   - Check if the noVNC interface is accessible

4. **Performance Issues**:
   - Codespaces have predefined resource limits
   - Consider upgrading to a larger codespace machine type if available

### Logs and Debugging

View build and runtime logs:
- Check the terminal output in the codespace
- Look for any error messages during startup
- Monitor the VNC and noVNC service status

Access container shell:
- Use the integrated terminal in the codespace
- All commands run within the container environment

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For issues and questions:
- [Open an issue on GitHub](https://github.com/UnifyKitHQ/chrome-codespaces-container/issues)
- Check the troubleshooting section above
- Review container logs for error details

---

**Note**: This container runs Chrome with `--no-sandbox` for compatibility with containerized environments. This is safe for development and testing but should be used with caution in production environments.
