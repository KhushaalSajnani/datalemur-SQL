SELECT item_count FROM (SELECT *, 
RANK() OVER(ORDER BY order_occurrences DESC)
FROM items_per_order
ORDER BY order_occurrences DESC ) t
WHERE rank = 1