{%- if oci_volume_groups is defined %}

{% for item in oci_volume_groups %}

resource "oci_core_volume_group" "{{ item.name }}" {
    availability_domain = "{{ item.availability_domain }}"
    compartment_id = "${oci_identity_compartment.{{ item.compartment_name }}.id}"
    display_name = "{{ item.name }}"
    source_details {
         type = "{{ item.type }}"
         volume_ids = [ 
{%- for instance_name in item.boot_volume_of_instances %}
                       "${data.oci_core_instance.{{ instance_name }}.boot_volume_id}",
{% endfor %}
{%- for volume_name in item.volumes %}
                       "${data.oci_core_volume.{{ volume_name }}.id}",
{% endfor %}
                      ]
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

