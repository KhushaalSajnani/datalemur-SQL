SELECT card_name, issued_amount FROM (
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY issue_year) as rn
  FROM monthly_cards_issued
) t
WHERE rn = 1
ORDER BY 2 DESC