<h1 align="center">🖥️ Home Server Control Panel</h1>

<p align="center">
Home Server Control Panel is a lightweight graphical management application designed to control and monitor essential components of a Linux home server.
It provides a simple Tkinter interface for managing Samba shares, Conky disk monitoring, FileBrowser, and the Sevastolink Server Monitor API.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Stable-success">
  <img src="https://img.shields.io/badge/Platform-Linux%20Mint%2022.3%20XFCE-blue">
  <img src="https://img.shields.io/badge/Language-Python-purple">
  <img src="https://img.shields.io/badge/GUI-Tkinter-green">
  <img src="https://img.shields.io/badge/API-FastAPI-orange">
</p>

---

## ✨ Overview

The **Home Server Control Panel** provides a graphical interface for managing common services and configurations on a lightweight Linux home server.

Instead of relying entirely on terminal commands, the application centralizes the most important server operations into a single desktop interface.

The application currently provides four main management modules:

* 📁 Samba Shares
* 📊 Conky Disks
* 🌐 FileBrowser
* 📡 Server Monitor

The main application is built with **Python and Tkinter**, while the monitoring backend uses **FastAPI, Uvicorn and psutil**.

---

## 🚀 Features

<table>

<tr>

<td width="50%" valign="top">

<h3>📁 Samba Shares</h3>

<ul>

<li>View configured Samba shares</li>

<li>Add new network shares</li>

<li>Edit existing shares</li>

<li>Delete shares</li>

<li>Configure shared folder paths</li>

<li>Automatically create missing directories</li>

<li>Automatically apply directory permissions</li>

<li>Restart Samba after configuration</li>

</ul>

<p><b>Default shared configuration:</b></p>

<pre><code>/etc/samba/smb.conf</code></pre>

<p>
The application automatically ignores Samba's <code>global</code>, <code>printers</code> and <code>print$</code> sections when displaying user shares.
</p>

</td>

<td width="50%" valign="top">

<h3>📊 Conky Manager</h3>

<ul>

<li>View disks configured in Conky</li>

<li>Add new monitored disks</li>

<li>Edit disk names and mount points</li>

<li>Remove disks from the monitoring configuration</li>

<li>Automatically update <code>~/.conkyrc</code></li>

<li>Restart Conky after changes</li>

</ul>

<p><b>Configuration file:</b></p>

<pre><code>~/.conkyrc</code></pre>

<p>
Each configured disk displays its usage percentage, usage bar, used space and total capacity.
</p>

</td>

</tr>

<tr>

<td width="50%" valign="top">

<h3>🌐 FileBrowser</h3>

<ul>

<li>Displays the configured FileBrowser root path</li>

<li>Detects the FileBrowser systemd service</li>

<li>Shows service status</li>

<li>Start FileBrowser</li>

<li>Stop FileBrowser</li>

<li>Refresh service status</li>

</ul>

<p><b>Service:</b></p>

<pre><code>filebrowser</code></pre>

<p><b>Default access:</b></p>

<pre><code>http://SERVER_IP:8080</code></pre>

</td>

<td width="50%" valign="top">

<h3>📡 Server Monitor</h3>

<ul>

<li>Integrated FastAPI monitoring server</li>

<li>Real-time server metrics</li>

<li>System information</li>

<li>CPU monitoring</li>

<li>RAM monitoring</li>

<li>Swap monitoring</li>

<li>Disk monitoring</li>

<li>Network traffic monitoring</li>

<li>Service status monitoring</li>

<li>Tailscale status</li>

<li>Server uptime</li>

</ul>

<p><b>API:</b></p>

<pre><code>http://SERVER_NAME:8181/api/rainmeter</code></pre>

</td>

</tr>

</table>

---

## 🖥️ Application Interface

The Control Panel uses a tabbed interface containing four dedicated management areas.

```text
┌──────────────────────────────────────────────────────────┐
│              Home Server Control Panel                   │
├────────────┬────────────┬────────────┬───────────────────┤
│  Shares    │   Conky    │ FileBrowser│  Server Monitor   │
├────────────┴────────────┴────────────┴───────────────────┤
│                                                          │
│                 Module Content                           │
│                                                          │
│                                                          │
├──────────────────────────────────────────────────────────┤
│                  Action Toolbar                          │
└──────────────────────────────────────────────────────────┘
```

The application starts with a **640 × 480** window and supports resizing down to **430 × 280**.

---

## 🔐 Administrator Access

Operations that modify system services or protected configuration files use `sudo`.

Instead of requiring the user to enter a password in the terminal, the Control Panel displays a graphical administrator password dialog when elevated privileges are required.

The password is cached during the current application session and supplied to `sudo` through standard input.

Protected operations include:

* Starting services
* Stopping services
* Restarting services
* Updating Samba configuration
* Installing Server Monitor
* Creating systemd service files

---

## 📁 Samba Share Management

The **Shares** tab reads the Samba configuration from:

```text
/etc/samba/smb.conf
```

The application detects configured share sections and displays:

```text
Share | Path
```

### Add / Edit Share

A share contains:

```text
Share name
Path
```

If the configured directory does not exist, the application automatically creates it and applies:

```bash
mkdir -p <path>
chmod 755 <path>
```

### Apply Configuration

When saving Samba configuration, the application generates a new configuration containing:

```ini
[global]

workgroup = WORKGROUP
server string = K7 Server
security = user
map to guest = bad user
min protocol = SMB2
```

Each configured share is then added with:

```ini
[ShareName]
path = /path/to/share
browseable = yes
read only = no
guest ok = yes
```

The configuration is copied to:

```text
/etc/samba/smb.conf
```

and the Samba service is restarted.

---

## 📊 Conky Disk Manager

The **Conky** tab provides graphical management of disks displayed by the server's Conky HUD.

Configuration is read from:

```text
~/.conkyrc
```

The application detects disk definitions and displays:

```text
# | Name | Path
```

Each disk can be configured with:

```text
Name
Path
```

For example:

```text
01 | System | /
02 | Server | /home
03 | Storage | /mnt/storage
```

The Control Panel generates the corresponding Conky disk information:

```text
DISK 01 (System): XX%
[usage bar]
used / total
```

After saving, Conky is restarted automatically.

---

## 🌐 FileBrowser Manager

The **FileBrowser** module manages the FileBrowser systemd service.

The application reads the service definition:

```text
/etc/systemd/system/filebrowser.service
```

and extracts the configured root path.

### Available Controls

```text
Refresh Status
Start
Stop
```

The interface automatically enables or disables buttons depending on the current service state.

```text
ONLINE  → Stop available
OFFLINE → Start available
```

---

## 📡 Sevastolink Server Monitor

The **Server Monitor** is an integrated FastAPI service designed to expose lightweight server statistics to external monitoring systems such as **Rainmeter**.

The API runs on:

```text
Port: 8181
```

Endpoint:

```text
http://SERVER_NAME:8181/api/rainmeter
```

The endpoint returns plain-text key/value data, making it easy to consume from monitoring applications and desktop widgets.

---

## 📊 Monitoring Metrics

The Server Monitor exposes the following information:

### 🖥️ Host

```text
HOSTNAME
```

### ⚙️ CPU

```text
CPU_MODEL
CPU_CORES
CPU_THREADS
CPU_FREQ
CPU_TEMP
CPU_USAGE
```

### 🧠 Memory

```text
RAM_USED
RAM_TOTAL
RAM_PERCENT
```

### 💾 Swap

```text
SWAP_USED
SWAP_TOTAL
SWAP_PERCENT
```

### 💽 Disk

```text
DISK_USED
DISK_TOTAL
DISK_PERCENT
```

### 🌐 Network

```text
LAN_IP
DOWNLOAD
UPLOAD
LINK_SPEED
```

### 🔌 Services

```text
FILEBROWSER
TAILSCALE
```

### 🔐 Tailscale

```text
TAILSCALE_IP
```

### ⏱️ System

```text
UPTIME
```

These values are generated using **psutil**, system commands and Linux system information.

---

## 📡 Rainmeter Integration

The API was designed to provide a simple data source for a Rainmeter skin.

Example endpoint:

```text
http://SERVER_NAME:8181/api/rainmeter
```

Example response:

```text
HOSTNAME=K7
CPU_MODEL=Intel(R) Core(TM)...
CPU_CORES=2
CPU_THREADS=2
CPU_FREQ=1.80
CPU_TEMP=42.0
CPU_USAGE=8.5
RAM_USED=1.72
RAM_TOTAL=3.82
RAM_PERCENT=45
DISK_USED=120.45
DISK_TOTAL=465.76
DISK_PERCENT=25
LAN_IP=192.168.1.100
DOWNLOAD=0.12
UPLOAD=0.03
LINK_SPEED=100 Mb/s
FILEBROWSER=ONLINE
TAILSCALE=ONLINE
TAILSCALE_IP=100.x.x.x
UPTIME=2 days, 04:32:10
```

The endpoint uses a plain-text response instead of JSON, keeping the integration lightweight and easy to parse from desktop monitoring tools.

---

## ⚙️ Server Monitor Installation

The Control Panel can install the Server Monitor directly from the **Server Monitor** tab.

The installation process performs the following operations:

```text
1. Update package lists
2. Install Python dependencies
3. Create api.py
4. Create Python virtual environment
5. Upgrade pip
6. Install FastAPI / Uvicorn / psutil
7. Create systemd service
8. Reload systemd
9. Enable service
10. Start service
```

The application displays installation progress through a graphical progress bar.

---

## 🧩 Server Monitor Architecture

```text
                  ┌──────────────────────┐
                  │   Linux Home Server  │
                  └──────────┬───────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ Sevastolink Monitor  │
                  │      FastAPI         │
                  └──────────┬───────────┘
                             │
                       Port 8181
                             │
                             ▼
              ┌─────────────────────────────┐
              │      /api/rainmeter         │
              └──────────────┬──────────────┘
                             │
             ┌───────────────┴───────────────┐
             │                               │
             ▼                               ▼
       Rainmeter Skin                 Control Panel
       / Dashboard                    Live Metrics
```

---

## 🔄 Service Management

The Control Panel provides direct systemd controls for the main services.

### FileBrowser

```bash
systemctl start filebrowser
systemctl stop filebrowser
```

### Sevastolink Monitor

```bash
systemctl start sevastolink
systemctl stop sevastolink
systemctl restart sevastolink
```

The graphical interface automatically detects whether services are **ONLINE** or **OFFLINE** and updates the available controls accordingly.

---

## 🛠️ Technologies

<table>

<tr>
<td><b>Language</b></td>
<td>Python 3</td>
</tr>

<tr>
<td><b>GUI</b></td>
<td>Tkinter / ttk</td>
</tr>

<tr>
<td><b>API Framework</b></td>
<td>FastAPI</td>
</tr>

<tr>
<td><b>API Server</b></td>
<td>Uvicorn</td>
</tr>

<tr>
<td><b>System Monitoring</b></td>
<td>psutil</td>
</tr>

<tr>
<td><b>Service Manager</b></td>
<td>systemd</td>
</tr>

<tr>
<td><b>File Sharing</b></td>
<td>Samba</td>
</tr>

<tr>
<td><b>Desktop Monitoring</b></td>
<td>Conky</td>
</tr>

<tr>
<td><b>Remote Access</b></td>
<td>Tailscale</td>
</tr>

<tr>
<td><b>File Management</b></td>
<td>FileBrowser</td>
</tr>

</table>

---

## 📂 Project Structure

```text
HomeServer/
│
├── server_panel.py
│
├── SevastolinkMonitor/
│   ├── api.py
│   └── .venv/
│
└── systemd/
    └── sevastolink.service
```

The Server Monitor installation directory is created under the current user's home directory:

```text
~/SevastolinkMonitor
```

with the API stored as:

```text
~/SevastolinkMonitor/api.py
```

---

## 🎯 Target Use Cases

<ul>

<li>Lightweight home servers</li>

<li>Old laptops and desktops</li>

<li>Personal NAS systems</li>

<li>Home file servers</li>

<li>Always-on Linux machines</li>

<li>Servers monitored through Rainmeter</li>

<li>Desktop-based server administration</li>

<li>Systems where terminal-only administration is inconvenient</li>

</ul>

---

## 📌 Access Points

<p><b>FileBrowser</b></p>

<pre><code>http://SERVER_IP:8080</code></pre>

<p><b>Server Monitor API</b></p>

<pre><code>http://SERVER_NAME:8181/api/rainmeter</code></pre>

<p><b>Samba</b></p>

<pre><code>smb://SERVER_IP/server</code></pre>

---

## ⚠️ Notes

<ul>

<li>Designed for Linux-based home servers</li>

<li>Requires Python 3</li>

<li>Requires sudo privileges for administrative operations</li>

<li>Server Monitor installation requires an Internet connection</li>

<li>FileBrowser must be installed separately if it is not already present</li>

<li>Samba configuration is directly modified by the application</li>

<li>Conky configuration is directly modified through <code>~/.conkyrc</code></li>

<li>The Server Monitor API listens on all network interfaces</li>

<li>Network interface detection excludes loopback and Tailscale interfaces</li>

</ul>

---

## 🔒 Security Considerations

The Server Monitor API is intentionally lightweight and exposes monitoring information through a plain HTTP endpoint.

The FastAPI application currently enables CORS for all origins:

```python
allow_origins=["*"]
```

and listens on:

```text
0.0.0.0:8181
```

Therefore, the API should preferably be used inside a trusted network or protected through appropriate network controls when remote access is enabled.

---

## 📸 Server Panel Preview

<p align="center">
  <img width="650" alt="Home Server Control Panel" src="https://github.com/user-attachments/assets/4a9a264e-706a-40cf-89d2-58ab36962737" />
</p>

---

## 📡 Monitoring Workflow

```text
Linux System
     │
     ├── CPU
     ├── RAM
     ├── Swap
     ├── Disk
     ├── Network
     ├── FileBrowser
     ├── Tailscale
     └── Uptime
              │
              ▼
        psutil / Linux
              │
              ▼
      Sevastolink Monitor
              │
          HTTP :8181
              │
              ▼
       /api/rainmeter
              │
       ┌──────┴──────┐
       ▼             ▼
   Rainmeter    Server Panel
```

---

<p align="center">
Made for lightweight Linux home servers. 🐧
</p>
