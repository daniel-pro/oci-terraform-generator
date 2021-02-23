{%- if oci_block_volume_attachments is defined %}
{% for item in oci_block_volume_attachments %}

resource "oci_core_volume_attachment" "{{ item.name }}" {
    attachment_type = "{{ item.attachment_type }}"
    instance_id = oci_core_instance.{{ item.instance_name }}.id
    volume_id = oci_core_volume.{{ item.volume_name }}.id
    display_name = "{{ item.name }}"

{% if item.is_readonly is defined %}
    is_readonly = "{{ item.is_readonly }}"
{% endif %}

{% if item.is_shareable is defined %}
    is_shareable = "{{ item.is_shareable }}"
{% endif %}

{% if item.use_chap is defined %}
    use_chap = "{{ item.use_chap }}"
{% endif %}
{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

{% if item.attachment_type == 'iscsi' %}
connection {
   host = oci_core_instance.{{ item.instance_name }}.create_vnic_details.0.private_ip
   user = "opc"
   private_key = "file("{{ remote_exec_ssh_pkey_file }}")"
}

provisioner "remote-exec" {
  inline = [
            "/bin/sudo /sbin/iscsiadm -m node -o new -T oci_core_volume_attachment.{{ item.name }}.iqn -p oci_core_volume_attachment.{{ item.name }}.ipv4:oci_core_volume_attachment.{{ item.name }}.port",
            "/bin/sudo /sbin/iscsiadm -m node -o update -T oci_core_volume_attachment.{{ item.name }}.iqn} -n node.startup -v automatic",
            "/bin/sudo /sbin/iscsiadm -m node -T oci_core_volume_attachment.{{ item.name }}.iqn -p oci_core_volume_attachment.{{ item.name }}.ipv4:oci_core_volume_attachment.{{ item.name }}.port -l"
  ]
}
{% endif %}

}

{% endfor %}
{%- endif %}
