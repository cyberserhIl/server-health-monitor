# 🖥️ Server Health Monitor (v1.0)

**Monitor CPU, RAM, and disk usage** – A simple script to check server health.

## ✨ Features

- **CPU usage check** – Alerts if CPU usage is high (>=85%).
- **RAM usage check** – Alerts if RAM usage is high (>=80%).
- **Disk usage check** – Alerts if disk usage is high (>=90%).

## 🧩 Requirements

- Bash 4.0+
- `awk`, `df`, `free` installed
- Linux / macOS / WSL

## 🚀 Installation

```bash
git clone https://github.com/cyberserhIl/server-health-monitor.git
cd server-health-monitor
chmod +x server_health_monitor.sh
sudo cp server_health_monitor.sh /usr/local/bin/server-health-monitor
```

## 📖 Usage

```bash
server-health-monitor
```

It will show CPU, RAM, and disk usage and alert if values are high.

## ⚠️ Troubleshooting

- **Error: command not found** → Check `/usr/local/bin` is in your `$PATH`
- **Permission denied** → Run `chmod +x server_health_monitor.sh`

## 🤝 Contributing

Pull requests and suggestions are welcome.

## 🪪 License

MIT © [Serhii Chornobai](https://github.com/cyberserhIl)
