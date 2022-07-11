{%- if oci_drgs is defined %}

{% for item in oci_drgs %}

resource "oci_core_drg" "{{ item.name }}" {
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

{% for drg_attachment in item.drg_attachments %}
resource "oci_core_drg_attachment" "{{ item.name }}-{{ drg_attachment.attach_to_vcn }}" {
    #Required
    drg_id = oci_core_drg.{{ item.name }}.id

    #Optional
{% if drg_attachment.defined_tags is defined %}
    defined_tags = { {{ drg_attachment.defined_tags }} }
{% endif %}

    display_name = "{{ item.name }}-{{ drg_attachment.attach_to_vcn }}"

{% if drg_attachment.drg_route_table_id is defined %}
    drg_route_table_id = "{{ drg_attachment.drg_route_table_id }}"
{% endif %}
{% if drg_attachment.freeform_tags is defined %}
    freeform_tags = { {{ drg_attachment.freeform_tags }} }
{% endif %}


    network_details {
        #Required
        id = oci_core_vcn.{{ drg_attachment.attach_to_vcn }}.id
        type = "{{ drg_attachment.network_details.type }}"

        #Optional
{% if drg_attachment.network_details.route_table_name is defined %}
        route_table_id = oci_core_route_table.{{ route_table_name }}.id
{% endif %}
{% if drg_attachment.network_details.vcn_route_type is defined %}
        vcn_route_type ="{{ drg_attachment.network_details.vcn_route_type }}"
{% endif %}
    }

}
{% endfor %}

{% endfor %}
{%- endif %}
