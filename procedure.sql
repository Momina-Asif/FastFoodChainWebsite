

drop PROCEDURE AddItemToOrder1
DELIMITER //
CREATE PROCEDURE AddItemToOrder1 (
    IN p_email VARCHAR(50),
    IN p_menu_id INT
)
BEGIN
    DECLARE v_user_id INT;
    DECLARE v_order_id INT;

    -- Get the UserID corresponding to the provided username
    SELECT UserID INTO v_user_id
    FROM CustomersInfo
    WHERE Email = p_email;

    -- Check if the user exists
    IF v_user_id IS NOT NULL THEN
        -- Check if the user has an open order
        SELECT OrderID INTO v_order_id
        FROM Order1
        WHERE UserID = v_user_id and stat != 'Order Placed';

        -- If user doesn't have an open order, create a new order
        IF v_order_id IS NULL THEN
            INSERT INTO Order1 (UserID, stat)
            VALUES (v_user_id, 'Pending');
            SET v_order_id = LAST_INSERT_ID();
        END IF;

        -- Add the item to the user's order
        INSERT INTO OrderInfo (OrderID, MenuID, orderstat)
        VALUES (v_order_id, p_menu_id, 'Show');

        SELECT 'Item added to order successfully' AS Message;
    ELSE
        SELECT 'User not found' AS Message;
    END IF;
END //


DELIMITER //

SELECT OrderInfo.MenuID, ItemName, 
       COUNT(*) AS TotalCount,
       SUM(Price) AS TotalPrice
FROM OrderInfo join Menu on OrderInfo.MenuID = Menu.ItemID
GROUP BY OrderInfo.MenuID, ItemName;


drop procedure UpdateItemStatus
DELIMITER //




DELIMITER //
CREATE PROCEDURE GetUserOrders(IN p_email VARCHAR(50))
BEGIN
    DECLARE v_user_id INT;

    -- Get the UserID corresponding to the provided username
    SELECT UserID INTO v_user_id
    FROM CustomersInfo
    WHERE Email = p_email;
    
    -- Check if the user exists
    IF v_user_id IS NOT NULL THEN
        -- Get all menu items ordered by the user with total count and price
        SELECT OrderInfo.MenuID, ItemName, stat, price,
       COUNT(*) AS TotalCount,
       SUM(Price) AS TotalPrice
FROM OrderInfo join Menu on OrderInfo.MenuID = Menu.ItemID join order1 on order1.OrderID = OrderInfo.OrderID
where OrderInfo.orderstat = 'Show'
GROUP BY OrderInfo.MenuID, ItemName, stat;

   
        
    ELSE
        SELECT 'User not found' AS Message;
    END IF;
END //
DELIMITER


CREATE TABLE LocationsInfo2(
    LocationID INT PRIMARY KEY auto_increment,
    address1 VARCHAR(50)
);