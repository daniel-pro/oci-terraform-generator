{%- if oci_subnets is defined %}

{% for item in oci_subnets %}

resource "oci_core_subnet" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    vcn_id = oci_core_vcn.{{ item.vcn_name }}.id
    availability_domain = "{{ item.availability_domain }}"
    display_name = "{{ item.name }}"
    cidr_block = "{{ item.cidr_block }}"
    security_list_ids = [
{% for subnet_security_lists_item in item.subnet_security_lists %}
                         oci_core_security_list.{{ subnet_security_lists_item.name }}.id,
{% endfor %}
    ]

    dhcp_options_id = oci_core_dhcp_options.{{ item.dhcp_options_name }}.id
    dns_label = "{{ item.dns_label }}"
    prohibit_public_ip_on_vnic =  "{{ item.prohibit_public_ip_on_vnic }}"
    route_table_id = oci_core_route_table.{{ item.route_table_name }}.id
{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}
{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}
}
{% endfor %}
{%- endif %}
