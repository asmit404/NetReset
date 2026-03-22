#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_BASE="https://raw.githubusercontent.com/asmit404/NetReset/main"

cleanup() {
  if [[ -n "${TMP_FILE:-}" && -f "${TMP_FILE}" ]]; then
    rm -f "${TMP_FILE}"
  fi
}
trap cleanup EXIT

download() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$output" "$url"
  else
    echo "Error: curl or wget is required to continue." >&2
    exit 1
  fi
}

os="$(uname -s)"
if [[ "$os" != "Darwin" ]]; then
  echo "Unsupported OS: ${os}" >&2
  exit 1
fi

script_url="${REPO_RAW_BASE}/macos_reset_network_and_firewall.sh"
TMP_FILE="$(mktemp /tmp/netreset-macos-XXXXXX.sh)"

echo "Pulling script..."
download "$script_url" "$TMP_FILE"
chmod +x "$TMP_FILE"

echo "Running script..."
"$TMP_FILE"