# Ansible Role: moltbot

Role Ansible pour installer et configurer un serveur moltbot optimise et securise.

## Prerequis
- Ansible >= 2.12

## Role Variables
Voir `defaults/main.yml` et `vars/main.yml`.

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
