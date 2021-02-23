{%- if oci_file_storage_filesystems is defined %}

{% for item in oci_file_storage_filesystems %}

resource "oci_file_storage_file_system" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    availability_domain = "{{ item.availability_domain }}"
    display_name = "{{ item.name }}"
}
{% endfor %}
{%- endif %}
