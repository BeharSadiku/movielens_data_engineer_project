{% test accepted_rating_range(model, column_name, min_value=0, max_value=5) %}

select *
from {{ model }}
where {{ column_name }} < {{ min_value }}
   or {{ column_name }} > {{ max_value }}

{% endtest %}
