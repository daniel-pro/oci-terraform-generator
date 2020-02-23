{%- if oci_drgs is defined %}

{% for item in oci_drgs %}

resource "oci_core_drg" "{{ item.name }}" {
    compartment_id = "${oci_identity_compartment.{{ item.compartment_name }}.id}"
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

resource "oci_core_drg_attachment" "{{ item.name }}-{{ item.attach_to_vcn }}" {
    drg_id = "${oci_core_drg.{{ item.name }}.id}"
    vcn_id = "${oci_core_vcn.{{ item.attach_to_vcn }}.id}"
    display_name = "{{ item.attachment_name }}"
}

{% endfor %}
{%- endif %}
