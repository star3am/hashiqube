# Ansible

<div align="center">
  <img src="images/ansible-logo.png" alt="Ansible Logo" width="300px">
  <br><br>
  <p><strong>Automate infrastructure management with Ansible's Configuration as Code approach</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps Lab, you'll learn about Ansible—what it is and how to use it. This guide includes a hands-on Ansible Role example that runs on multiple operating systems and has Molecule integration for testing.

Ansible is an open-source software provisioning, configuration management, and application-deployment tool. It works with:

- Unix-like systems
- Microsoft Windows
- Uses its own declarative language based on YAML

As a Configuration as Code system, Ansible can automate a wide variety of IT tasks, helping you standardize your infrastructure management.

## 🧪 Molecule

<div align="center">
  <p><em>Speed up your Ansible development with comprehensive testing</em></p>
</div>

Molecule is designed to aid in the development and testing of Ansible roles, dramatically speeding up local development of Ansible roles and playbooks. It provides:

- Support for testing with multiple instances, operating systems, and distributions
- Various virtualization providers
- Different test frameworks and testing scenarios

Molecule encourages an approach that results in consistently developed roles that are well-written, easily understood, and maintained.

> Note: Molecule supports only the latest two major versions of Ansible (N/N-1), meaning that if the latest version is 2.9.x, it will also test with 2.8.x.

## 📚 Ansible Tasks Structure

When Ansible is executed, it uses `site.yml` as the entry point, which directs it to the __tasks__ directory.

Since Ansible can operate on Windows, Linux (Debian and RPM-based) systems, it's wise to split the tasks into separate files to improve readability.

### Main Task File

The `main.yml` file uses Ansible Facts to direct different operating systems to their own task files:

```yaml
---
- name: import OS specific tasks
  ansible.builtin.import_tasks: "{{ lookup('first_found', params) }}"
  vars:
    params:
      files:
        - "{{ ansible_distribution | lower }}-{{ ansible_distribution_major_version }}.yml"
        - "{{ ansible_distribution | lower }}.yml"
        - "{{ ansible_os_family | lower }}.yml"
        - "{{ ansible_system | lower }}.yml"
      paths:
        - "{{ role_path }}/tasks"

- name: import os family tasks
  ansible.builtin.include_tasks: "{{ ansible_os_family | lower }}.yml"
  when:
    - ansible_os_family is defined
    - ansible_os_family | lower == "redhat" or ansible_os_family | lower == "debian"

# additional tasks...
```

### Operating System-Specific Tasks

<details>
<summary><strong>🔍 Enterprise Linux (RPM/YUM-based) - el.yml</strong></summary>

```yaml
---
- name: OS
  ansible.builtin.debug:
    msg: "{{ ansible_distribution }} {{ ansible_distribution_version }} {{ ansible_distribution_release }} on {{ ansible_system_vendor }}"
  when: ansible_os_family | lower == "redhat"

# Additional tasks for Enterprise Linux...
```

</details>

<details>
<summary><strong>🔍 Debian/Ubuntu Linux (DEB-based) - deb.yml</strong></summary>

```yaml
---
- name: OS
  ansible.builtin.debug:
    msg: "{{ ansible_distribution }} {{ ansible_distribution_version }} {{ ansible_distribution_release }} on {{ ansible_system_vendor }}"
  when: ansible_os_family | lower == "debian"

# Additional tasks for Debian-based systems...
```

</details>

<details>
<summary><strong>🔍 Windows - windows.yml</strong></summary>

```yaml
---
- name: OS
  ansible.builtin.debug:
    msg: "{{ ansible_distribution }} {{ ansible_distribution_version }} on {{ ansible_system_vendor }}"
  when: ansible_os_family | lower == "windows"

# Additional tasks for Windows systems...
```

</details>

## 🧪 Molecule Testing

Molecule allows you to quickly test your Ansible Role or Playbook against many operating systems. The example role supports RedHat, CentOS, Ubuntu, Debian, and Windows.

### Molecule Configuration

Here's a sample Molecule configuration file:

```yaml
---
dependency:
  name: galaxy
driver:
  name: vagrant
platforms:
  - name: ansible-role-example-role-ubuntu-2204
    box: generic/ubuntu2204
    instance_raw_config_args:
      - "vm.network 'forwarded_port', guest: 22, host: 3225"
    memory: 1024
    cpus: 1
    groups:
      - linux
  - name: ansible-role-example-role-windows-2019
    box: jborean93/WindowsServer2019
    memory: 4096
    cpus: 2
    groups:
      - windows
provisioner:
  name: ansible
  playbooks:
    converge: ${MOLECULE_PLAYBOOK:-converge.yml}
verifier:
  name: ansible
```

### Running Molecule Tests

From the HashiQube cloned repo:

```bash
cd ansible/roles/ansible-role-example-role && ./run.sh
```

This will test your Ansible role against:

- Ubuntu 22.04
- Windows 2019

## 🌟 Ansible Role Example

The repository includes an example Ansible Role that covers:

- Red Hat and CentOS Linux
- Ubuntu and Debian Linux
- Windows

For more details, see the [__Ansible Role Example Role__](ansible/roles/ansible-role-example-role/#ansible-role-example-role) section.

## ⭐ Ansible Galaxy Roles

Ansible Galaxy is Ansible's official community hub for sharing roles. It serves as a repository where people can download pre-built roles and playbooks.

### Using Galaxy Roles

To download community roles from remote repositories, create a `requirements.yml` file:

```yaml
- src: 'https://github.com/ansible-lockdown/RHEL8-CIS'
  version: '1.3.0'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/RHEL7-CIS'
  version: '1.1.0'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/UBUNTU22-CIS'
  version: 'main'
  scm: 'git'

# Additional roles...
```

Install the roles with:

```bash
ansible-galaxy install -f -r ansible/galaxy/requirements.yml -p ansible/galaxy/roles/
```

## 🛠️ Getting Started: Setup Guide

### ⚠️ Known Issues and Limitations

- M1 and M2 Mac architectures are not currently supported
- Hyper-V is not supported
- Your Vagrant version on Windows and in WSL __MUST__ be the same
- Special setup steps needed for WSL (see below)

<details>
<summary><strong>Common WSL Installation Issues</strong></summary>

- Error: `Catastrophic failure` when installing WSL

  ```powershell
  PS C:\Windows\system32> wsl --install
  Installing: Windows Subsystem for Linux
  Catastrophic failure
  ```

  Solution: Restart your laptop and ensure nothing is downloading in the background when running the command.

- Error: `An error occurred during installation. Distribution Name: 'Ubuntu' Error Code: 0x8000ffff`

  ```powershell
  PS C:\WINDOWS\system32> wsl --install -d ubuntu
  Installing: Ubuntu
  An error occurred during installation. Distribution Name: 'Ubuntu' Error Code: 0x8000ffff
  ```

  Solution: Follow the guidance at [Microsoft Learn](https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)

  > Note: Run `wsl --install -d Ubuntu` in __non-administrative__ mode in PowerShell

- If a virtual environment creation fails:
  Close WSL and run `Restart-Service -Name "LxssManager"` as __Administrator in PowerShell__, restart WSL and run `./run.sh` again

- If you get `vagrant was unable to communicate with the guest machine within the configured time period` error:
  Set WSL Ubuntu Distro to version 1 by running `wsl --set-version Ubuntu 1` in PowerShell, restart WSL and run `./run.sh` again

</details>

### 📋 Prerequisites

Install these tools before using Molecule to develop Ansible roles:

- [Git](https://git-scm.com)
- [VSCode](https://code.visualstudio.com)
- [Vagrant](https://www.vagrantup.com)
- [VirtualBox](https://www.virtualbox.org)
- [Python and Pip](https://www.python.org)
- Windows Subsystem for Linux (WSL) - Windows only
- SSHPass for password-based SSH

### 🖥️ Supported Operating Systems

| Name | Docker | VirtualBox | Hyper-V | Host Arch | Host OS |
|------|--------|------------|---------|-----------|---------|
| Windows 2016 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Windows 2019 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| RedHat 7.9 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| RedHat 8.3 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| CentOS 7.7 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| CentOS 8.3 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Ubuntu 18.04 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Ubuntu 20.04 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Ubuntu 22.04 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Debian 9 | ✘ | ✘ | ✘ | amd64 | Windows, Mac, Linux |
| Debian 10 | ✘ | ✘ | ✘ | amd64 | Windows, Mac, Linux |

### 💻 Setup Instructions by Platform

<details>
<summary><strong>Linux (Ubuntu Recommended)</strong></summary>

1. Install Python:

   ```bash
   sudo apt update && sudo apt-get install -y python3 python3-pip python3-dev python3-virtualenv python3-venv
   sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 --force
   sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 --force
   ```

2. Install SSHPass:

   ```bash
   sudo apt-get install -y sshpass
   ```

3. Install Hashicorp Package Sources:

   ```bash
   wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

   sudo apt update && sudo apt install vagrant

   echo 1 > /proc/sys/fs/binfmt_misc/WSLInterop
   ```

4. Install PowerShell in Ubuntu on WSL (optional):

   ```bash
   sudo apt-get install -y wget apt-transport-https software-properties-common

   wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"

   sudo dpkg -i packages-microsoft-prod.deb

   sudo apt-get update

   sudo apt-get install -y powershell
   ```

5. Run Molecule:

   ```bash
   ./run.sh
   ```

> ⚠️ Allow all 3 types of network when setting up the Firewall for VirtualBox
</details>

<details>
<summary><strong>macOS (Intel Only)</strong></summary>

1. Install SSHPass:

   ```bash
   brew tap esolitos/ipa
   brew install esolitos/ipa/sshpass
   brew install sshpass
   ```

2. Run Molecule:

   ```bash
   ./run.sh
   ```

</details>

<details>
<summary><strong>Windows with WSL</strong></summary>

1. Install WSL as __Administrator in PowerShell__:

   ```powershell
   wsl --install
   ```

2. Install Ubuntu as __Non-Administrator in PowerShell__:

   ```powershell
   wsl --install -d Ubuntu
   ```

3. Set WSL version to 1:

   ```powershell
   wsl --set-version Ubuntu 1
   ```

4. Follow the Linux (Ubuntu) instructions within your WSL environment

5. Testing the connection:
   - After Molecule brings up the Ubuntu VM in VirtualBox, open a new WSL Ubuntu window
   - Run: `ssh vagrant@127.0.0.1 -p 3225` or `ssh vagrant@localhost -p 3225`
   - Login with password: `vagrant`

</details>

## 📷 Screenshots

<div align="center">
  <img src="roles/ansible-role-example-role/images/molecule-run-on-wsl-windows.png" alt="Ansible Molecule on Windows" width="85%">
  <p><em>Ansible Molecule running on Windows with WSL</em></p>
</div>

<div align="center">
  <img src="roles/ansible-role-example-role/images/molecule-run-on-mac-intel.png" alt="Ansible Molecule on Mac Intel" width="85%">
  <p><em>Ansible Molecule running on Mac Intel with Vagrant and VirtualBox</em></p>
</div>

## ❓ Troubleshooting

<details>
<summary><strong>Common Errors</strong></summary>

Error:

```bash
fatal: [ansible-role-example-role-ubuntu-2204]: FAILED! => {"msg": "to use the 'ssh' connection type with passwords or pkcs11_provider, you must install the sshpass program"}
```

Solution: Install the SSHPass application as described in the setup instructions for your platform.
</details>

## 🔗 Useful Links

- [Vagrant WSL Documentation](https://developer.hashicorp.com/vagrant/docs/other/wsl#path-modifications)
- [Vagrant WSL VirtualBox Access](https://stackoverflow.com/questions/45375933/vagrant-wsl-cant-access-virtualbox)
- [Microsoft WSL Installation Guide](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Molecule Documentation](https://molecule.readthedocs.io/en/latest/getting-started.html)
- [Practical Ansible Testing with Molecule](https://www.ansible.com/hubfs//AnsibleFest%20ATL%20Slide%20Decks/Practical%20Ansible%20Testing%20with%20Molecule.pdf)
- [Jeff Geerling: Testing Ansible Roles with Molecule](https://www.jeffgeerling.com/blog/2018/testing-your-ansible-roles-molecule)
- [Ansible Official Website](https://www.ansible.com/)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
