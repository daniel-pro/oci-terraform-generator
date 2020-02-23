{%- if oci_route_tables is defined %}

{% for item in oci_route_tables %}

resource "oci_core_route_table" "{{ item.name }}" {
    compartment_id = "${oci_identity_compartment.{{ item.compartment_name }}.id}"
    display_name   = "{{ item.name }}"
    vcn_id         = "${oci_core_vcn.{{ item.vcn_name }}.id}"

    route_rules = [
{% for route_rules_item in item.route_rules %}
    {
        network_entity_id  = "${oci_core_{{ route_rules_item.network_entity_type }}.{{ route_rules_item.network_entity_name }}.id}",
        destination        = "{{ route_rules_item.destination }}"
        destination_type   = "{{ route_rules_item.destination_type }}"
    },
{% endfor %} 
    ]

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}
}
{% endfor %} 
{%- endif %} 
