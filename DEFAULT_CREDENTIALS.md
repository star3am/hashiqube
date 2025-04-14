# HashiQube Default Credentials

This document explains the default credentials for HashiQube.

## Default Credentials

HashiQube comes with default credentials for easier setup:

- **Ubuntu User**:
  - Username: `ubuntu`
  - Password: `vagrant`

- **Vault**:
  - Token: Check `/etc/vault/secure/init.file` or use the temporary token displayed during setup

## SSH Access

SSH access has been configured to work in two ways:

1. **Certificate-based authentication** (using Vault-signed certificates)
2. **Password-based authentication** (using the default password)

## Setup

To set up HashiQube with a single command, including password configuration:

```bash
./setup.sh
```

## Troubleshooting

If you encounter SSH certificate permission issues, you can:

1. Use password-based authentication with the default credentials
2. Manually fix permissions with:
   ```bash
   sudo chmod 600 /home/ubuntu/.ssh/id_rsa-cert.pub
   sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa-cert.pub
   ```

## Security Note

These default credentials are intended for development and testing environments only. 
For production environments, you should change these passwords to more secure values.
