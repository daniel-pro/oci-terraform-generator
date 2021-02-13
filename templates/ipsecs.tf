{%- if oci_ipsecs is defined %}

{% for item in oci_ipsecs %}

resource "oci_core_ipsec" "{{ item.name }}" {
    compartment_id = "oci_identity_compartment.{{ item.compartment_name }}.id"
{% if item.name is defined %}
    display_name = "{{ item.name }}"
{% endif %}
    cpe_id = "oci_core_cpe.{{ item.cpe_name }}.id"
    drg_id = "oci_core_drg.{{ item.drg_name }}.id" 
    static_routes = [
{% for item_ipsec_phase2_networks in item.ipsec_phase2_networks %}
                     "{{ item_ipsec_phase2_networks }}",
{% endfor %}
    ]

{% if item.cpe_local_identifier is defined %}
    cpe_local_identifier = { {{ item.cpe_local_identifier }} }
{% endif %}

{% if item.cpe_local_identifier_type is defined %}
    cpe_local_identifier_type = { {{ item.cpe_local_identifier_type }} }
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
