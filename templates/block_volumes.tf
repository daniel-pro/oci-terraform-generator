{%- if oci_block_volumes is defined %}

{% for item in oci_block_volumes %}
resource "oci_core_volume" "{{ item.name }}" {
    compartment_id = "oci_identity_compartment.{{ item.compartment_name }}.id"
    availability_domain = "{{ item.availability_domain }}" 
    display_name = "{{ item.name }}"
    size_in_gbs  = "{{ item.size_in_gbs }}"

{% if item.backup_policy_id is defined %}
    backup_policy_id = "$oci_core_backup_policy.{{ item.backup_policy_name }}.id"
{% endif %}

{% if (item.source_details_id is defined) and (item.source_details_type is defined) %}
    source_details {
        id = "oci_core_volume.{{ item.source_volume_name }}.id"
        type = "{{ item.source_volume_type }}"
    }
    backup_policy_id = "$oci_core_backup_policy.{{ item.backup_policy_name }}.id"
{% endif %}


{% if item.kms_key_id is defined %}
    backup_policy_id = "$oci_core_kms_key.{{ item.kms_key_name }}.id"
{% endif %}

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

}
{% endfor %}

{% for item in oci_block_volumes %}
data "oci_core_volume" "{{ item.name }}" {
    volume_id = oci_core_volume.{{ item.name }}.id
}
{% endfor %}
{%- endif %}
