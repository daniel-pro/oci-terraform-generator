{%- if oci_file_storage_mount_targets is defined %}

{% for item in oci_file_storage_mount_targets %}

resource "oci_file_storage_mount_target" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    availability_domain = "{{ item.availability_domain }}"
    display_name = "{{ item.name }}"
    subnet_id = "oci_core_subnet.{{ item.subnet_name }}.id"
    hostname_label = "{{ item.hostname_label }}"
    ip_address = "{{ item.ip_address }}"
}
{% endfor %}
{%- endif %}
