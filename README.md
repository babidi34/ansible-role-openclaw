# Ansible Role: OpenClaw

An Ansible role to deploy and configure [OpenClaw](https://openclaw.ai/), a personal AI assistant with MCP server support.

## Features

- Multiple installation methods (npm recommended)
- MCP Server support (Filesystem, GitHub, GitLab, Docker)
- Secure credential management with Ansible Vault
- Multi-LLM provider support (Anthropic, OpenAI, Mistral, Google, OpenRouter, Ollama)
- Telegram channel integration
- **Himalaya email integration** with secure password storage via `pass`
- Security hardening (systemd + firewall)
- Healthcheck monitoring

## Requirements

- Ansible >= 2.14
- Debian 13 / Ubuntu 22.04/24.04
- Node.js >= 22 (auto-installed)

## Installation

```bash
ansible-galaxy install babidi34.openclaw
```

## Quick Start

### Basic setup with Anthropic

```yaml
- hosts: openclaw_servers
  become: yes
  roles:
    - role: babidi34.openclaw
      vars:
        openclaw_model_primary: "anthropic/claude-sonnet-4-20250514"
        openclaw_llm_anthropic_api_key: "{{ vault_anthropic_key }}"
```

### With Telegram and Mistral

```yaml
- hosts: openclaw_servers
  become: yes
  roles:
    - role: babidi34.openclaw
      vars:
        # LLM Configuration
        openclaw_model_primary: "mistral/mistral-large-latest"
        openclaw_llm_mistral_api_key: "{{ vault_mistral_key }}"

        # Telegram Configuration
        openclaw_telegram_enabled: true
        openclaw_telegram_bot_token: "{{ vault_telegram_bot_token }}"
        openclaw_telegram_dm_policy: "allowlist"
        openclaw_telegram_allow_from:
          - 123456789  # Your Telegram user ID
```

### With Himalaya Email (Secure)

```yaml
- hosts: openclaw_servers
  become: yes
  roles:
    - role: babidi34.openclaw
      vars:
        openclaw_model_primary: "anthropic/claude-sonnet-4-20250514"
        openclaw_llm_anthropic_api_key: "{{ vault_anthropic_key }}"

        # Himalaya Email Configuration
        openclaw_himalaya_enabled: true
        openclaw_himalaya_reply_policy: "manual"  # manual|auto_draft|auto_send

        # Pass integration (RECOMMENDED - secure password storage)
        openclaw_pass_enabled: true
        openclaw_pass_gpg_backup: true  # Backup GPG key to controller

        openclaw_himalaya_accounts:
          - name: "Assistant"
            email: "assistant@example.com"
            display_name: "My Assistant"
            default: true
            imap_host: "imap.example.com"
            imap_port: 993
            smtp_host: "smtp.example.com"
            smtp_port: 587
            smtp_encryption: "start-tls"
            login: "assistant@example.com"
            password: "{{ vault_mail_password }}"  # Stored securely in pass
            folder_sent: "Sent"  # Adjust to your server's folder name
```

## Key Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `openclaw_user` | `openclaw` | System user for the service |
| `openclaw_model_primary` | `""` | Primary LLM model (e.g., `mistral/mistral-large-latest`) |
| `openclaw_telegram_enabled` | `false` | Enable Telegram channel |
| `openclaw_telegram_dm_policy` | `pairing` | DM policy: `pairing`, `allowlist`, or `open` |
| `openclaw_telegram_allow_from` | `[]` | List of allowed Telegram user IDs |
| `openclaw_security_hardening` | `true` | Enable systemd security hardening |

### Himalaya Email Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `openclaw_himalaya_enabled` | `false` | Enable Himalaya email integration |
| `openclaw_himalaya_accounts` | `[]` | List of email accounts (see example above) |
| `openclaw_himalaya_reply_policy` | `disabled` | Reply policy: `disabled`, `manual`, `auto_draft`, `auto_send` |
| `openclaw_himalaya_verify_folders` | `false` | Verify/create IMAP folders (Sent, etc.) |

### Pass (Password Store) Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `openclaw_pass_enabled` | `false` | Enable pass for secure password storage |
| `openclaw_pass_gpg_key_id` | `""` | GPG key ID (auto-generated if empty) |
| `openclaw_pass_gpg_name` | `OpenClaw` | Name for generated GPG key |
| `openclaw_pass_gpg_email` | `openclaw@localhost` | Email for generated GPG key |
| `openclaw_pass_gpg_backup` | `true` | Backup GPG private key to controller |
| `openclaw_pass_gpg_backup_path` | `""` | Backup path (default: `playbook_dir/credentials/gpg-<host>.asc`) |

## LLM Providers

Configure one of the following API keys:

- `openclaw_llm_anthropic_api_key` - Anthropic (Claude)
- `openclaw_llm_openai_api_key` - OpenAI (GPT)
- `openclaw_llm_mistral_api_key` - Mistral
- `openclaw_llm_google_api_key` - Google (Gemini)
- `openclaw_llm_openrouter_api_key` - OpenRouter
- `openclaw_llm_ollama_base_url` - Ollama (local)

## Himalaya Email Integration

The role supports [Himalaya](https://pimalaya.org/himalaya/) for email capabilities. When `openclaw_pass_enabled` is true:

1. A GPG key is auto-generated (or use existing via `openclaw_pass_gpg_key_id`)
2. Email passwords are stored encrypted in `pass` (password-store)
3. Himalaya retrieves passwords via `pass show mail/<account_name>`
4. The GPG key is backed up to the Ansible controller

This prevents passwords from being stored in cleartext in configuration files.

### Email Account Options

```yaml
openclaw_himalaya_accounts:
  - name: "MyAccount"           # Account identifier
    email: "user@example.com"   # Email address
    display_name: "My Name"     # Display name (optional)
    default: true               # Default account
    imap_host: "imap.example.com"
    imap_port: 993
    smtp_host: "smtp.example.com"
    smtp_port: 587
    smtp_encryption: "start-tls"  # start-tls or tls
    login: "user@example.com"

    # Option 1: Password (stored in pass if openclaw_pass_enabled)
    password: "{{ vault_mail_password }}"

    # Option 2: Custom password command (bypasses pass)
    # password_cmd: "secret-tool lookup service imap user user@example.com"

    # Folder mappings (adjust to your server)
    folder_sent: "Sent"         # Could be: Sent, "Sent Messages", "INBOX.Sent"
    folder_drafts: "Drafts"
    folder_trash: "Trash"
```

## Documentation

See [examples/](examples/) for detailed playbook examples.

## License

MIT - Karim Baidi (@babidi34)
