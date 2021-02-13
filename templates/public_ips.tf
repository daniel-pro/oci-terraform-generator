{%- if oci_public_ips is defined %}
{% for item in oci_public_ips %}
resource "oci_core_public_ip" "{{ item.name }}" {
  compartment_id = "oci_identity_compartment.{{ item.compartment_name }}.id"
  display_name   = "{{ item.name }}"
  lifetime       = "{{ item.lifetime }}"

{% if item.instance_name is defined %}
  private_ip_id  = data.oci_core_private_ips.{{ item.instance_name }}Ips.private_ips[0]["id"]
{% endif %}


{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}
{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}
}

{% endfor %}

{% for item in oci_public_ips %}
{% if item.instance_name is defined %}
data "oci_core_private_ips" "{{ item.instance_name }}Ips" {
  ip_address = oci_core_instance.{{ item.instance_name }}.private_ip
  subnet_id  = oci_core_subnet.{{ item.subnet_name }}.id
}
{% endif %}
{% endfor %}
{%- endif %}
