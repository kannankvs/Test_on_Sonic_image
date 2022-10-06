

README - Inputs
===============

Details on the inputs to be provided to generate information to design or update a topology.

- Inputs have to be provided in a folder ``input`` within the playbook directory.
- All inputs except inventory to be provided in JSON format. Inventory can be provided in either CSV or JSON format.


**fabric.json**

| Key        | Type                      | Support               |Description                                             |
|------------|---------------------------|------------------------|--------------------------------------------------------|
| ``site_name``            | string        |  Recommended | Site name to be used |
| ``switch_cli_password`` | string           |  Required | cli password |
| ``management_network``    | string           |  Required | Management network to provide IPs for all devices in inventory |
| ``management_gateway``       | string        |  Required | Management gateway |
| ``automation_server_ip``                  | string            |  Required | Automation server IPv4 address where the ansible playbooks are executed |
| ``file_server_ip``                 | string          |  Required | File server IPv4 address where external files are kept |
| ``ztp_server_ip``           | string           |  Required | File server IPv4 address where ztp configs/scripts/binary are placed  |
| ``expected_os_version``               | string         |  Required | Expected OS version the devices are to be. Required for validation playbooks.  |
| ``hostname_format``                 | string         |  Recommended | Host name format. Refer note below. |
| ``enable_mgmt_vrf``            | boolean        |  Required | Enable/Disable management vrf |
| ``snmp_server``    | dictionary           |  Optional | Configures snmp_server details. Refer enterprise_sonic resource module for format. |
| ``ntp``       | dictionary        |  Optional | Configures the ntp. Refer enterprise_sonic resource module for format. |
| ``logging``                  | dictionary            |  Optional | Configures the logging server. Refer enterprise_sonic resource module for format. |
| ``radius``                 | dictionary          |  Optional | Configures the radius server. Refer enterprise_sonic resource module for format. |
| ``leaf_uplinks``           | list           |  Required | Configures the leaf uplinks  |

**Note: hostname_format**
- User can provide the hostname for any switch in the inventory input.
- If hostname is not provided in input, the playbook generates hostname based on hostname_format. hostname_format is a string format with keywords within curly braces ``{}``. The keywords will be replaced with actual values. The format should be able to generate hostnames that uniquely identifies each device.
- Keywords that can be used within the ``{}`` in the format: ``site_code, role, pod_id, pod_name, rack_id, switch_id``.
- If hostname_format is not provided, the default
``{site_code}-{role}-p{pod_id}r{rack_id}sw{switch_id}`` will be used.
Ex: ``sjc-leaf-p003r4sw01``, where sjc is the site_code, role is leaf, pod_num is 03, rack nmber is 04, switch number is  01.
- If there is only one pod, following format can be used.
``{site_code}-{role}-r{rack_id}sw{switchid}``
Ex: ``sjc-lf-r04sw01`` If site_code is not requried, use the following format. "{role}-p{pod_id}r{rack_id}sw{switchid}" Ex: leaf-p03r04sw01


**pods.json**

| Key        | Type                      | Support               | Description                                             |
|------------|---------------------------|-----------------------|---------------------------------------------------------|
| ``superspine_model``            | string        | Required | The device model for superspines |
| ``spine_model`` | string           | Required | The device model for spines |
| ``leaf_model``    | string           | Required | The device model for leafs |
| ``superspines_per_dc``       | integer        | Required | Number of superspines in the DC |
| ``spines_per_pod``                  | integer            | Required | Number of spines for each pod |
| ``leafs_per_rack``                 | integer           | Required | Number of leafs per rack |
| ``no_of_pods``           | integer           | Required | Number of pods supported  |
| ``pods``               | list        | Required | Details of each pod. Refer Note below |

**Note: pods**
List of dictionary with each dictionary containing id, name, noOfRacks for each pod

**inventory.json**

| Key        | Type                      | Support               | Description                                             |
|------------|---------------------------|-----------------------|-------------------------------------------------------|
| ``inventory.switches``            | list        | Required | List of switches |


**defaults.json**

| Key        | Type                      | Support               | Default               | Description                                             |
|------------|---------------------------|-----------------------|-----------------------|---------------------------------------------------------|
| ``switch_cli_user``            | string        | Required |  ``admin`` | cli user name. |
| ``max_lease_time`` | integer           | Required |  ``7200`` | Max lease time to be configured in dhcpd.conf |
| ``default_lease_time``    | integer           | Required |  ``600`` | default lease time to be configured in dhcpd.conf |
| ``interface_naming``       | string        | Required |  ``standard`` | interface_naming to be used |


Example: Sample Input
-------

**fabric.json**

```json
{
    "site_name": "test",
    "switch_cli_password": "force10",
    "management_network": "100.104.26.0/24",
    "management_gateway": "100.104.26.254",
    "automation_server_ip": "100.104.26.162",
    "file_server_ip": "100.104.26.162",
    "ztp_server_ip": "100.104.26.162",
    "expected_os_version": "dell_sonic_4.x_share.303-3c2a3ce52",
    "hostname_format": "{role}-p{pod_id}r{rack_id}sw{switch_id}",
    "enable_mgmt_vrf": true,
    "snmp_server": {
        "agentaddress": [
            {
                "interface":"Eth1/3"
            }
        ]
    },
    "ntp": {
        "vrf": "default",
        "server": [
           {
               "server_ip": "10.10.10.10"
           },
           {
               "server_ip": "12.12.12.12"
           }
       ]
       },
    "logging": {
      "server": [
        {
            "server_ip": "13.13.13.13",
            "vrf": "mgmt"
        }
        ]
    },
    "leaf_uplinks": ["Eth1/53","Eth1/54"],
    "radius":{
        "servers": {
            "host": [
                {
                "name": "11.11.11.11",
                "key": "key1",
                "vrf": "mgmt"
                }
            ]
        }
    }
}
```

**pods.json**

```json
{
    "superspine_model": "Z9332F-ON",
    "spine_model": "Z9332F-ON",
    "leaf_model": "Z9432F-ON",
    "superspines_per_dc": 2,
    "spines_per_pod": 2,
    "leafs_per_rack": 2,
    "no_of_pods": 1,
    "pods": [
        {
            "id": 1,
            "name": "pod_a",
            "noOfRacks": 20,
            "loopback0_network": "100.111.4.0/23"
        }
    ]
}
```
**inventory.json**

```json
{
    "inventory": {
        "switches": [
            {
                "id": 1,
                "switchId": 1,
                "role": "SUPERSPINE",
                "mac": "aa:29:ef:e9:aa:00"
            },
            {
                "id": 1,
                "podId": 1,
                "rackId": 1,
                "switchId": 1,
                "role": "SPINE",
                "mac": "0c:29:ef:e9:e3:00"
            },
            {
                "id": 1,
                "podId": 1,
                "rackId": 1,
                "switchId": 1,
                "role": "LEAF",
                "mac": "18:5a:58:1f:a9:a0"
            },
            {
                "id": 2,
                "podId": 1,
                "rackId": 1,
                "switchId": 2,
                "role": "LEAF",
                "mac": "18:5a:58:20:a6:20"
            }
        ]
    }
}
```

**defaults.json**

```json
{
    "switch_cli_user": "admin",
    "max_lease_time": 7200,
    "default_lease_time": 600,
    "interface_naming": "standard"
}
```

