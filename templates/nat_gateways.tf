{%- if oci_nat_gateways is defined %}

{% for item in oci_nat_gateways %}

resource "oci_core_nat_gateway" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    vcn_id = oci_core_vcn.{{ item.vcn_name }}.id
    display_name = "{{ item.name }}"
{% if item.defined_tags is defined %}
    block_traffic = { {{ item.block_traffic }} }
{% endif %}
{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}
{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}
}
{% endfor %}
{%- endif %}
