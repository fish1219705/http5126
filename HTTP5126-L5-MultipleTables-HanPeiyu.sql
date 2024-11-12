--  LAB 5 MULTIPLE TABLES
--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--  1 
-- A 
SELECT * FROM sales WHERE item="1014";
-- B 
SELECT sales.date,stock_items.item FROM sales INNER JOIN stock_items ON sales.item = stock_items.id WHERE sales.item="1014";

--  2
-- A 
SELECT * FROM sales WHERE employee="111";
-- B
SELECT sales.date,employees.first_name,employees.last_name,sales.item FROM sales INNER JOIN employees ON sales.employee = employees.id WHERE employees.id="111";

--  3
-- A
SELECT sales.date,sales.item,employees.first_name FROM sales INNER JOIN employees ON sales.employee = employees.id WHERE sales.date BETWEEN "2024-09-12" AND "2024-09-18";
-- B
SELECT COUNT(sales.id),employees.first_name,employees.last_name FROM sales INNER JOIN employees ON sales.employee = employees.id GROUP BY employee ORDER BY COUNT(sales.id) DESC;

--  4
-- A
SELECT sa.date,st.item,st.price,st.category,e.first_name FROM sales sa LEFT JOIN stock_items st ON sa.item = st.id INNER JOIN employees e ON sa.employee = e.id WHERE e.first_name = "Farud";
-- B
SELECT COUNT(sales.id) AS "Times Sold",stock_items.id,stock_items.item,stock_items.price,stock_items.category FROM sales RIGHT JOIN stock_items ON sales.item = stock_items.id GROUP BY stock_items.id ORDER BY stock_items.id;

--  5
-- A : <Please provide the sales for Canine category on September 17th and the items' name and inventory. We would also want to know who sold them, the employees' names show as "employee name".>
-- B
SELECT sales.date,COUNT(sales.id), stock_items.item,stock_items.inventory,stock_items.category,CONCAT(employees.first_name,' ',employees.last_name)AS "employee name" FROM sales LEFT JOIN stock_items ON sales.item = stock_items.id INNER JOIN employees ON sales.employee = employees.id WHERE stock_items.category="Canine" AND sales.date="2024-09-17" GROUP BY sales.item;