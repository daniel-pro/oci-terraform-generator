{%- if oci_local_peering_gateways is defined %}

{% for item in oci_local_peering_gateways %}

resource "oci_core_local_peering_gateway" "{{ item.name }}" {
    compartment_id = "oci_identity_compartment.{{ item.compartment_name }}.id"
    vcn_id = "oci_core_vcn.{{ item.vcn_name }}.id"
    display_name = "{{ item.name }}"
{% if item.peer_name is defined %}
    peer_id = "oci_core_local_peering_gateway.{{ item.peer_name }}.id"
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
