{%- if oci_network_security_groups is defined %}

{% for item in oci_network_security_groups %}
resource "oci_core_network_security_group" "{{ item.name }}" {
 
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    vcn_id = oci_core_vcn.{{ item.vcn_name }}.id

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}
{% if item.name is defined %}
    display_name = "{{ item.name }}"
{% endif %}
{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}
}

{%- if item.rules is defined %}
{% for rule in item.rules %}

resource "oci_core_network_security_group_security_rule" "{{ rule.name }}" {
    #Required
    network_security_group_id = oci_core_network_security_group.{{ item.name }}.id
    direction = "{{ rule.direction }}"
    protocol = "{{ rule.protocol }}"

    #Optional
{% if rule.description is defined %}
    description = "{{ rule.description }}"
{% endif %}
{% if rule.destination is defined %}
    destination = "{{ rule.destination }}"
{% endif %}
{% if rule.destination_type is defined %}
    destination_type = "{{ rule.destination_type }}"
{% endif %}

{% if rule.icmp_options is defined %}
    icmp_options {
        #Required
        type = "{{ rule.icmp_options.type }}"
{% if rule.icmp_options.code is defined %}
        code = "{{ rule.icmp_options.code }}"
{% endif %}
    }
{% endif %}

{% if rule.source is defined %}
    source = "{{ rule.source }}"
{% endif %}
{% if rule.source_type is defined %}
    source_type = "{{ rule.source_type }}"
{% endif %}
{% if rule.stateless is defined %}
    stateless = "{{ rule.stateless }}"
{% endif %}

{% if rule.tcp_options is defined %}
    tcp_options {

        
{% if rule.tcp_options.destination_port_range is defined %}
        destination_port_range {
            #Required
            max = "{{ rule.tcp_options.destination_port_range.max }}"
            min = "{{ rule.tcp_options.destination_port_range.min }}"
        }
{% endif %}
{% if rule.tcp_options.source_port_range is defined %}
        source_port_range {
            #Required
            max = "{{ rule.tcp_options.source_port_range.max }}"
            min = "{{ rule.tcp_options.source_port_range.min }}"
        }
{% endif %}
    }
{% endif %}

{% if rule.udp_options is defined %}
    udp_options {        
{% if rule.udp_options.destination_port_range is defined %}
        destination_port_range {
            #Required
            max = "{{ rule.udp_options.destination_port_range.max }}"
            min = "{{ rule.udp_options.destination_port_range.min }}"
        }
{% endif %}
{% if rule.tcp_options.source_port_range is defined %}
        source_port_range {
            #Required
            max = "{{ rule.udp_options.source_port_range.max }}"
            min = "{{ rule.udp_options.source_port_range.min }}"
        }
{% endif %}
    }
{% endif %}
}
{% endfor %}
{%- endif %}
{% endfor %}
{%- endif %}