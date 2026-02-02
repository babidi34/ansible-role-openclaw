# Ansible Role: OpenClaw

An Ansible role to deploy and configure [OpenClaw](https://openclaw.ai/), a personal AI assistant with MCP server support.

## Features

- Multiple installation methods (npm recommended)
- MCP Server support (Filesystem, GitHub, GitLab, Docker)
- Secure credential management with Ansible Vault
- Multi-LLM provider support (Anthropic, OpenAI, Mistral, Google, OpenRouter, Ollama)
- Telegram channel integration
- Security hardening (systemd + firewall)
- Healthcheck monitoring

## Requirements

- Ansible >= 2.12
- Debian 13 / Ubuntu 22.04/20.04
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

## Key Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `openclaw_user` | `openclaw` | System user for the service |
| `openclaw_model_primary` | `""` | Primary LLM model (e.g., `mistral/mistral-large-latest`) |
| `openclaw_telegram_enabled` | `false` | Enable Telegram channel |
| `openclaw_telegram_dm_policy` | `pairing` | DM policy: `pairing`, `allowlist`, or `open` |
| `openclaw_telegram_allow_from` | `[]` | List of allowed Telegram user IDs |
| `openclaw_security_hardening` | `true` | Enable systemd security hardening |

## LLM Providers

Configure one of the following API keys:

- `openclaw_llm_anthropic_api_key` - Anthropic (Claude)
- `openclaw_llm_openai_api_key` - OpenAI (GPT)
- `openclaw_llm_mistral_api_key` - Mistral
- `openclaw_llm_google_api_key` - Google (Gemini)
- `openclaw_llm_openrouter_api_key` - OpenRouter
- `openclaw_llm_ollama_base_url` - Ollama (local)

## Documentation

See [examples/](examples/) for detailed playbook examples.

## License

MIT - Karim Baidi (@babidi34)
