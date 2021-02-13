{%- if oci_dhcp_options is defined %}

{% for item in oci_dhcp_options %}

resource "oci_core_dhcp_options" "{{ item.name }}" {
    compartment_id = "oci_identity_compartment.{{ item.compartment_name }}.id"
    vcn_id = "oci_core_vcn.{{ item.vcn_name }}.id"
    display_name = "{{ item.name }}"
    options {
               type = "DomainNameServer"
               server_type = "{{ item.option_DomainNameServer_servertype }}"
{% if item.option_DomainNameServer_custom_dns_servers  is defined %}
               custom_dns_servers = [ {{ item.option_DomainNameServer_custom_dns_servers }} ]
{% endif %}
    }
    options {
               type = "SearchDomain"
               search_domain_names  = [ "{{ item.option_SearchDomain_search_domain_names }}" ]
    }
{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

}
{% endfor %}
{%- endif %}
