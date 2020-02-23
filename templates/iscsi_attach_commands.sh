{%- if oci_block_volume_attachments is defined %}
#!/bin/bash
{% for item in oci_block_volume_attachments %}
{%- if item.attachment_type == 'iscsi' %}
sudo iscsiadm -m node -o new -T ${oci_core_volume_attachment.{{ item.name }}.iqn} -p ${oci_core_volume_attachment.{{ item.name }}.ipv4}:${oci_core_volume_attachment.{{ item.name }}.port}
sudo iscsiadm -m node -o update -T ${oci_core_volume_attachment.{{ item.name }}.iqn} -n node.startup -v automatic 
sudo iscsiadm -m node -T ${oci_core_volume_attachment.{{ item.name }}.iqn} -p ${oci_core_volume_attachment.{{ item.name }}.ipv4}:${oci_core_volume_attachment.{{ item.name }}.port} -l"
# To detach use the following command :
# sudo iscsiadm -m node -T ${oci_core_volume_attachment.{{ item.name }}.iqn} -p ${oci_core_volume_attachment.{{ item.name }}.ipv4}:${oci_core_volume_attachment.{{ item.name }}.port -u
# sudo iscsiadm -m node -o delete -T ${oci_core_volume_attachment.{{ item.name }}.iqn} -p ${oci_core_volume_attachment.{{ item.name }}.ipv4}:${oci_core_volume_attachment.{{ item.name }}.port
{%- endif %}
{% endfor %}
{%- endif %}
