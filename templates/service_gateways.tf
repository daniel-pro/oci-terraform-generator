{%- if oci_service_gateways is defined %}

{% for item in oci_service_gateways %}

resource "oci_core_service_gateway" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    vcn_id = oci_core_vcn.{{ item.vcn_name }}.id
    display_name = "{{ item.name }}"
    services = [
{%- if item.service_ids is defined %}
{% for service_ids_item in item.service_ids %}
       service_id = oci_objectstorage_object.{{ service_ids_item }}.id,
{% endfor %}
{%- endif %}
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
