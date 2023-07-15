# Ansible
https://www.ansible.com/

![Ansible Logo](images/ansible-logo.png?raw=true "Ansible Logo")

## About
Ansible is an open-source software provisioning, configuration management, and application-deployment tool. It runs on many Unix-like systems, and can configure both Unix-like systems as well as Microsoft Windows. It includes its own declarative language to describe system configuration in YAML.

## Molecule 
https://molecule.readthedocs.io/en/latest/

Molecule project is designed to aid in the development and testing of Ansible roles and can speed up local development of Ansible roles and playbooks in magnetude!

Molecule provides support for testing with multiple instances, operating systems and distributions, virtualization providers, test frameworks and testing scenarios.

Molecule encourages an approach that results in consistently developed roles that are well-written, easily understood and maintained.

Molecule supports only the latest two major versions of Ansible (N/N-1), meaning that if the latest version is 2.9.x, we will also test our code with 2.8.x.

## Ansible Tasks

When Ansible is executed it uses site.yml as the entry point, this simply points it to the __tasks__ directory.

Because Ansible can operate on Windows, Linux (Deb and RPM based) systems, it's wise to split the tasks up to make it more readable. 

## Main.yml
Let's first look at the main.yml 

As you can see below we are using Ansible Facts to direct the different Operating Systems to their own Task file. 

[filename](roles/ansible-role-example-role/tasks/main.yml ':include :type=code')

## Enterprise Linux
Let's have a look at Enterprise Linux (RPM YUM based) el.yml

[filename](roles/ansible-role-example-role/tasks/el.yml ':include :type=code')

## Debian/Ubuntu Linux
Let's have a look at Debian/Ubuntu Linux (DEB based) deb.yml

[filename](roles/ansible-role-example-role/tasks/deb.yml ':include :type=code')

## Windows
Let's have a look at Windows windows.yml

[filename](roles/ansible-role-example-role/tasks/windows.yml ':include :type=code')

## Molecule example

Using Molecule, we can quickly test our Role or Playbook against many Operating Systems. 

In our Ansible Role Example Role which supports Redhat, Centos, Ubuntu, Debian and Windows we have an example Molecule YAML file 

[filename](roles/ansible-role-example-role/molecule/default/molecule.yml ':include :type=code')

## Practicle example
Molecule use providers such as docker or virtualbox to create the target instances to run the playbook against. 

The Targets are configured in molecule/molecule.yml

For this example we will use: 
- Ubuntu 22.04
- Windows 2019

### Run Molecule

From the Hashiqube Cloned repo do: 
`cd ansible/roles/ansible-role-example-role && ./run.sh`

## Ansible Role Example Role
An example Ansible Role that you can use which covers, Red Hat, Centos, Ubuntu, Debian and Windows Targets. 

Further reading see: [__Ansible Role Example Role__](ansible/roles/ansible-role-example-role/#ansible-role-example-role) 

## Ansible Galaxy Roles
Ansible Galaxy is the Ansible's official community hub for sharing Ansible roles. It is a community and a shared resource hub where people can download roles or Playbooks

To download community roles and playbooks from remote repositories you need a requirements.txt file foe example

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

- src: 'https://github.com/ansible-lockdown/UBUNTU20-CIS'
  version: '1.1.0'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/UBUNTU18-CIS'
  version: '1.3.0'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/Windows-2016-CIS'
  version: '1.2.1'
  scm: 'git'

- src: 'https://github.com/ansible-lockdown/Windows-2019-CIS'
  version: '1.1.1'
  scm: 'git'

- src: 'https://github.com/star3am/ansible-role-win_openssh'
  version: 'ssh-playbook-test'
  scm: 'git'

- src: 'https://github.com/elastic/ansible-elasticsearch'
  version: 'v7.17.0'
  scm: 'git'
```

You can then download them by using this command: 
`ansible-galaxy install -f -r ansible/galaxy/requirements.yml -p ansible/galaxy/roles/`

## Ansible Role Example Role 

## About
This is an Ansible Example Role used for training and development

## Gotcha's (Sorry!!)
- M1 and M2 Mac Architectures are NOT supported at this stage
- Hyper-V is not supported at this stage
- Your Vagrant version on Windows and in WSL *MUST* be the same 
- Installing WSL could give error: `Catastrophic failure`
``` 
PS C:\Windows\system32> wsl --install
Installing: Windows Subsystem for Linux
Catastrophic failure
```
Restart laptop, run this installation command again, and make sure nothing is downloading in the background at the same time when running the command.


- WSL Ubuntu Install could give error: `An error occurred during installation. Distribution Name: 'Ubuntu' Error Code: 0x8000ffff`
```
PS C:\WINDOWS\system32> wsl --install -d ubuntu
Installing: Ubuntu
An error occurred during installation. Distribution Name: 'Ubuntu' Error Code: 0x8000ffff
```
Follow this link: https://askubuntu.com/questions/1434150/wsl-ubuntu-installation-fails-with-the-error-please-restart-wsl-with-the-follo and 
https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package

Note : Run ``` wsl --install -d Ubuntu ``` in **non administrative** mode in powershell

![wsl.png](roles/ansible-role-example-role/wsl.PNG)

```
PS C:\Users\User> wsl --shutdown
PS C:\Users\User> wsl --unregister Ubuntu
```
- If you have error when creating python virtual env: ![image-1.png](roles/ansible-role-example-role/image-1.png)
Close WSL and run `Restart-Service -Name "LxssManager"` as **Administrator in Powershell**, restart WSL and `./run.sh` again

- If you have error when bringing up VM: `vagrant was unable to communicate with the guest machine within the configured time period`
![image-5.png](roles/ansible-role-example-role/image-5.png)
Set WSL Ubuntu Distro to version 1: run `wsl --set-version Ubuntu 1` in powershell, restart WSL and run `./run.sh` again

## Get Started!
:bulb: __IMPORTANT__ Install these Tools first, before we start actually using Molecule to develop our Ansible Roles

- Git - https://git-scm.com 
- VSCode - https://code.visualstudio.com
- Vagrant - https://www.vagrantup.com
- Virtualbox - https://www.virtualbox.org
- Python and Pip - https://www.python.org
- Windows Subsystem for Linux WSL (Windows Operating System), install as **Administrator in Powershell** - https://learn.microsoft.com/en-us/windows/wsl/install 
- WSL Ubuntu Distro, install as **Non-Administrator in Powershell** `wsl --install -d Ubuntu`
- Set WSL Ubuntu Distro to version 1 `wsl --set-version Ubuntu 1`
- SSHPass - https://www.cyberciti.biz/faq/how-to-install-sshpass-on-macos-os-x/

## Supported OSs
The Role supports the following Operating Systems and versions
See: `molecule/default/molecule.yml`

| Name | Docker | Virtualbox | Hyper-V | Host Arch | Host OS
|------|--------|------------|---------|-----------|---------|
| Windows 2016 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Windows 2019 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Redhat 7.9 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Redhat 8.3 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Centos 7.7 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Centos 8.3 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Ubuntu 18.04 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Ubuntu 20.04 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Ubuntu 22.04 | ✘ | ✓ | ✘ | amd64 | Windows, Mac, Linux |
| Debian 9 | ✘ | ✘ | ✘ | amd64 | Windows, Mac, Linux |
| Debian 10 | ✘ | ✘ | ✘ | amd64 | Windows, Mac, Linux |

## Instructions 
Here is how you can get up and running quickly, this section is devided into `Windows using Windows Subsystem for Linux WSL` and `Mac OSX` (Sorry Intel Mac's only at this stage) and Linux

### Linux (Ubuntu recommended)
Install all the Tools you need in the [__Get Started Section__](#get-started-dependencies-the-tools-you-will-need) 

Install Python

```bash
sudo apt update && sudo apt-get install -y python3 python3-pip python3-dev python3-virtualenv python3-venv
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 --force
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 --force
```
Install SSHPass program

```bash
sudo apt-get install -y sshpass
```

Install Hashicorp Package Sources

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg 

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install vagrant

echo 1 > /proc/sys/fs/binfmt_misc/WSLInterop
```

Install Powershell in Ubuntu on WSL

```bash
sudo apt-get install -y wget apt-transport-https software-properties-common

wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"

sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update

sudo apt-get install -y powershell
```

Now let's run Molecule by going into the source directory where you cloned this repo, usually in Ubuntu on WSL somewhere under `/mnt/c/....`

and do

`./run.sh`


Allow all 3 types of network when set up Firewall for VirtualBox
![image-2.png](roles/ansible-role-example-role/image-2.png)

### Mac 
Install all the Tools you need in the [__Get Started Section__](#get-started-dependencies-the-tools-you-will-need) 

Install SSHPass

```bash
brew tap esolitos/ipa
brew install esolitos/ipa/sshpass
brew install sshpass
```

Now let's run Molecule by going into the source directory where you cloned this repo

and do

`./run.sh`

After Molecule bringing up the Ubuntu VM in VirtualBox, to test connection to vagrant in VM, open a new WSL Ubuntu window, and run `ssh vagrant@127.0.0.1 -p 3225` or `ssh vagrant@localhost -p 3225`. Login with password: `vagrant`. 

Succesful ouput should be as below:
![image-4.png](roles/ansible-role-example-role/image-4.png)

## Windows (Ubuntu with WSL)
![Ansible Molecule on Windows](roles/ansible-role-example-role/images/molecule-run-on-wsl-windows.png?raw=true "Ansible Moleculeon Windows")

## Ansible Molecule, Mac Intel
## Vagrant and Virtualbox
![Ansible Molecule on Mac Intel](roles/ansible-role-example-role/images/molecule-run-on-mac-intel.png?raw=true "Ansible Moleculeon Mac Intel")

## Links
- https://developer.hashicorp.com/vagrant/docs/other/wsl#path-modifications
- https://stackoverflow.com/questions/45375933/vagrant-wsl-cant-access-virtualbox
- https://learn.microsoft.com/en-us/windows/wsl/install
- https://molecule.readthedocs.io/en/latest/getting-started.html
- https://www.ansible.com/hubfs//AnsibleFest%20ATL%20Slide%20Decks/Practical%20Ansible%20Testing%20with%20Molecule.pdf
- https://www.jeffgeerling.com/blog/2018/testing-your-ansible-roles-molecule
- https://app.vagrantup.com/jborean93
- https://github.com/jborean93/packer-windoze

## Common Errors 

```log
fatal: [ansible-role-example-role-ubuntu-2204]: FAILED! => {"msg": "to use the 'ssh' connection type with passwords or pkcs11_provider, you must install the sshpass program"}
```
Did you install the SSHPass application? See [__Get Started Section__](#get-started-dependencies-the-tools-you-will-need) 
