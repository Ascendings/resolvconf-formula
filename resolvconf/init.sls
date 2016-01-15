{% from "resolvconf/map.jinja" import resolvconf_settings with context %}

resolv-file:
  file.managed:
    {% if resolvconf_settings.package_installed %}
    - name: /etc/resolv.conf:
    {% else %}
    - name: /etc/resolvconf/resolv.conf.d/base
    {% endif %}
    - source: salt://resolvconf/files/resolvconf.jinja
    - user: {{ resolvconf_settings.file_owner }}
    - group: {{ resolvconf_settings.file_group }}
    - mode: {{ resolvconf_settings.file_mode }}
    - template: jinja

{% if resolvconf_settings.package_manage %}
resolv-pkg:
  {% if resolvconf_settings.package_installed %}
  pkg.installed:
    - name: {{ resolvconf_settings.package_name }}
  {% else %}
  pkg.removed:
    - name: {{ resolvconf_settings.package_name }}
  {% endif %}
{% endif %}