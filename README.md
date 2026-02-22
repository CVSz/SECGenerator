## 📖 README
### Meta Master Bash Generator System
A developer toolkit for WSL Ubuntu that provides encoding, hashing, pipelines, SSH key generation, and Gitea integration.

#### Features
- 🔑 Base64 Reverse Encode → `b64rev <text>`
- 🔒 SHA‑256 Hashing → `sha256gen <text>`
- 🔧 Full Pipeline → `metaPipeline <text>`
- 🔐 SSH Key Generation → `sshkeygen_meta <email>` (RSA + Ed25519)
- 📋 Clipboard Integration → auto‑copies Ed25519 public key
- 🔗 Gitea Integration → opens SSH key settings page
- 📜 Logging → results saved in `~/meta_results.txt`
- ⚙️ Configurable Gitea URL → set in `~/.meta_config`
- 🔄 Self‑Update → `metaUpdate`
- 🎛️ Interactive Menu → `metaMenu`

#### Installation
```bash
bash install-meta-master.sh
```

#### Configuration
Edit `~/.meta_config` to set your Gitea instance:
```bash
GITEA_URL=http://your-gitea-instance.com
```

#### Usage
```bash
b64rev "25"
sha256gen "hello"
metaPipeline "securetext"
sshkeygen_meta "phiphat@example.com"
metaMenu
```

---

## 🔧 Gitea Push Workflow

Once installed, you can push this project into your Gitea instance:

```bash
# 1. Initialize Git repo
git init
git add install-meta-master.sh CHANGELOG.md README.md
git commit -m "Meta Master Bash Generator System - Final Release"

# 2. Add Gitea remote (replace with your instance + repo)
git remote add origin git@your-gitea-instance.com:phiphat/meta-master.git

# 3. Push to Gitea
git push -u origin master

# 4. Create release tag
git tag -a v1.0.0 -m "Meta Master Final Release"
git push origin v1.0.0
```

---

✅ With this, you now have:
- A **CHANGELOG** documenting evolution  
- A **README** for installation and usage  
- A **push workflow** with **release tagging** for Gitea  

Project is **fully closed, versioned, and production‑ready**.  
