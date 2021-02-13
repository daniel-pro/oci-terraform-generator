{%- if oci_security_lists is defined %}

{% for item in oci_security_lists %}

resource "oci_core_security_list" "{{ item.name }}" {
    compartment_id = "oci_identity_compartment.{{ item.compartment_name }}.id"
    display_name   = "{{ item.name }}"
    vcn_id         = "oci_core_vcn.{{ item.vcn_name }}.id"

{% for egress_item in item.egress_rules %}
    egress_security_rules {
        destination = "{{ egress_item.destination }}"
        protocol    = "{{ egress_item.protocol }}"
    }
{% endfor %} 

{% for ingress_item in item.ingress_rules %}
    ingress_security_rules {
        source   = "{{ ingress_item.source }}"
        protocol = "{{ ingress_item.protocol }}"

{% if ingress_item.max_tcp_port is defined %}
        tcp_options {
            max = "{{ ingress_item.max_tcp_port }}"
            min = "{{ ingress_item.min_tcp_port }}"
        }
{% endif %}

{% if ingress_item.max_udp_port is defined %}
        udp_options {
            max = "{{ ingress_item.max_udp_port }}"
            min = "{{ ingress_item.min_udp_port }}"
        }
{% endif %}
    }     
{% endfor %}

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}
}
{% endfor %} 
{%- endif %} 
