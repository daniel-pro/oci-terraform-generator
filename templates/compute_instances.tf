{%- if oci_compute_instances is defined %}

{% for item in oci_compute_instances %}
resource "oci_core_instance" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    availability_domain = "{{ item.availability_domain }}"
    shape = "{{ item.shape }}"
{% if item.agent_config is defined %}
    agent_config {
{% if item.agent_config.are_all_plugins_disabled is defined %}
        are_all_plugins_disabled = "{{ item.agent_config.are_all_plugins_disabled }}"
{% endif %}
{% if item.agent_config.is_management_disabled is defined %}
        is_management_disabled = "{{ item.agent_config.is_management_disabled }}"
{% endif %}
{% if item.agent_config.is_monitoring_disabled is defined %}
        is_monitoring_disabled = "{{ item.agent_config.is_monitoring_disabled }}"
{% endif %}
{% if item.agent_config.plugins_config is defined %}
        plugins_config {
            #Required
            desired_state = "{{ item.agent_config.plugins_config.desired_state }}"
            name = "{{ item.agent_config.plugins_config.desired_state }}"
        }
{% endif %}
    }
{% endif %}
{% if item.availability_config is defined %}
    availability_config {
{% if item.availability_config.is_live_migration_preferred is defined %}
        is_live_migration_preferred = "{{ item.availability_config.is_live_migration_preferred }}"
{% endif %}
{% if item.availability_config.recovery_action is defined %}
        recovery_action = "{{ item.availability_config.recovery_action }}"
{% endif %}
    }
{% endif %}

{% if item.create_vnic_details is defined %}
    create_vnic_details {
{% if item.create_vnic_details.assign_private_dns_record is defined %}
        assign_private_dns_record = "{{ item.create_vnic_details.assign_private_dns_record }}"
{% endif %}
{% if item.create_vnic_details.assign_public_ip is defined %}
        assign_public_ip = "{{ item.create_vnic_details.assign_public_ip }}"
{% endif %}
{% if item.create_vnic_details.defined_tags is defined %}
        defined_tags = { {{ item.create_vnic_details.defined_tags }} }
{% endif %}
{% if item.create_vnic_details.name is defined %}
        display_name = "{{ item.create_vnic_details.name }}"
{% endif %}
{% if item.create_vnic_details.freeform_tags is defined %}
        freeform_tags = { {{ item.create_vnic_details.freeform_tags }} }
{% endif %}
{% if item.create_vnic_details.hostname_label is defined %}
        hostname_label = "{{ item.create_vnic_details.hostname_label }}"
{% endif %}

{% if item.create_vnic_details.nsg_names is defined %}
        nsg_ids = [
{% for network_security_group in item.create_vnic_details.nsg_names  %}
                    oci_core_network_security_group.{{ network_security_group }}.id,
{% endfor %}
        ]
{% endif %}

{% if item.create_vnic_details.private_ip is defined %}
        private_ip = "{{item.create_vnic_details.private_ip }}"
{% endif %}
{% if item.create_vnic_details.skip_source_dest_check is defined %}
        skip_source_dest_check = "{{ item.create_vnic_details.skip_source_dest_check }}"
{% endif %}
{% if item.create_vnic_details.subnet_name is defined %}
        subnet_id = oci_core_subnet.{{ item.create_vnic_details.subnet_name }}.id
{% endif %}
{% if item.create_vnic_details.vlan_id is defined %}
        vlan_id = oci_core_vlan.{{ item.create_vnic_details.vlan_name }}.id
{% endif %}
    }
{% endif %}

{% if item.dedicated_vm_host_id is defined %}
        dedicated_vm_host_id = oci_core_dedicated_vm_host.{{ item.dedicated_vm_host_id }}.id
{% endif %}

{% if item.defined_tags is defined %}
        defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.name is defined %}
        display_name = "{{ item.name }}"
{% endif %}

{% if item.extended_metadata is defined %}
        extended_metadata = {
{% for extended_metadata in item.extended_metadata %}
        {{ extended_metadata.key }} = "{{ extended_metadata.value }}"
{% endfor %}
        }
{% endif %}

{% if item.fault_domain is defined %}
        fault_domain = "{{ item.fault_domain }}"
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %} 

{% if item.hostname_label is defined %}
        hostname_label = "{{ item.hostname_label }}"
{% endif %}

{% if item.instance_options is defined %}
    instance_options {
        are_legacy_imds_endpoints_disabled = "{{ item.instance_options.are_legacy_imds_endpoints_disabled }}"

    }
{% endif %}

{% if item.ipxe_script is defined %}
        ipxe_script = "{{ item.ipxe_script }}"
{% endif %}
{% if item.is_pv_encryption_in_transit_enabled is defined %}
        is_pv_encryption_in_transit_enabled = "{{ item.is_pv_encryption_in_transit_enabled }}"
{% endif %}

{% if item.launch_options is defined %}
    launch_options {
{% if item.launch_options.boot_volume_type is defined %}
        boot_volume_type = "{{ item.launch_options.boot_volume_type }}"
{% endif %}
{% if item.launch_options.firmware is defined %}
        firmware = "{{ item.launch_options.firmware }}"
{% endif %}
{% if item.launch_options.is_consistent_volume_naming_enabled is defined %}
        is_consistent_volume_naming_enabled = "{{ item.launch_options.is_consistent_volume_naming_enabled }}"
{% endif %}
{% if item.launch_options.is_pv_encryption_in_transit_enabled is defined %}
        is_pv_encryption_in_transit_enabled = "{{ item.launch_options.is_pv_encryption_in_transit_enabled }}"
{% endif %}
{% if item.launch_options.network_type is defined %}
        network_type = "{{ item.launch_options.network_type }}"
{% endif %}
{% if item.launch_options.remote_data_volume_type is defined %}
        remote_data_volume_type = "{{ item.launch_options.remote_data_volume_type }}"
{% endif %}
    }
{% endif %}


    metadata = {
        ssh_authorized_keys = "{{ item.ssh_authorized_keys }}"
{% if item.user_data is defined %}
        user_data = "base64encode(file({{ user_data_filename }}))"
{% endif %}

    }

{% if item.platform_config is defined %}
    platform_config {

        type = "{{ item.platform_config.type }}"

{% if item.platform_config.are_virtual_instructions_enabled is defined %}
        are_virtual_instructions_enabled = "{{ item.platform_config.are_virtual_instructions_enabled }}"
{% endif %}
{% if item.platform_config.is_access_control_service_enabled is defined %}
        is_access_control_service_enabled = "{{ item.platform_config.is_access_control_service_enabled }}"
{% endif %}
{% if item.platform_config.is_input_output_memory_management_unit_enabled is defined %}
        is_input_output_memory_management_unit_enabled = "{{ item.platform_config.is_input_output_memory_management_unit_enabled }}"
{% endif %}
{% if item.platform_config.is_measured_boot_enabled is defined %}
        is_measured_boot_enabled = "{{ item.platform_config.is_measured_boot_enabled }}"
{% endif %}
{% if item.platform_config.is_secure_boot_enabled is defined %}
        is_secure_boot_enabled = "{{ item.platform_config.is_secure_boot_enabled }}"
{% endif %}
{% if item.platform_config.is_symmetric_multi_threading_enabled is defined %}
        is_symmetric_multi_threading_enabled = "{{ item.platform_config.is_symmetric_multi_threading_enabled }}"
{% endif %}
{% if item.platform_config.is_trusted_platform_module_enabled is defined %}
        is_trusted_platform_module_enabled = "{{ item.platform_config.is_trusted_platform_module_enabled }}"
{% endif %}
{% if item.platform_config.numa_nodes_per_socket is defined %}
        numa_nodes_per_socket = "{{ item.platform_config.numa_nodes_per_socket }}"
{% endif %}
{% if item.platform_config.percentage_of_cores_enabled is defined %}
        percentage_of_cores_enabled = "{{ item.platform_config.percentage_of_cores_enabled }}"
{% endif %}
    }
{% endif %}


{% if item.preemptible_instance_config is defined %}
    preemptible_instance_config {
 
        preemption_action {

            type = "{{ item.preemptible_instance_config.preemption_action.type }}"

{% if item.preemptible_instance_config.preemption_action.preserve_boot_volume is defined %}
            preserve_boot_volume = "{{ item.preemptible_instance_config.preemption_action.preserve_boot_volume }}"
        }
{% endif %}
    }
{% endif %}

{% if item.shape_config is defined %}
    shape_config {
{% if item.shape_config.baseline_ocpu_utilization is defined %}
        baseline_ocpu_utilization = "{{ item.shape_config.baseline_ocpu_utilization }}"
{% endif %}
{% if item.shape_config.memory_in_gbs is defined %}
        memory_in_gbs = "{{ item.shape_config.memory_in_gbs }}"
{% endif %}
{% if item.shape_config.nvmes is defined %}
        nvmes = "{{ item.shape_config.nvmes }}"
{% endif %}
{% if item.shape_config.ocpus is defined %}
        ocpus = "{{ item.shape_config.ocpus }}"
{% endif %}
    }
{% endif %}


    source_details {
        source_id = "{{ item.source_details.source_id }}"
        source_type = "image"
{% if item.source_details.boot_volume_size_in_gbs is defined %}
        boot_volume_size_in_gbs = "{{ item.source_details.boot_volume_size_in_gbs }}"
{% endif %}
{% if item.source_details_kms_key_name is defined %}
        kms_key_id = oci_core_kms_key.{{ item.source_details_kms_key_name }}.id
{% endif %}
    }
{% if item.preserve_boot_volume is defined %}
    preserve_boot_volume = {{ item.preserve_boot_volume }}
{% endif %}
#connection {
#   host = "{{ item.vnic_private_ip }}"
#   user = "opc"
#   private_key = "file("{{ remote_exec_ssh_pkey_file }}")"
#}
#
#provisioner "remote-exec" {
#  inline = [
#            "sudo sed -i \"s/'//g\" /root/.ssh/authorized_keys; sudo  sed -i 's/\"//g' /root/.ssh/authorized_keys;sudo  sed -i 's/\\//g' /root/.ssh/authorized_keys; sudo sed -i \"s/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command=echo Please login as the user opc rather than the user root.;echo;sleep 10 //g\" /root/.ssh/authorized_keys"
#  ]
#}


}
{% endfor %}

{% for item in oci_compute_instances %}
data "oci_core_instance" "{{ item.name }}" {
    instance_id = oci_core_instance.{{ item.name }}.id
}
{% endfor %}
{%- endif %}


{% for item in oci_compute_instances %}
output "{{ item.name }}-public_ip_address" {
  value = "${oci_core_instance.{{ item.name }}.public_ip}"
}
{% endfor %}
