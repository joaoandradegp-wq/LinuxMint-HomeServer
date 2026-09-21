<h1 align="center">🖥️ Control Panel</h1>

<p align="center">
Control Panel is a lightweight graphical management application designed to control and monitor essential components of a Linux home server.
It provides a simple Tkinter interface for managing Samba shares, Conky disk monitoring, FileBrowser, and a Server Monitor API.
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

The **Control Panel** provides a graphical interface for managing common services and monitoring a lightweight Linux home server.

The application currently provides four main management areas:

* 📁 Samba Shares
* 📊 Conky Disks
* 🌐 FileBrowser
* 📡 Server Monitor

The main application is built with **Python and Tkinter**, while the monitoring API uses **FastAPI, Uvicorn and psutil**.

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

<li>Create missing directories automatically</li>

<li>Apply directory permissions</li>

<li>Restart Samba after configuration</li>

</ul>

<p><b>Configuration:</b></p>

<pre><code>/etc/samba/smb.conf</code></pre>

</td>

<td width="50%" valign="top">

<h3>📊 Conky Manager</h3>

<ul>

<li>View disks configured in Conky</li>

<li>Add monitored disks</li>

<li>Edit disk names and mount points</li>

<li>Remove disks from monitoring</li>

<li>Update <code>~/.conkyrc</code></li>

<li>Restart Conky after changes</li>

</ul>

<p><b>Configuration:</b></p>

<pre><code>~/.conkyrc</code></pre>

</td>

</tr>

<tr>

<td width="50%" valign="top">

<h3>🌐 FileBrowser</h3>

<ul>

<li>Display the configured FileBrowser root path</li>

<li>Detect the FileBrowser systemd service</li>

<li>Show service status</li>

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

<li>CPU monitoring</li>

<li>RAM and Swap monitoring</li>

<li>Disk monitoring</li>

<li>Network monitoring</li>

<li>Service status monitoring</li>

<li>Tailscale status</li>

<li>Server uptime</li>

<li>QuakeWorld server detection</li>

<li>QuakeWorld server port detection</li>

</ul>

<p><b>API:</b></p>

<pre><code>http://SERVER_NAME:8181/api/monitor</code></pre>

</td>

</tr>

</table>

---

## 🎮 QuakeWorld Monitoring

The **Server Monitor** can detect the QuakeWorld Server process running on the system.

The monitoring API provides two additional fields:

```text
QUAKEWORLD
QUAKEWORLD_PORT
```

Example:

```text
QUAKEWORLD=ONLINE
QUAKEWORLD_PORT=27500
```

The detection is based on the **QuakeWorld Server (`qwsv`) process** and its configured port.

The Home Server Control Panel is responsible for **monitoring** the QuakeWorld server.

For server administration, configuration, start and stop controls, use the dedicated project:
  <a href="https://github.com/joaoandradegp-wq/DOS-Game_Launcher/tree/main/DEV/qw_server">QuakeWorld Server Panel</a>

---

## 🖥️ Application Interface

The Control Panel uses a tabbed interface containing four management areas.

```text
┌────────────────────────────────────────────────────────┐
│              Home Server Control Panel                 │
├──────────┬───────────┬─────────────┬───────────────────┤
│  Shares  │   Conky   │ FileBrowser │  Server Monitor   │
├──────────┴───────────┴─────────────┴───────────────────┤
│                                                        │
│                   Module Content                       │
│                                                        │
├────────────────────────────────────────────────────────┤
│                   Action Toolbar                       │
└────────────────────────────────────────────────────────┘
```

---

## 🏗️ Architecture

```text
                    Linux Home Server
                           │
             ┌─────────────┴─────────────┐
             │                           │
             ▼                           ▼
    Home Server Control Panel       QuakeWorld Server
             │                           │
     ┌───────┼────────┐                  │
     │       │        │                  │
   Samba   Conky  FileBrowser            │
             │                           │
             └──────────┐                │
                        ▼                │
                 Server Monitor ◄────────┘
                        │
                        ▼
                 FastAPI /api/monitor
                        │
                     Port 8181
```

The Control Panel manages the main home server components and monitors the QuakeWorld server status.

The dedicated **QuakeWorld Server Panel** is responsible for the administration of the QuakeWorld server itself.

---

## 📡 Monitoring API

The Server Monitor provides a local FastAPI endpoint on port **8181**.

```text
http://SERVER_NAME:8181/api/monitor
```

The API provides plain-text key/value information for easy integration with monitoring applications and dashboards.

### Main Metrics

```text
CPU
RAM
SWAP
DISK
NETWORK
FILEBROWSER
TAILSCALE
UPTIME
QUAKEWORLD
QUAKEWORLD_PORT
```

---

## 🛠️ Technologies

<table>

<tr>
<td><b>Language</b></td>
<td>Python 3</td>
</tr>

<tr>
<td><b>GUI</b></td>
<td>Tkinter</td>
</tr>

<tr>
<td><b>API</b></td>
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
<td>QuakeWorld Server 2.30</td>
</tr>

</table>

---

## 🔐 Administrator Access

Operations that require elevated privileges use `sudo`.

The Control Panel displays a graphical administrator password dialog when required.

Administrative operations include:

* Samba configuration
* Service management
* Server Monitor installation
* Systemd configuration

---

## ⚠️ Notes

<ul>

<li>Designed for lightweight Linux home servers.</li>

<li>The application requires Python 3.</li>

<li>Administrative operations require sudo privileges.</li>

<li>The Server Monitor API runs on port <code>8181</code>.</li>

<li>The QuakeWorld integration is used for monitoring the server status and port.</li>

<li>QuakeWorld server administration is handled by the dedicated QuakeWorld Server Panel.</li>

<li>The API is intended primarily for use within a trusted network.</li>

</ul>

---

<p align="center">
  <b>Home Server Control Panel</b><br>
  Lightweight server management and monitoring.
</p>
