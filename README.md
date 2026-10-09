# Chrome Codespaces Container

A containerized Google Chrome development environment designed specifically for **GitHub Codespaces** that runs in a VNC-enabled container with a web-based interface. This project provides a complete Chrome browser environment that can be accessed through any web browser, making it ideal for development, testing, and remote access scenarios within GitHub Codespaces.

## Features

- **Containerized Chrome**: Google Chrome running in a Docker container
- **Web-based Access**: Access Chrome through any web browser via noVNC
- **VNC Support**: Full VNC server for remote desktop access
- **Privacy-Focused**: Pre-configured Chrome policies for enhanced privacy
- **Development Ready**: Includes development tools and extensions support
- **Persistent Data**: Chrome profile data persists across container restarts
- **No Sandbox Mode**: Optimized for containerized environments

## Architecture

This project uses a multi-layered approach:

1. **Base Image**: Debian stable (slim)
2. **VNC Server**: TigerVNC for remote desktop access
3. **noVNC**: Web-based VNC client for browser access
4. **Desktop Environment**: Openbox window manager
5. **Chrome Browser**: Google Chrome with custom policies

### Port Configuration

- **Port 6901**: noVNC web interface (primary access method)
- **Port 5901**: Direct VNC access (for VNC clients)

## Prerequisites

- GitHub Codespaces access
- Modern web browser for accessing the noVNC interface

## Setup Instructions

### GitHub Codespaces Setup

1. **Fork or clone the repository** to your GitHub account

2. **Open in GitHub Codespaces**:
   - Navigate to the repository on GitHub
   - Click the green "Code" button
   - Select "Codespaces" tab
   - Click "Create codespace on main" (or your desired branch)

3. **Wait for container startup**:
   - The codespace will build and start automatically
   - VNC and noVNC services will initialize
   - You'll see the container building in the terminal

## Accessing Google Chrome

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

## Configuration

### Chrome Policies

The container includes pre-configured Chrome policies located in `.devcontainer/chrome_policies.json`. They are installed as managed policies, so they are enforced and appear locked in Chrome's settings.

| Policy | Value | Effect |
|---|---|---|
| `MetricsReportingEnabled` | `false` | No usage statistics or crash reports sent to Google |
| `UrlKeyedAnonymizedDataCollectionEnabled` | `false` | Visited URLs are not sent to Google |
| `NetworkPredictionOptions` | `2` | Never preload pages or prefetch DNS |
| `BlockThirdPartyCookies` | `true` | Third-party cookies are blocked |
| `SafeBrowsingProtectionLevel` | `2` | Enhanced Safe Browsing (shares more data with Google in real time) |
| `ExtensionDeveloperModeSettings` | `0` | Developer mode is allowed, so unpacked extensions can be loaded |
| `RestoreOnStartup` | `1` | Reopen the previous session's tabs on startup |
| `HomepageIsNewTabPage` | `false` | Use `HomepageLocation` as the homepage |
| `HomepageLocation` | `https://www.google.com` | Homepage URL (used by the Home button, which is hidden by default) |
| `DefaultBrowserSettingEnabled` | `false` | No default-browser check or prompt |
| `BackgroundModeEnabled` | `false` | Chrome exits fully when the last window closes |
| `BookmarkBarEnabled` | `true` | Bookmarks bar is always shown |
| `HighEfficiencyModeEnabled` | `true` | Memory Saver is on and unloads inactive tabs |
| `MemorySaverModeSavings` | `1` | Memory Saver level: Balanced (`0` Moderate, `2` Maximum) |

To modify Chrome behavior, edit `.devcontainer/chrome_policies.json` and rebuild the container. Open `chrome://policy` in the container to check which policies are active.

## Development Features

- **Extension Support**: Developer mode enabled for Chrome extensions
- **File System Access**: Persistent Chrome profile data
- **Network Access**: Full internet connectivity
- **Shared Memory**: Optimized for Chrome's memory requirements

## Project Structure

```
chrome-codespaces-container/
├── .devcontainer/
│   ├── Containerfile         # Docker container definition
│   ├── devcontainer.json     # VS Code Dev Container configuration
│   ├── start.sh              # Container startup script
│   └── chrome_policies.json  # Chrome browser policies
├── LICENSE                   # MIT License
└── README.md                 # This file
```

## Troubleshooting

VNC and noVNC start automatically with the container and log to `/tmp/start.log`. If port 6901 doesn't respond, check the log and restart the services:

```bash
cat /tmp/start.log
setsid -f /usr/local/bin/start.sh > /tmp/start.log 2>&1
```

**Note**: This container runs Chrome with `--no-sandbox` for compatibility with containerized environments. This is safe for development and testing but should be used with caution in production environments.

**Security**: The VNC server runs without a password. Keep ports 5901 and 6901 set to **Private** in the Codespaces Ports tab so only you can reach them.

## License

This project is licensed under the [MIT License](LICENSE).
