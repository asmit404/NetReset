# Reset Windows Network & Firewall Settings
# WARNING: This will forget all saved Wi-Fi networks and firewall rules

Write-Host "This will reset all network and firewall settings." -ForegroundColor Yellow
$confirm = Read-Host "Are you sure you want to continue? (Y/N)"
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Cancelled." -ForegroundColor Red
    exit
}

# Must run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit
}

Write-Host "Resetting network adapters..."
Get-NetAdapter | ForEach-Object {
    Disable-NetAdapter -Name $_.Name -Confirm:$false
    Enable-NetAdapter -Name $_.Name -Confirm:$false
}

Write-Host "Flushing DNS and resetting TCP/IP stack..."
ipconfig /flushdns
netsh int ip reset
netsh winsock reset

Write-Host "Forgetting all Wi-Fi networks..."
netsh wlan delete profile name=*

Write-Host "Resetting firewall to defaults..."
netsh advfirewall reset
Write-Host "Enabling firewall for all profiles..."
netsh advfirewall set allprofiles state on
Write-Host "Blocking all inbound connections..."
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound

Write-Host "Reset complete. Please restart your computer for changes to take effect." -ForegroundColor Green