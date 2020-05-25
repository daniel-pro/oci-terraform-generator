{%- if oci_load_balancers is defined %}

{% for item in oci_load_balancers %}

resource "oci_load_balancer" "{{ item.name }}" {
  shape          = "{{ item.shape }}"
  compartment_id = "${oci_identity_compartment.{{ item.compartment_name }}.id}"

  subnet_ids = [
{% for subnet in item.subnets %}
    "${oci_core_subnet.{{ subnet }}.id}",
{% enfor %}
  ]

  display_name = "{{ item.name }}"
}

resource "oci_load_balancer_backend_set" "{{ item.backend_set.name }}" {
  name             = "{{ item.backend_set.name }}"
  load_balancer_id = "${oci_load_balancer.{{ item.name }}.id}"
  policy           = "item.backend_set.policy"

  health_checker {
    port                = "item.backend_set_health.check_port"
    protocol            = "item.backend_set_health.protocol"
{% if item.backend_set.response_body_regex is defined %}
    response_body_regex = "{{ item.backend_set.response_body_regex }}""
{% endif %}

{% if item.backend_set.response_url_path is defined %}
    url_path            = "{{ item.backend_set.response_url_path }}"
{% endif %}

  }
}


{% if item.load_balancer_certificate is defined %}

resource "oci_load_balancer_certificate" "{{ item.load_balancer_certificate.name }}" {
  load_balancer_id   = "${oci_load_balancer.{{ item.name }}.id}"
  ca_certificate     = "{{ item.load_balancer_certificate.ca_certificate }}"
  certificate_name   = "{{ item.load_balancer_certificate.certificate_name }}"
  private_key        = "{{ item.load_balancer_certificate.private_key }}"
  public_certificate = "{{ item.load_balancer_certificate.public_certificate }}"

}

{% endif %}

{%- if item.load_balancer_path_route_sets is defined %}

{% for lbprs in item.load_balancer_path_route_sets %}
resource "oci_load_balancer_path_route_set" "lbprs.name" {
  load_balancer_id = "${oci_load_balancer.{{ item.name }}.id}"
  name             = "{{ lbprs.name }}"

  path_routes {
    backend_set_name = "${oci_load_balancer_backend_set.{{ lbprs.backend_set_name }}.name}"
    path             = "{{ lbprs.path }}"

    path_match_type {
      match_type = "{{ lbprs.match_type }}"
    }
  }
}
{% endfor %}
{% endif %}

{%- if item.oci_load_balancer_hostnames is defined %}
{% for hostname in item.oci_load_balancer_hostnames %}
resource "oci_load_balancer_hostname" "{{ hostname.name }}" {
  hostname         = "{{ hostname.hostname }}"
  load_balancer_id = "${oci_load_balancer.{{ item.name }}.id}"
  name             = "{{ hostname.name }}"
}
{% endfor %}
{% endif %}

{%- if item.oci_load_balancer_listeners is defined %}
{% for lbl in item.oci_load_balancer_listeners %}
resource "oci_load_balancer_listener" "{{ lbl.name }}" {
  load_balancer_id         = "${oci_load_balancer.{{ item.name }}.id}"
  name                     = "{{ lbl.name }}"
  default_backend_set_name = "${oci_load_balancer_backend_set.{{ lbl.load_balancer_backend_set_name }}".name}"
  hostname_names           = [
{% for hostname in lbl.load_balancer_hostnames %}
                              "${oci_load_balancer_hostname.{{ hostname }}}", 
{% endfor %}
                             ] 
  port                     = {{ lbl.port }}
  protocol                 = "{{ lbl.protocol }}"
{% if lbl.rule_set_names is defined %}
  rule_set_names           = [
{% for rule_set_name in lbl.rule_set_names %}
                              "${oci_load_balancer_rule_set.{{ rule_set_name }}.name}",
{% endfor %}
                             ]
{% endif %}

{% if lbl.connection_configuration is defined %}
  connection_configuration {
    idle_timeout_in_seconds = "{{ lbl.connection_configuration.idle_timeout_in_seconds }}"
  }
{% endif %}
}

