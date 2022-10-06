
Readme - Code Flow
-------------------
**Provide Inputs:**

        Edit json/csv files in playbooks/input/*

**preDay0 Playbooks:**
Playbook: ```ansible-playbook playbooks/config_preDay0.yml```

Purpose: Validates inputs provided, generates hostname and IPs, ansible variables/inventory, dhcp/ztp configs

On execution of above playbook, below playbooks are imported.
- Playbook: playbooks/all/validate_input.yml

        Purpose: Validates inputs provided
        Role: dellemc/danaf/roles/generation
            tasks/validate_input.yml:
                Purpose: Validates the key attributes in the input json.
                Module: dellemc/danaf/plugins/modules/validate_input_json.py

- Playbook: playbooks/all/gen_detailed_input.yml

        Purpose: Generates detailed json with hostname and managment IPs auto-generated.
        Role: dellemc/danaf/roles/generation
            tasks/generate_detailed_input.yml:
                Purpose: Generated detailed json with hostname and management IPs.
                Module: dellemc/danaf/plugins/modules/generate_detailed_json.py
        Output:
          Detailed json: playbooks/generated_configs/jsons

- Playbook: playbooks/all/gen_ansible_vars.yml

        Purpose: Generates ansible variables required to use the enterprise sonic ansible collection.
        Role: dellemc/danaf/roles/generation
            tasks/generate_ansible_vars.yml:
                Purpose: Generates ansible variables from input json
                Module: dellemc/danaf/plugins/modules/generate_ansible_vars.py
        Output:
          Ansible vars: playbooks/group_vars

- Playbook: playbooks/all/gen_dhcp_inv_ztp.yml

        Purpose: Generate dhcp/ztp conf, inventory, etc/hosts
        Role: dellemc/danaf/roles/dhcp_inv
          tasks/generate.yml:
                tasks/inventory_gen.yml
                   Purpose: Generate ansible inventory file with the hosts and groups info
                   Template: templates/inventory_gen.j2
                tasks/etc_hosts_gen.yml
                   Purpose: Generate /etc/hosts
                   Template: templates/etc_hosts_gen.j2
                tasks/dhcp_conf_gen.yml
                   Purpose: Generate dhcpd.conf including ztp config file path
                   Template: templates/dhcpd.conf.j2
                tasks/ztp_gen.yml
                   Purpose: Generate ztp conf and scripts
                   Template: templates/ztp.j2
                   Template: templates/set-password.j2
        Output:
          Detailed json: playbooks/generated_configs

- Playbook: playbooks/all/cp_dhcp_inv_ztp.yml

        Purpose: Copies the dhcp/ztp conf, inventory, etc/hosts to the destined directories
        Role: dellemc/danaf/roles/dhcp_inv
          tasks/copy_generated.yml:
                tasks/dhcp_cp_restart.yml
                   Purpose: Copy dhcpd.copy to /etc/dhcp directory and restarts dhcp service
                tasks/etc_hosts_cp.yml
                   Purpose: Compare and update /etc/hosts file
                tasks/inventory_cp.yml
                   Purpose: Copy ansible inventory file to destination
                tasks/ztp_cp.yml
                   Purpose: Copy ztp.json and scripts generated to ztp server

**Day0 Playbooks:**
Playbook: ```ansible-playbook playbooks/install_image.yaml -e "target_os=ONIE"```

        Purpose: Put devices in ONIE so that DHCP is triggered and devices come up in the required sonic image and ztp configs
        Role: dellemc/danaf/roles/image
          tasks/main.yml:
                tasks/normalize_sonic.yml
                   Purpose: Sets next boot to ONIE and reboots the device

Playbook: ```ansible-playbook playbooks/config_Day0.yml```

        Purpose: Set Day0 common configs for all devices (hostname, ntp, snmp, tacacs+/radius, syslog, banner)
        Role: dellemc.danaf.hostname
          tasks/main.yml:
                   Purpose: Configure hostname
        Role: dellemc.danaf.ntp
          tasks/main.yml:
                   Purpose: Configure ntp
        Role: dellemc.danaf.syslog
          tasks/main.yml:
                   Purpose: Configure syslog servers
        Role: dellemc.danaf.snmp
          tasks/main.yml:
                   Purpose: Configure snmp
        Role: dellemc.danaf.banner
          tasks/main.yml:
                   Purpose: Configure banner
        Role: dellemc.danaf.radius
          tasks/main.yml:
                   Purpose: Configure radius
        Role: dellemc.danaf.aaa
          tasks/main.yml:
                   Purpose: Configure aaa
        Role: dellemc.danaf.tacacs
          tasks/main.yml:
                   Purpose: Configure tacacs+

**Validation Playbooks:**
- Playbook: ```ansible-playbook validate_reachability.yaml```

        Purpose: Waits for ssh port to check the device reachability
        Role: dellemc/danaf/roles/validation
            tasks/reachability.yml

- Playbook: ```ansible-playbook validate_ztp_status.yaml```

        Purpose: Checks the ztp status
        Role: dellemc/danaf/roles/validation
            tasks/ztp-status.yaml

- Playbook: ```ansible-playbook validate_os_type.yaml```

        Purpose: Checks the OS type in the device
        Role: dellemc/danaf/roles/validation
            tasks/os-type.yaml

-  Playbook: ```ansible-playbook validate_device_type.yaml```

        Purpose: Validates the device model
        Role: dellemc/danaf/roles/validation
            tasks/device-type.yaml

- Playbook: ```ansible-playbook validate_version.yaml```

        Purpose: Validates the version
        Role: dellemc/danaf/roles/validation
            tasks/os-version.yaml


