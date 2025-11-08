# 🖥️ Server Health Monitor (v1.3)

**Monitor CPU, RAM, and disk usage** – A lightweight Bash utility to check and log your server’s health status.

## ✨ Features


- **CPU usage check** - Warns at ≥80%, critical at ≥90%.
- **RAM usage check** - Warns at ≥75%, critical at ≥90%.
- **Disk usage check** - Warns at ≥85%, critical at ≥95%.
- **Output to file** - Save monitor output to a file using `-f` or `--file`.

## 🧩 Requirements

- Bash 4.0+
- System commands: `awk`, `df`, `free`, `grep`
- Linux / macOS / WSL

## 🚀 Installation

```bash
git clone https://github.com/cyberserhIl/server-health-monitor.git
cd server-health-monitor
chmod +x server_health_monitor.sh
sudo cp server_health_monitor.sh /usr/local/bin/server-health-monitor
```

## 📖 Usage

Run the monitor:

```bash
server-health-monitor
```

Save output to a file:

```bash
server-health-monitor -f health_log.txt
```

Show version:

```bash
server-health-monitor -v
```

Show help:

```bash
server-health-monitor -h
```

### Example output:

```bash
===========================================
   Server Health Monitor started
   Date: 2025-11-08 14:52:30
===========================================

CPU[OK]: 24%
RAM[WARNING]: 78%
Disk[CRITICAL]: 95%
```

Each section shows:

- **[OK]** - Normal
- **[WARNING]** - Approaching limit
- **[CRITICAL]** - Immediate attention required

### Options:

| Flag                | Description                  |
| ------------------- | ---------------------------- |
| `-h`, `--help`      | Show help message and exit   |
| `-v`, `--version`   | Show script version and exit |
| `-f`, `--file FILE` | Save output to a file        |


## ⚙️ How It Works

* **CPU** - Calculates usage from `/proc/stat` delta over 1 second
* **RAM** - Uses `free` to determine memory load
* **Disk** - Reads root (`/`) partition usage via `df -h`
* **Output Redirection** - If `-f` is provided, results are also saved using `tee`

## ⚠️ Troubleshooting

- **Error: command not found** → Check `/usr/local/bin` is in your `$PATH`
- **Permission denied** → Run `chmod +x server_health_monitor.sh`
- **free: command not found** → Install `procps` (Ubuntu/Debian) or `procps-ng` (Fedora/Arch)
- **No output file created** → Check that the specified directory is writable

## 🤝 Contributing

Pull requests and suggestions are welcome.

## 🪪 License

MIT © [Serhii Chornobai](https://github.com/cyberserhIl)
