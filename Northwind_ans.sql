-- 1. We need a complete list of our suppliers to update our contact records. Can you pull all the information from the suppliers' table?
select* from suppliers;
select supplier_id,suppiler_name,contact_name,phone,email,address,tax_number
from supplier
WHERE active = 1
order by suppiler_name;
show tables;

-- 2. Our London sales team wants to run a local promotion. Could you get a list of all customers based in London?
select* from customers;
select customerId,customerNmae,contactname,city,postalcode
from customers
where city ='london'
order by customername asc;

-- 3. For our new 'Luxury Items' marketing campaign, I need to know our top 5 most expensive products.
select * from products;
select*from orderdetails;
select product_id,product_name,price
from products
where category = 'Luxury Items'
order by price desc
limit 5;

-- 4. HR is planning a professional development program for our younger employees. Can you provide a list of all employees born after 1965?
SELECT * FROM EMPLOYEES; 
SELECT employeeId, firstName , birthDate
from employees
where birthDate >='1966-01-01';

-- 5. A customer is asking about our 'Chef' products but can't remember the full name. Can you search for all products that have 'Chef' in their title?
select*from products;
SELECT product_id,title,price
FROM products
WHERE title LIKE '%Chef%';

-- 6. We need a report that shows every order and which customer placed it. Can you combine the order information with the customer's name?
select * from customers;
select * from orders;
select o.orderID,o.orderDate,c.CustomerID, c.CustomerName, c.contactName , address 
from orders o
inner join customers c 
on o.customerID = c.customerID 
order by o.orderID desc;
    
-- 7. To organize our inventory, please create a list that shows each product and the name of the category it belongs to.
select * from cateogries; 
select * from products;
select p.productName , p.categoryId , categoryName 
from products p 
join categories c 
on c.categoryID = p.categoryID;

-- 8. We want to promote products sourced from the USA. Can you list all products provided by suppliers located in the USA?
select * from products;
select * from suppliers;
select p.productName, s.country 
from products p 
join suppliers s 
on p.supplierID = s.supplierID 
where s.country= 'usa';

-- 9. A customer has a query about their order. We need to know which employee was responsible for it. Can you create a list of orders with the corresponding employee's first and last name?
select*from orders;
select*from employees;
select o.orderid,e.firstname,e.lastname
from orders o
join employees e
on e.employeeid=e.employeeid;

-- 10. To help with our international marketing strategy, I need a count of how many customers we have in each country, sorted from most to least.
select*from customers;
select country,
COUNT(customerID) AS total_customers
from customers
group by country
order by  total_customers DESC;

-- 11. Let's analyze our pricing. What is the average product price within each product category?
show tables;
select*from categories;
select*from products;
select categoryID,avg(price)as average_price
from products
group by categoryID;

-- 12. For our annual performance review, can you show the total number of orders handled by each employee?
select *from employees;
select * from orders;
select
    e.employee_id,
    e.first_name,
    e.last_name,
    count(o.order_id) as total_orders
from employees e
join orders o on e.employee_id = o.employee_id
group by e.employee_id,e.first_name,e.last_name
order by total_orders desc;

-- 13. We want to identify our key suppliers. Can you list the suppliers who provide us with more than three products?
select *from suppliers;
select *from products;

select s.supplierID, count(p.productID) as p_count
from suppliers s
join products p
on s.supplierID = p.supplierID
group by s.supplierID
having count(p.productID)>3
order by p_count desc;

-- 14. Finance team needs to know the total revenue for order 10250.
select * from orders;
select * from orderdetails;
select * from products;
select od.orderID, sum(od.quantity * p.price) as total_revenue
from orderdetails od
join products p
on od.productID = p.productID
where od.orderID = 10250
group by od.orderID;

-- 15. What are our most popular products? I need a list of the top 5 products based on the total quantity sold across all orders.
select *  from products;
select * from orderdetails;
select
    p.product_id,
    p.product_name,
    sum(od.quantity) as total_quantity_sold
from products p
join orderdetails od
on p.product_id = od.productID
group by  p.product_id, p.product_name
order by total_quantity_sold desc
limit 5;

-- 16. To negotiate our shipping contracts, we need to know which shipping company we use the most. Can you count the number of orders handled by each shipper?
show tables;
select * from shippers;
select * from orders;
select s.shipper_id,s.company_name,count(o.order_id) as total_orders
from shippers s
join orders o
on s.shipper_id = o.ship_via
group by  s.shipper_id, s.company_name
order by total_orders desc;


-- 17. Who are our top-performing salespeople in terms of revenue? Please calculate the total sales amount for each employee.

select* from employees;
select* from orderdetails;
select e.employee_id,e.first_name,e.last_name,
    sum(od.quantity * p.price) as total_sales
from employees e
join orders o
on e.employee_id = o.employee_id
join orderdetails od
on o.order_id = od.orderID
join products p
on od.productID = p.productID
group by e.employee_id, e.first_name, e.last_name
order by  total_sales desc;

-- 18. We are running a promotion on our 'Chais' tea. I need a list of all customers who have purchased this product before so we can send them a notification.
select * from customers;
select * from orders;
select * from products;
select * from orderdetails;
select distinct c.customer_id,c.customer_name,c.email
from customers c
join orders o
on c.customer_id = o.customer_id
join  orderdetails od
on o.order_id = od.orderID
join  products p
on od.productID = p.productID
where  p.product_name like '%Chais%';

-- 19. Which product categories are the most profitable? I need a report showing the total revenue generated by each category.
select *from categories;
select *from products;
select *from orderdetails;
select ct.categoryid, ct.categoryname,sum(od.quantity*p.price) as total_revenue 
from products p
join orderdetails od  on p.productid=od.productid 
join categories ct on ct.categoryid=p.categoryid
group by categoryname,categoryid 
order by total_revenue;

-- 20. We want to start a loyalty program for our most frequent customers. Can you find all customers who have placed more than 5 orders?
select * from customers;
select * from orders;
select c.customer_id, c.customer_name, count(o.order_id) as total_orders
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) > 5
order by total_orders desc;