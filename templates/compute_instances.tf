{%- if oci_compute_instances is defined %}

{% for item in oci_compute_instances %}
resource "oci_core_instance" "{{ item.name }}" {
    compartment_id = "${oci_identity_compartment.{{ item.compartment_name }}.id}"
    availability_domain = "{{ item.availability_domain }}"
    display_name = "{{ item.name }}"
    shape = "{{ item.shape }}"

    create_vnic_details {
        subnet_id = "${oci_core_subnet.{{ item.vnic_subnet_name }}.id}"
        assign_public_ip = "{{ item.vnic_assign_public_ip }}"
{% if item.vnic_defined_tags is defined %}
        defined_tags = { {{ item.vnic_defined_tags }} }
{% endif %}
{% if item.vnic_freeform_tags is defined %}
        freeform_tags = { {{ item.vnic_freeform_tags }} }
{% endif %}

        display_name = "{{ item.vnic_name }}"
        hostname_label = "{{ item.vnic_hostname_label }}"
{% if item.vnic_private_ip is defined %}
        private_ip = "{{item.vnic_private_ip }}"
{% endif %}
{% if item.vnic_skip_source_dest_check is defined %}
        skip_source_dest_check = "{{ item.vnic_skip_source_dest_check }}"
{% endif %}
    }
{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}
{% if item.fault_domain is defined %}
    fault_domain = "{{ item.fault_domain }}"
{% endif %}
{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}
    metadata {
        ssh_authorized_keys = "{{ item.ssh_authorized_keys }}"
{% if item.user_data is defined %}
        user_data = "${base64encode(file({{ user_data_filename }}))}"
{% endif %}

    }
    source_details {
        source_id = "{{ item.source_details_source_id }}"
        source_type = "image"
{% if item.source_details_boot_volume_size_in_gbs is defined %}
        boot_volume_size_in_gbs = "{{ item.source_details_boot_volume_size_in_gbs }}"
{% endif %}
{% if item.source_details_kms_key_name is defined %}
        kms_key_id = "${oci_core_kms_key.{{ item.source_details_kms_key_name }}.id}"
{% endif %}
    }
{% if item.preserve_boot_volume is defined %}
    preserve_boot_volume = {{ item.preserve_boot_volume }}
{% endif %}
#connection {
#   host = "{{ item.vnic_private_ip }}"
#   user = "opc"
#   private_key = "${file("{{ remote_exec_ssh_pkey_file }}")}"
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
    instance_id = "${oci_core_instance.{{ item.name }}.id}"
}
{% endfor %}
{%- endif %}

