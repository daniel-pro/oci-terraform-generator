{%- if oci_ipsecs is defined %}

{% for item in oci_ipsecs %}

resource "oci_core_ipsec" "{{ item.name }}" {
    compartment_id = "${oci_identity_compartment.{{ item.compartment_name }}.id}"
    display_name = "{{ item.name }}"
    cpe_id = "${oci_core_cpe.{{ item.cpe_name }}.id}"
    drg_id = "${oci_core_drg.{{ item.drg_name }}.id}" 
    static_routes = [
{% for item_ipsec_phase2_networks in item.ipsec_phase2_networks %}
                     "{{ item_ipsec_phase2_networks }}",
{% endfor %}
    ]
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
