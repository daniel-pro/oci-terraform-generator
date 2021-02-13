{%- if oci_boot_volume_backup_policy_assignments is defined %}

{% for item in oci_boot_volume_backup_policy_assignments %}

resource "oci_core_volume_backup_policy_assignment" "{{ item.name }}" {
    asset_id  = "data.oci_core_instance.{{ item.instance_name }}.boot_volume_id"
    policy_id = "{{ item.policy_id }}"
}

{% endfor %}
{%- endif %}

{%- if oci_volume_backup_policy_assignments is defined %}

{% for item in oci_volume_backup_policy_assignments %}

resource "oci_core_volume_backup_policy_assignment" "{{ item.name }}" {
    asset_id  = "data.oci_core_volume.{{ item.volume_name }}.id"
    policy_id = "{{ item.policy_id }}"
}

{% endfor %}
{%- endif %}

