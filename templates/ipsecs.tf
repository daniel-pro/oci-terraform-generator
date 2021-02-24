{%- if oci_ipsecs is defined %}

{% for item in oci_ipsecs %}

resource "oci_core_ipsec" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
{% if item.name is defined %}
    display_name = "{{ item.name }}"
{% endif %}
    cpe_id = oci_core_cpe.{{ item.cpe_name }}.id
    drg_id = oci_core_drg.{{ item.drg_name }}.id 

    static_routes = [
{% for item_ipsec_phase2_networks in item.ipsec_phase2_networks %}
                     "{{ item_ipsec_phase2_networks }}",
{% endfor %}
    ]

{% if item.cpe_local_identifier is defined %}
    cpe_local_identifier = "{{ item.cpe_local_identifier }}"
{% endif %}

{% if item.cpe_local_identifier_type is defined %}
    cpe_local_identifier_type = "{{ item.cpe_local_identifier_type }}"
{% endif %}

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

}

data "oci_core_ipsec_connection_tunnels" "{{ item.name }}-tunnels" {
  ipsec_id = oci_core_ipsec.{{ item.name }}.id
}

resource "oci_core_ipsec_connection_tunnel_management" "{{ item.name }}-tunnel1-mgmt" {
    #Required
    ipsec_id = oci_core_ipsec.{{ item.name }}.id
    tunnel_id = data.oci_core_ipsec_connection_tunnels.{{ item.name }}-tunnels.ip_sec_connection_tunnels[0].id
    routing = "{{ item.routing }}"
    #Optional
{% if item.bgp_session_info is defined %}
    bgp_session_info {
        #Optional
        customer_bgp_asn = var.ip_sec_connection_tunnel_management_bgp_session_info_customer_bgp_asn
        customer_interface_ip = var.ip_sec_connection_tunnel_management_bgp_session_info_customer_interface_ip
        oracle_interface_ip = var.ip_sec_connection_tunnel_management_bgp_session_info_oracle_interface_ip
    }
{% endif %}
    display_name = "{{ item.name }}-tunnel1"

{% if item.encryption_domain_config is defined %}
    encryption_domain_config {
        #Optional
        cpe_traffic_selector = var.ip_sec_connection_tunnel_management_encryption_domain_config_cpe_traffic_selector
        oracle_traffic_selector = var.ip_sec_connection_tunnel_management_encryption_domain_config_oracle_traffic_selector
    }
{% endif %}

{% if item.shared_secret is defined %}
    shared_secret = "{{ item.shared_secret }}"
{% endif %}

{% if item.ike_version is defined %}
    ike_version = "{{ item.ike_version }}"
{% endif %}
}

resource "oci_core_ipsec_connection_tunnel_management" "{{ item.name }}-tunnel2-mgmt" {
    #Required
    ipsec_id = oci_core_ipsec.{{ item.name }}.id
    tunnel_id = data.oci_core_ipsec_connection_tunnels.{{ item.name }}-tunnels.ip_sec_connection_tunnels[1].id
    routing = "{{ item.routing }}"
    #Optional
{% if item.bgp_session_info is defined %}
    bgp_session_info {
        #Optional
        customer_bgp_asn = var.ip_sec_connection_tunnel_management_bgp_session_info_customer_bgp_asn
        customer_interface_ip = var.ip_sec_connection_tunnel_management_bgp_session_info_customer_interface_ip
        oracle_interface_ip = var.ip_sec_connection_tunnel_management_bgp_session_info_oracle_interface_ip
    }
{% endif %}
    display_name = "{{ item.name }}-tunnel2"

{% if item.encryption_domain_config is defined %}
    encryption_domain_config {
        #Optional
        cpe_traffic_selector = var.ip_sec_connection_tunnel_management_encryption_domain_config_cpe_traffic_selector
        oracle_traffic_selector = var.ip_sec_connection_tunnel_management_encryption_domain_config_oracle_traffic_selector
    }
{% endif %}

{% if item.shared_secret is defined %}
    shared_secret = "{{ item.shared_secret }}"
{% endif %}

{% if item.ike_version is defined %}
    ike_version = "{{ item.ike_version }}"
{% endif %}
}

{% endfor %}
{%- endif %}
