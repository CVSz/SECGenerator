#!/bin/bash
# Meta Master Bash Generator Installer System (Final Release)
# Author: PHIPHAT + Copilot

set -e

echo "=== Installing Meta Master Generator System (Final Release) ==="

# Step 1: Ensure required packages
sudo apt-get update -y
sudo apt-get install -y coreutils openssl openssh-client xclip

# Step 2: Config file for Gitea instance
META_CONFIG="$HOME/.meta_config"
if [ ! -f "$META_CONFIG" ]; then
    echo "GITEA_URL=http://your-gitea-instance.com" > "$META_CONFIG"
fi

# Step 3: Append functions to ~/.bashrc
cat << 'EOF' >> ~/.bashrc

# === Load Config ===
META_CONFIG="$HOME/.meta_config"
if [ -f "$META_CONFIG" ]; then
    source "$META_CONFIG"
fi

# === Logging Function ===
logMeta() {
    local output="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $output" >> ~/meta_results.txt
}

# === Base64 Reverse Generator ===
b64rev() {
    local text="$1"
    local b64=$(echo -n "$text" | base64)
    local rev=$(echo -n "$b64" | rev)
    local final=$(echo -n "$rev" | base64)

    echo "Original: $text"
    echo "Base64: $b64"
    echo "Base64 Reversed: $rev"
    echo "Final Base64: $final"
    logMeta "b64rev | Original: $text | Base64: $b64 | Reversed: $rev | Final: $final"
}

# === SHA-256 Hash Generator ===
sha256gen() {
    local text="$1"
    local hash=$(echo -n "$text" | sha256sum | awk '{print $1}')
    echo "Original: $text"
    echo "SHA-256: $hash"
    logMeta "sha256gen | Original: $text | SHA-256: $hash"
}

# === Full Pipeline: SHA256 → Base64 → Reverse → Base64 ===
metaPipeline() {
    local text="$1"
    local hash=$(echo -n "$text" | sha256sum | awk '{print $1}')
    local b64=$(echo -n "$hash" | base64)
    local rev=$(echo -n "$b64" | rev)
    local final=$(echo -n "$rev" | base64)

    echo "Original: $text"
    echo "SHA-256: $hash"
    echo "Base64 of SHA-256: $b64"
    echo "Reversed Base64: $rev"
    echo "Final Base64: $final"
    logMeta "metaPipeline | Original: $text | SHA-256: $hash | Base64: $b64 | Reversed: $rev | Final: $final"
}

# === SSH Key Generator (RSA + Ed25519) with Gitea Integration ===
sshkeygen_meta() {
    local email="$1"
    local rsa_key="$HOME/.ssh/id_rsa_meta"
    local ed_key="$HOME/.ssh/id_ed25519_meta"

    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    # RSA 4096
    ssh-keygen -t rsa -b 4096 -C "$email" -f "$rsa_key" -N ""
    chmod 600 "$rsa_key"

    # Ed25519
    ssh-keygen -t ed25519 -C "$email" -f "$ed_key" -N ""
    chmod 600 "$ed_key"

    echo "SSH keys generated:"
    echo "RSA: $rsa_key"
    echo "Ed25519: $ed_key"

    echo "Public RSA key:"
    cat "$rsa_key.pub"
    echo "Public Ed25519 key:"
    cat "$ed_key.pub"

    # Copy Ed25519 public key to clipboard
    xclip -sel clip < "$ed_key.pub"
    echo "Ed25519 public key copied to clipboard."

    # Open Gitea SSH settings page
    if [ -n "$GITEA_URL" ]; then
        xdg-open "$GITEA_URL/user/settings/keys" >/dev/null 2>&1 &
        echo "Opened Gitea SSH settings page: $GITEA_URL/user/settings/keys"
    else
        echo "No Gitea URL configured. Please set GITEA_URL in ~/.meta_config"
    fi

    logMeta "sshkeygen_meta | Email: $email | Keys generated at ~/.ssh | Integrated with Gitea"
}

# === Self-Update Function ===
metaUpdate() {
    local installer="$HOME/install-meta-master.sh"
    if [ -f "$installer" ]; then
        bash "$installer"
        echo "Meta Master System updated."
    else
        echo "Installer not found at $installer"
    fi
}

# === Interactive Menu ===
metaMenu() {
    echo "=== Meta Generator Menu ==="
    echo "1) Base64 Reverse Encode"
    echo "2) SHA-256 Hash"
    echo "3) Full Pipeline (SHA256 → Base64 → Reverse → Base64)"
    echo "4) Generate SSH Keys (RSA + Ed25519) with Gitea Integration"
    echo "5) Self-Update System"
    read -p "Choose option: " choice
    read -p "Enter text/email: " input

    case $choice in
        1) b64rev "$input" ;;
        2) sha256gen "$input" ;;
        3) metaPipeline "$input" ;;
        4) sshkeygen_meta "$input" ;;
        5) metaUpdate ;;
        *) echo "Invalid choice" ;;
    esac
}
EOF

# Step 4: Reload shell
echo "Reloading shell..."
source ~/.bashrc

echo "=== Meta Master Final Release Installed ==="
echo "Use 'b64rev <text>', 'sha256gen <text>', 'metaPipeline <text>', 'sshkeygen_meta <email>', 'metaUpdate', or 'metaMenu' for interactive mode."
