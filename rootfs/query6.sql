select
        sum(l_extendedprice * l_discount) as revenue
from
        lineitem
where
        l_shipdate >= date('1997-01-01')
        and l_shipdate < date('1997-01-01', '+1 year')
        and l_discount between 0.07 and 0.09
        and l_quantity < 24;

