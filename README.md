# NetReset

## Overview

This repository contains scripts to reset network and firewall settings to default on both macOS and Windows systems.

- **macos_reset_network_and_firewall.sh**: Resets network and firewall settings on macOS.
- **windows_reset_network_and_firewall.ps1**: Resets network and firewall settings on Windows.

> **WARNING:** These scripts will reset all network and firewall settings on your system. All saved Wi-Fi networks and custom firewall rules will be lost. Use with caution.

---

## macOS: Reset Network and Firewall

### Prerequisites

- macOS system
- Administrator privileges

### Steps

1. Open Terminal.
2. Navigate to the script directory:

   ```sh
   cd /path/to/NetReset
   ```

3. Make the script executable (if not already):

   ```sh
   chmod +x macos_reset_network_and_firewall.sh
   ```

4. Run the script:

   ```sh
   ./macos_reset_network_and_firewall.sh
   ```

5. Follow the on-screen prompts and enter your password when asked.

**Note:** You may need to reconnect to Wi-Fi manually after running the script.

---

## Windows: Reset Network and Firewall

### Prerequisites

- Windows system
- Run as Administrator

### Steps

1. Open PowerShell as Administrator.
2. Navigate to the script directory:

   ```powershell
   cd C:\path\to\NetReset
   ```

3. Allow script execution temporarily

   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```

4. Run the script:

   ```powershell
   .\windows_reset_network_and_firewall.ps1
   ```

5. Follow the on-screen prompts.

**Note:** Please restart your computer after running the script for all changes to take effect.

---

## Disclaimer

These scripts are provided as-is. Use at your own risk. Always back up important settings before running system-level scripts.
