# Red Panda

Ansible Network Automation Framework

- [Red Panda](#red-panda)
  - [Automation Server Setup](#automation-server-setup)
  - [Inputs](#inputs)
  - [Playbooks](#playbooks)
  - [BGP Configuration](#bgp-configuration)

## Automation Server Setup

- Automation Server consists of following services
        -       Ansible
        -       DHCP Server
        -       ZTP Server

- Prerequisite

  - Create an Ubuntu Automation Server with username: devops
  - Configure IP address (preferably .1) to the server and make sure it has connectivity to internet


- Install DHCP Server

        - Commands
                sudo apt update
                sudo apt install isc-dhcp-server
        - Verification:
                sudo service isc-dhcp-server status

- Install Webserver

        - Commands
                    sudo apt-get install apache2
        - Verification
                    sudo systemctl status apache2

- Install Ansible

    Refer [Ansible Installation Documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu)
    Refer [Ansible Python3 support](https://docs.ansible.com/ansible/latest/reference_appendices/python_3_support.html)

        - Commands
                    sudo apt install python3-pip
                    pip3 install ansible
                    vi ~/.bashrc
                           export PATH=$PATH:$HOME/.local/bin
                    source .bashrc
        - Verification
                    which ansible
                    ansible --version

- Install sshpass

        - Commands
                    sudo apt-get install sshpass

- Install ansible collections for dellemc.enterprise_sonic

        ansible-galaxy collection install dellemc.enterprise_sonic

- Install needed packages for automation

        sudo apt install python3-pip
        pip3 install -r packages.txt

- Fetch red panda to a folder

        git clone https://github.com/Dell-Networking/red-panda.git
        git checkout dev

- Link danaf dev ansible collection

        cd ~/.ansible/collections/ansible_collections/dellemc/
        ln -s ~/red-panda/dellemc/danaf danaf

## Inputs

Details of inputs to be provided with example [README-inputs.md](README-inputs.md)


## Playbooks

Step 1: Validates inputs provided; Generates hostname and IPs, ansible variables/inventory, dhcp/ztp configs

```ansible-playbook playbooks/config_preDay0.yml```

Step 2: Put devices in ONIE so that DHCP is triggered and devices come up in the required sonic image and ztp configs

```ansible-playbook playbooks/install_image.yaml -e "target_os=ONIE"```

Step 3: Set Day0 common configs for all devices (hostname, ntp, snmp, tacacs+/radius, syslog, banner, interface naming mode)

```ansible-playbook playbooks/config_Day0.yml```

Step 4: Validation Playbooks

```
ansible-playbook validate_reachability.yaml
ansible-playbook validate_ztp_status.yaml
ansible-playbook validate_os_type.yaml
ansible-playbook validate_device_type.yaml
ansible-playbook validate_version.yaml
```

**Note** Detailed info of playbooks/roles/modules used [README-playbooks.md](README-playbooks.md)


## BGP Configuration

Example of setting up BGP configuration is available in [bgp_configuration.md](bgp_configuration.md)
