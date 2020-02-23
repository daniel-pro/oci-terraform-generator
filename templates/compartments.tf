{%- if oci_compartments is defined %}

{% for item in oci_compartments %}
resource "oci_identity_compartment" "{{ item.name }}" {
    compartment_id = "{{ oci_root_compartment_id }}"
    description = "{{ item.description }}"
    name = "{{ item.name }}"

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}
{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags}} }
{% endif %}
}
{% endfor %}
{%- endif %}
