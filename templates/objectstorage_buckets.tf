{%- if oci_objectstorage_buckets is defined %}

{% for item in oci_objectstorage_buckets %}

resource "oci_objectstorage_bucket" "{{ item.name }}" {
    compartment_id = oci_identity_compartment.{{ item.compartment_name }}.id
    name = "{{ item.name }}"
    namespace = "{{ item.namespace }}"
{% if item.access_type is defined %}
    access_type = "{{ item.access_type }}"
{% endif %}
{% if item.kms_key_name is defined %}
    kms_key_id = oci_kms_key.{{ item.kms_key_name }}.id
{% endif %}
{% if item.metadata is defined %}
    metadata = "{{ item.metadata }}"
{% endif %}
{% if item.storage_tier is defined %}
    storage_tier = "{{ item.storage_tier }}"
{% endif %}


{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

}
{% endfor %}
{%- endif %}
