<h1 align="center">🖥️ Server Panel</h1>

<p align="center">
Server Panel is a lightweight graphical management application designed to manage and monitor essential components of a Linux home server.
It provides a simple Tkinter interface for managing Samba shares, Conky disk monitoring, FileBrowser, and an integrated Server Monitor API.
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

The <b>Server Panel</b> provides a graphical interface for managing common services and configuration files on a lightweight Linux home server.

The application contains four main management areas:

<ul>
<li>📁 Samba Shares</li>
<li>📊 Conky Disks</li>
<li>🌐 FileBrowser</li>
<li>📡 Server Monitor</li>
</ul>

The graphical interface is built with <b>Python and Tkinter</b>.

The integrated monitoring service uses <b>FastAPI, Uvicorn and psutil</b>, running as a dedicated <code>systemd</code> service on port <b>8181</b>.

The application also provides automatic installation and basic recovery of the Server Monitor components.

---

## 🚀 Features

<table>

<tr>

<td width="50%" valign="top">

<h3>📁 Samba Shares</h3>

<ul>
<li>Read configured Samba shares</li>
<li>Add new network shares</li>
<li>Edit existing shares</li>
<li>Delete shares from the graphical list</li>
<li>Configure shared folder paths</li>
<li>Create missing directories automatically</li>
<li>Apply <code>755</code> directory permissions</li>
<li>Generate and apply the Samba configuration</li>
<li>Restart the Samba service automatically after saving</li>
<li>Double-click a share to edit it</li>
</ul>

<p><b>Configuration:</b></p>

<pre><code>/etc/samba/smb.conf</code></pre>

<p><b>Service:</b></p>

<pre><code>smbd</code></pre>

</td>

<td width="50%" valign="top">

<h3>📊 Conky Disks</h3>

<ul>
<li>Read disks configured in Conky</li>
<li>Add monitored disks</li>
<li>Edit disk names</li>
<li>Edit mount points</li>
<li>Remove disks from the configuration</li>
<li>Automatically generate disk monitoring lines</li>
<li>Update <code>~/.conkyrc</code></li>
<li>Restart Conky after changes</li>
<li>Double-click a disk to edit it</li>
</ul>

<p><b>Configuration:</b></p>

<pre><code>~/.conkyrc</code></pre>

</td>

</tr>

<tr>

<td width="50%" valign="top">

<h3>🌐 FileBrowser</h3>

<ul>
<li>Read the configured FileBrowser root path</li>
<li>Detect the FileBrowser systemd service</li>
<li>Display service status</li>
<li>Start FileBrowser</li>
<li>Stop FileBrowser</li>
<li>Refresh service status</li>
<li>Automatically enable or disable Start/Stop controls according to the service state</li>
</ul>

<p><b>Service:</b></p>

<pre><code>filebrowser</code></pre>

<p><b>Root path:</b></p>

<p>Read from the FileBrowser systemd unit using its <code>-r</code> parameter.</p>

</td>

<td width="50%" valign="top">

<h3>📡 Server Monitor</h3>

<ul>
<li>Install the monitoring environment automatically</li>
<li>Create a Python virtual environment</li>
<li>Install FastAPI, Uvicorn and psutil</li>
<li>Create a systemd monitoring service</li>
<li>Start, stop and restart the monitoring service</li>
<li>Display real-time monitoring data</li>
<li>Monitor CPU, RAM and Swap</li>
<li>Monitor disk usage</li>
<li>Monitor network traffic</li>
<li>Display network link speed and IP address</li>
<li>Monitor FileBrowser and Tailscale services</li>
<li>Detect QuakeWorld Server status and port</li>
<li>Display server uptime</li>
</ul>

<p><b>API:</b></p>

<pre><code>http://SERVER_NAME:8181/api/monitor</code></pre>

</td>

</tr>

</table>

---

## 📋 Configuration Files

The Control Panel interacts with the following main files:

<table>

<tr>
<td><b>Samba</b></td>
<td><code>/etc/samba/smb.conf</code></td>
</tr>

<tr>
<td><b>Conky</b></td>
<td><code>~/.conkyrc</code></td>
</tr>

<tr>
<td><b>FileBrowser</b></td>
<td><code>/etc/systemd/system/filebrowser.service</code></td>
</tr>

<tr>
<td><b>Monitor API</b></td>
<td><code>~/Monitor/api.py</code></td>
</tr>

<tr>
<td><b>Monitor Web</b></td>
<td><code>~/Monitor/web/</code></td>
</tr>

<tr>
<td><b>Monitor Launcher</b></td>
<td><code>~/Monitor/web.bat</code></td>
</tr>

<tr>
<td><b>Monitor Service</b></td>
<td><code>/etc/systemd/system/monitor.service</code></td>
</tr>

</table>

---

## 📡 Server Monitor

The <b>Server Monitor</b> is an integrated FastAPI service designed to provide system information to external dashboards and monitoring applications.

The Control Panel can install the complete monitoring environment directly from the graphical interface.

The installation process performs the following steps:

<pre><code>1. Update APT package information
2. Install Python 3, python3-venv, python3-pip and curl
3. Create api.py and monitoring directories
4. Create the Python virtual environment
5. Upgrade pip
6. Install FastAPI, Uvicorn and psutil
7. Create the systemd service
8. Reload systemd
9. Enable the monitor service
10. Start the monitor service</code></pre>

The installation progress is displayed directly in the Control Panel.

The monitoring service is registered as:

<pre><code>monitor.service</code></pre>

The service runs automatically and is configured to restart if it stops.

---

## 📊 Monitoring API

The Server Monitor exposes a plain-text endpoint:

<pre><code>http://SERVER_NAME:8181/api/monitor</code></pre>

The API returns one metric per line using a simple:

<pre><code>KEY=VALUE</code></pre>

format.

The exact values depend on the hardware, network configuration and services running on the server.

---

## 📈 Available Metrics

<table>

<tr>
<td><b>HOSTNAME</b></td>
<td>Linux hostname</td>
</tr>

<tr>
<td><b>CPU_MODEL</b></td>
<td>Detected CPU model</td>
</tr>

<tr>
<td><b>CPU_CORES</b></td>
<td>Physical CPU cores</td>
</tr>

<tr>
<td><b>CPU_THREADS</b></td>
<td>Logical CPU threads</td>
</tr>

<tr>
<td><b>CPU_FREQ</b></td>
<td>Current CPU frequency in GHz</td>
</tr>

<tr>
<td><b>CPU_TEMP</b></td>
<td>Detected CPU/system temperature when available</td>
</tr>

<tr>
<td><b>CPU_USAGE</b></td>
<td>Current CPU utilization percentage</td>
</tr>

<tr>
<td><b>RAM_USED</b></td>
<td>Used system memory in GB</td>
</tr>

<tr>
<td><b>RAM_TOTAL</b></td>
<td>Total system memory in GB</td>
</tr>

<tr>
<td><b>RAM_PERCENT</b></td>
<td>Memory utilization percentage</td>
</tr>

<tr>
<td><b>SWAP_USED</b></td>
<td>Used Swap memory in GB</td>
</tr>

<tr>
<td><b>SWAP_TOTAL</b></td>
<td>Total Swap memory in GB</td>
</tr>

<tr>
<td><b>SWAP_PERCENT</b></td>
<td>Swap utilization percentage</td>
</tr>

<tr>
<td><b>DISK_USED</b></td>
<td>Used space on the root filesystem</td>
</tr>

<tr>
<td><b>DISK_TOTAL</b></td>
<td>Total space on the root filesystem</td>
</tr>

<tr>
<td><b>DISK_PERCENT</b></td>
<td>Root filesystem utilization</td>
</tr>

<tr>
<td><b>LAN_IP</b></td>
<td>IPv4 address of the detected primary network interface</td>
</tr>

<tr>
<td><b>DOWNLOAD</b></td>
<td>Current download rate in MB/s</td>
</tr>

<tr>
<td><b>UPLOAD</b></td>
<td>Current upload rate in MB/s</td>
</tr>

<tr>
<td><b>LINK_SPEED</b></td>
<td>Detected network link speed</td>
</tr>

<tr>
<td><b>FILEBROWSER</b></td>
<td>FileBrowser systemd service status</td>
</tr>

<tr>
<td><b>QUAKEWORLD</b></td>
<td>QuakeWorld Server process status</td>
</tr>

<tr>
<td><b>QUAKEWORLD_PORT</b></td>
<td>Detected QuakeWorld Server port</td>
</tr>

<tr>
<td><b>TAILSCALE</b></td>
<td>Tailscale systemd service status</td>
</tr>

<tr>
<td><b>TAILSCALE_IP</b></td>
<td>Tailscale IPv4 address</td>
</tr>

<tr>
<td><b>UPTIME</b></td>
<td>Server uptime</td>
</tr>

</table>

---

## <img width="32" alt="image" src="https://github.com/user-attachments/assets/051f3e0d-6c82-4089-9f54-f597b60108d3" /> QuakeWorld Monitoring

The <b>Server Monitor</b> can detect the QuakeWorld Server process running on the system.

Detection is performed by looking for the:

<pre><code>qwsv</code></pre>

process together with its:

<pre><code>-port</code></pre>

parameter.

The API exposes:

<pre><code>QUAKEWORLD
QUAKEWORLD_PORT</code></pre>

Example:

<pre><code>QUAKEWORLD=ONLINE
QUAKEWORLD_PORT=27500</code></pre>


The Home Server Control Panel is responsible only for <b>monitoring</b> the QuakeWorld server.

For server administration, configuration, start and stop controls, use the dedicated project:
  <a href="https://github.com/joaoandradegp-wq/DOS-Game_Launcher/tree/main/DEV/qw_server">QuakeWorld Server Panel</a>

---

## 🌐 Monitor Web Interface

The monitoring installation creates the following directory:

<pre><code>~/Monitor/</code></pre>

with the main API located at:

<pre><code>~/Monitor/api.py</code></pre>

The application also creates:

<pre><code>~/Monitor/web/</code></pre>

and a Windows launcher:

<pre><code>~/Monitor/web.bat</code></pre>

The launcher opens Microsoft Edge in application/kiosk mode using:

<pre><code>http://SERVER_NAME:8181/monitor</code></pre>

The FastAPI application exposes the <code>/monitor</code> route and loads:

<pre><code>web/index.html</code></pre>

from the monitor installation directory.

---

## 🏗️ Architecture

<pre><code>                         Linux Home Server
                                │
                  ┌─────────────┴─────────────┐
                  │                           │
                  ▼                           ▼
        Home Server Control Panel       QuakeWorld Server
                  │                           │
        ┌─────────┼──────────┐                │
        │         │          │                │
      Samba     Conky    FileBrowser          │
        │         │          │                │
        └─────────┴──────────┘                │
                  │                           │
                  ▼                           │
            Server Monitor ◄──────────────────┘
                  │
                  ▼
              FastAPI
                  │
                  ├── /monitor
                  │
                  └── /api/monitor
                         │
                       :8181</code></pre>

The graphical Control Panel manages the local server configuration and services.

The <b>Server Monitor</b> runs independently as a <code>systemd</code> service and provides system information through FastAPI.

The <b>QuakeWorld Server</b> is monitored by the API but is not administered by this application.

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
<td><b>File Sharing</b></td>
<td>Samba</td>
</tr>

<tr>
<td><b>Disk Monitoring</b></td>
<td>Conky</td>
</tr>

<tr>
<td><b>File Management</b></td>
<td>FileBrowser</td>
</tr>

<tr>
<td><b>Remote Access</b></td>
<td>Tailscale</td>
</tr>

<tr>
<td><b>Game Server</b></td>
<td>QuakeWorld Server</td>
</tr>

<tr>
<td><b>Service Management</b></td>
<td>systemd</td>
</tr>

</table>

---

<p align="center">
  <b>Home Server Control Panel</b><br>
  Lightweight server management, service control and system monitoring.
</p>
