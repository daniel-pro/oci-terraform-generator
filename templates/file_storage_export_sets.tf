{%- if oci_file_storage_export_sets is defined %}

{% for item in oci_file_storage_export_sets %}

resource "oci_file_storage_export_set" "{{ item.name }}" {
    mount_target_id = oci_file_storage_mount_target.{{ item.mount_target_name }}.id
    display_name = "{{ item.name }}"
{% if item.max_fs_stat_bytes is defined %}
    max_fs_stat_bytes = "{{ item.hostname_label }}"
{% endif %}
{% if item.max_fs_stat_files is defined %}
    max_fs_stat_files = "{{ item.ip_address }}"
{% endif %}
}
{% endfor %}
{%- endif %}
