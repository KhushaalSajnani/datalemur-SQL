SELECT p.topping_name || ',' || p2.topping_name || ',' || p3.topping_name as pizza, (p.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost) as total_cost FROM pizza_toppings p
CROSS JOIN pizza_toppings p2
CROSS JOIN pizza_toppings p3
WHERE p.topping_name < p2.topping_name AND p2.topping_name < p3.topping_name
ORDER BY 2 DESC, 1 ASC;