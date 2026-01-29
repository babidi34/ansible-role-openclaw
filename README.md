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
Voir `defaults/main.yml` et `vars/main.yml` (a completer).

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
