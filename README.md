# Ansible Role: moltbot

Role Ansible pour installer et configurer un serveur Moltbot (assistant IA autonome auto-heberge) en mode securise.

## Prerequis
- Ansible >= 2.12
- Linux (Ubuntu 22.04/24.04 recommande)
- Acces reseau sortant HTTPS vers les APIs (LLM + services)
- Runtime:
  - CLI via script officiel (installe Node.js 22+)

## Ce que fait le role (cible)
- Installe le CLI via le script officiel `install.sh` (automation possible via `--no-onboard --no-prompt`)
- Configure Moltbot (config JSON + secrets) et les profils d'auth
- Prepare le workspace par defaut `~/clawd`
- Installe le service systemd (user service) via `moltbot onboard --install-daemon`
- Prepare les channels (Telegram/Discord/WhatsApp)

## Fichiers et chemins importants (upstream)
- Config principale: `~/.clawdbot/moltbot.json`
- Credentials: `~/.clawdbot/credentials/`
- Sessions: `~/.clawdbot/agents/<agentId>/sessions/`
- Auth profiles: `~/.clawdbot/agents/<agentId>/agent/auth-profiles.json`
- Logs: `/tmp/moltbot/`
- Workspace par defaut: `~/clawd`
- Port gateway par defaut: `18789` (ne pas exposer publiquement)

## Channels (upstream)
- WhatsApp, Telegram, Discord, Slack, Signal, iMessage, etc.
- Configuration via CLI/UI (details selon provider)

## Workspace bootstrap (upstream)
- `moltbot setup` initialise `~/clawd`

## Securite (recommandations)
- Ne pas exposer le Control UI / gateway publiquement
- Toujours utiliser un token d'acces si UI exposee
- Activer le sandboxing quand possible (mode `non-main`)
- Limiter les outils et commandes via allow/deny
- Logs sans secrets en clair

## Role Variables
### Variables principales
- `moltbot_user` (defaut: `moltbot`)
- `moltbot_group` (defaut: `moltbot`)
- `moltbot_home` (defaut: `/home/moltbot`)
- `moltbot_cli_name` (defaut: `moltbot`)
- `moltbot_cli_bin` (defaut: `/usr/local/bin/moltbot`)

### Installation
- `moltbot_install_method`: `url` ou `file`
- `moltbot_install_script_url`: URL `install.sh` upstream (si `url`)
- `moltbot_install_script_file`: fichier dans `files/` (si `file`)
- `moltbot_install_flags`: flags non-interactifs (defaut `--no-onboard --no-prompt`)

### Dossiers
- `moltbot_config_dir`: `/etc/moltbot`
- `moltbot_data_dir`: `/var/lib/moltbot`
- `moltbot_log_dir`: `/var/log/moltbot`
- `moltbot_tmp_dir`: `/tmp/moltbot`
- `moltbot_upstream_dir`: `~/.clawdbot`

### Workspace
- `moltbot_workspace_dir`: `~/clawd`
- `moltbot_workspace_init`: true/false
- `moltbot_workspace_files`: liste de fichiers workspace

### Gateway
- `moltbot_gateway_bind`: `loopback` (par defaut)
- `moltbot_gateway_port`: `18789`
- `moltbot_gateway_auth_env`: nom de variable env (defaut `CLAWDBOT_GATEWAY_TOKEN`)
- `moltbot_gateway_auth_token`: valeur du token (sera ecrit dans `.env`)

### Agents & sandbox
- `moltbot_model_primary`: modele principal (ex: `gpt-4o-mini`)
- `moltbot_model_fallbacks`: liste de fallbacks
- `moltbot_models_allowlist`: map des modeles autorises
- `moltbot_sandbox_mode`: `off|non-main|all`
- `moltbot_sandbox_workspace_access`: `none|ro|rw`

### LLM (cles dans .env)
- `moltbot_llm_provider`: openai|anthropic|mistral|google|openrouter|ollama
- `moltbot_llm_api_key`: cle API generique (fallback)
- `moltbot_llm_openai_api_key`
- `moltbot_llm_anthropic_api_key`
- `moltbot_llm_mistral_api_key`
- `moltbot_llm_google_api_key`
- `moltbot_llm_openrouter_api_key`
- `moltbot_llm_ollama_base_url`

### Channels
- `moltbot_telegram_enabled`: true/false
- `moltbot_telegram_bot_token`: token Telegram (dans `.env`)
- `moltbot_telegram_dm_policy`: `pairing` par defaut
- `moltbot_telegram_allow_from`: liste d'IDs autorises
- `moltbot_telegram_groups`: map de groupes
- `moltbot_telegram_config_writes`: true/false

### Systemd user service
- `moltbot_enable_user_service`: true/false
- `moltbot_enable_linger`: true/false

## Dependencies
Aucune.

## Example Playbook
```yaml
- hosts: moltbot
  roles:
    - role: ansible-role-moltbot
```

## Notes
- Les secrets et MCP seront documentes ici (a completer).
