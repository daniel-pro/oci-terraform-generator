{%- if oci_cpes is defined %}

{% for item in oci_cpes %}

resource "oci_core_cpe" "{{ item.name }}" {
    compartment_id = "oci_identity_compartment.{{ item.compartment_name }}.id"
    ip_address = "{{ item.ip_address }}"
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
