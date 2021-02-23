{%- if oci_internet_gateways is defined %}

{% for item in oci_internet_gateways %}

resource "oci_core_internet_gateway" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    vcn_id = oci_core_vcn.{{ item.vcn_name }}.id
    display_name = "{{ item.name }}"

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

}
{% endfor %}
{%- endif %}
