{%- if oci_file_storage_exports is defined %}

{% for item in oci_file_storage_exports %}

resource "oci_file_storage_export" "{{ item.name }}" {
    export_set_id = "oci_file_storage_mount_target.{{ item.mount_target_name }}.export_set_id"
    file_system_id = "oci_file_storage_file_system.{{ item.filesystem_name }}.id"
    path = "{{ item.path }}"
    export_options {
        source = "{{ item.source }}"
        access = "{{ item.access }}"
{% if item.anonymous_gid is defined %}
        anonymous_gid = "{{ item.anonymous_gid }}"
{% endif %}
{% if item.anonymous_uid is defined %}
        anonymous_uid = "{{ item.anonymous_uid }}"
{% endif %}
{% if item.identity_squash is defined %}
        identity_squash = "{{ item.identity_squash }}"
{% endif %}
{% if item.require_privileged_source_port is defined %}
        require_privileged_source_port = "{{ item.require_privileged_source_port }}"
{% endif %}
   }
}
{% endfor %}
{%- endif %}
