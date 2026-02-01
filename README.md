# Ansible Role: OpenClaw

An Ansible role to deploy and configure [OpenClaw](https://openclaw.ai/), a personal AI assistant with MCP server support.

## Features

- ✅ Multiple installation methods (npm recommended)
- ✅ MCP Server support (Filesystem, GitHub, GitLab, Docker)  
- ✅ Secure credential management with Ansible Vault
- ✅ Multi-LLM provider support
- ✅ Security hardening (systemd + firewall)
- ✅ Healthcheck monitoring

## Requirements

- Ansible >= 2.12
- Ubuntu 22.04/20.04
- Node.js >= 22 (auto-installed)

## Installation

```bash
ansible-galaxy install babidi34.openclaw
```

## Quick Start

```yaml
---
- hosts: openclaw_servers
  become: yes
  roles:
    - role: babidi34.openclaw
      vars:
        openclaw_llm_provider: "anthropic"
        openclaw_llm_anthropic_api_key: "{{ vault_anthropic_key }}"
```

## Documentation

See [examples/](examples/) for detailed playbook examples.

## License

MIT - Karim Baidi (@babidi34)
