{%- if oci_vcns is defined %}

{% for item in oci_vcns %}

resource "oci_core_vcn" "{{ item.name }}" {
    cidr_block = "{{ item.cidr_block }}"
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    display_name = "{{ item.name }}"

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.dns_label is defined %}
    dns_label = "{{ item.dns_label }}"
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

}
{% endfor %}
{%- endif %}
