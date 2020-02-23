{%- if oci_objectstorage_objects is defined %}

{% for item in oci_objectstorage_objects %}

resource "oci_objectstorage_object" "{{ item.name }}" {
    bucket = "{{ item.object_bucket }}"
    object = "{{ item.object }}"
    namespace = "{{ item.namespace }}"
    source = "{{ item.source_filename }}"

{% if item.defined_tags is defined %}
    defined_tags = { {{ item.defined_tags }} }
{% endif %}

{% if item.freeform_tags is defined %}
    freeform_tags = { {{ item.freeform_tags }} }
{% endif %}

}
{% endfor %}
{%- endif %}
