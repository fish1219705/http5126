--  LAB 9 Views & Triggers
--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--  1 
-- A 
CREATE VIEW stock_items_under_twenty AS SELECT item,inventory,category FROM stock_items WHERE inventory < 20;
-- B 
SELECT * FROM stock_items_under_twenty;
-- C 
SELECT * FROM stock_items_under_twenty WHERE inventory = 0;

--  2 
-- A 
CREATE VIEW sales_total_by_employee AS SELECT CONCAT(first_name,' ',last_name) AS 'name' ,SUM(st.price) AS 'Total Sales ($)' FROM employees e LEFT JOIN sales sa ON e.id = sa.employee INNER JOIN stock_items st ON sa.item = st.id GROUP BY sa.employee ORDER BY SUM(st.price) DESC;
-- B 
SELECT * FROM sales_total_by_employee;
-- C 
SELECT * FROM sales_total_by_employee WHERE `Total Sales ($)` > 1000;

--  3 
-- A 
CREATE TRIGGER deduct_inventory AFTER INSERT ON sales FOR EACH ROW UPDATE stock_items SET inventory = inventory - 1 WHERE id = NEW.item;
-- B 
INSERT INTO sales (`date`,item,employee) VALUES (NOW(),1008,111);
-- C 
INSERT INTO sales (`date`,item,employee) VALUES (NOW(),1005,111);

--  4 
-- A 
CREATE TRIGGER insert_trg AFTER INSERT ON stock_items FOR EACH ROW INSERT INTO stock_items_log (action,item_id,old_item,old_price,old_inventory,old_category,`timestamp`) VALUES ("Insert", NEW.id, NEW.item, NEW.price, NEW.inventory, NEW.category,NOW());
-- B 
CREATE TRIGGER update_trg AFTER UPDATE ON stock_items FOR EACH ROW INSERT INTO stock_items_log (action,item_id,old_item,old_price,old_inventory,old_category,`timestamp`) VALUES ("Update", OLD.id, OLD.item, OLD.price, OLD.inventory, OLD.category,NOW());
-- C 
CREATE TRIGGER delete_trg AFTER DELETE ON stock_items FOR EACH ROW INSERT INTO stock_items_log (action,item_id,old_item,old_price,old_inventory,old_category,`timestamp`) VALUES ("Delete", OLD.id, OLD.item, OLD.price, OLD.inventory, OLD.category,NOW());

--  5
-- Run the queries in part A below before completing part 5B. 
-- Place your part 5 query below these queries where part B is indicated. 
-- Ensure these queries are included in your submission.
--
-- A
INSERT INTO stock_items (item, price, inventory, category) 
  VALUES ('Bad dog bed', '95', 2, 'Canine');
DELETE FROM stock_items 
  WHERE item = 'Bad dog bed';
INSERT INTO stock_items (item, price, inventory, category) 
  VALUES('Tiny size chew toy', 5, 5, 'Canine'),
  ('Huge water dish', 99, 18, 'Feline'),
  ('Fish bowl expert kit', 88, 11, 'Piscine'),
  ('Luxury cat collar', 150, 10, 'Feline');
UPDATE stock_items
  SET inventory = 0
  WHERE item = 'Luxury cat collar';
DELETE FROM stock_items
  WHERE inventory = 0;
UPDATE stock_items
  SET category = 'Cat'
  WHERE category = 'Feline';
INSERT INTO sales (`date`, item, employee)
  VALUES (NOW(), 1008, 114);
INSERT INTO sales (`date`, item, employee)
  VALUES (NOW(), 1005, 111);
-- B
SELECT * FROM stock_items_log WHERE item_id = 1025;
