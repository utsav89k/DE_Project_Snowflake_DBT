{% macro multiply(x,y,precesion) %}
  round({{x}} * {{y}},{{precesion}})
{% endmacro %}

