// Знайти вузли з найбільшою кількістю зв'язків

MATCH (n)-[r]-()
WITH n, count(r) AS degree
RETURN
labels(n) AS nodeType,
coalesce(n.title, n.name, toString(n.userId)) AS node,
degree
ORDER BY degree DESC
LIMIT 20;