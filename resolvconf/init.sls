{% from "resolvconf/map.jinja" import resolvconf_settings with context %}

{% if resolvconf_settings.package_installed %}
/etc/resolv.conf:
{% else %}
/etc/resolvconf/resolv.conf.d/base
{% endif %}
  file.managed:
    - source: salt://resolvconf/files/resolvconf.jinja
    - user: {{ resolvconf_settings.file_owner }}
    - group: {{ resolvconf_settings.file_group }}
    - mode: {{ resolvconf_settings.file_mode }}
    - template: jinja

{% if resolvconf_settings.package_manage %}
{{ package_name }}:
  {% if resolvconf_settings.package_installed %}
  pkg.installed: []
  {% else %}
  pkg.removed: []
  {% endif %}
{% endif %}