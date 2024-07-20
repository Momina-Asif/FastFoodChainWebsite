CREATE VIEW OrderView AS
SELECT orderinfo.OrderID,UserID, stat, orderstat, quantity, MenuID
FROM order1
JOIN orderinfo ON order1.OrderID = orderinfo.OrderID;

select * from OrderView;
-- ---------------------------------------------------
CREATE VIEW OrderMeuView AS
SELECT orderinfo.OrderID,UserID, stat, orderstat, quantity, MenuID, ItemName, descript, price
FROM order1
JOIN orderinfo ON order1.OrderID = orderinfo.OrderID
JOIN Menu on menuID = ItemID;
drop view OrderMeuView;
select * from OrderMeuView;
-- -------------------------------------------------------
CREATE VIEW OrderInfoMenuView AS
SELECT *
FROM orderinfo 
JOIN Menu on menuID = ItemID;

select * from OrderInfoMenuView;

-- --------------------------------------------------------

CREATE VIEW OrderCustomer AS
SELECT order1.UserID, OrderID, Username, Email, password1, PhoneNo
FROM order1 
JOIN CustomersInfo on order1.UserID = CustomersInfo.UserID;

CREATE VIEW OrderInfoCustomer AS
SELECT OrderCustomer.UserID, OrderCustomer.OrderID, Username, Email, password1, PhoneNo
FROM OrderCustomer 
JOIN OrderInfo on OrderCustomer.OrderID = orderinfo.OrderID


select * from OrderCustomer;