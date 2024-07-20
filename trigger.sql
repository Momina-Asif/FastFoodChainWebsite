drop trigger check_email_duplicate

DELIMITER //

CREATE TRIGGER check_email_duplicate BEFORE INSERT ON CustomersInfo
FOR EACH ROW
BEGIN
    DECLARE email_count INT;

    SELECT COUNT(*) INTO email_count
    FROM CustomersInfo
    WHERE Email = NEW.Email;

    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists';
    END IF;
END//

DELIMITER ;
-- --------------------------------------------------------------------------
DELIMITER //

CREATE TRIGGER check_password_length
BEFORE INSERT ON CustomersInfo
FOR EACH ROW
BEGIN
    DECLARE password_length INT;

    SET password_length = CHAR_LENGTH(NEW.password1);

    IF password_length < 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password is too short. It must be at least 8 characters long';
    END IF;
END//

DELIMITER ;

-- --------------------------------------------------------------------------
drop trigger UpdateItemTrigger
DELIMITER //
CREATE TRIGGER UpdateItemTrigger AFTER UPDATE ON OrderInfo
FOR EACH ROW
BEGIN
    -- Check if the item's status changed to 'Hide'
    IF NEW.stat = 'Order Placed' THEN
        -- Subtract the quantity from the stock table
        UPDATE Stock
        SET Quantity = Quantity - NEW.quantity
        WHERE MenuID = NEW.MenuID and  Quantity - NEW.quantity >= 0;
    END IF;
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
drop trigger check_phone_no
DELIMITER //

CREATE TRIGGER check_phone_no
BEFORE INSERT ON CustomersInfo
FOR EACH ROW
BEGIN
    DECLARE phone_length INT;

    SET phone_length = CHAR_LENGTH(NEW.PhoneNo);

    IF phone_length != 11 THEN
        SIGNAL SQLSTATE '45000'
    END IF;
END//

DELIMITER ;

-- -----------------------------------------------------
drop trigger UpdateItemTrigger

DELIMITER //
CREATE TRIGGER UpdateItemTrigger AFTER UPDATE ON Order1
FOR EACH ROW
BEGIN
    -- Check if the stat column is updated to 'Order Placed'
    IF NEW.stat = 'Order Placed' AND OLD.stat != 'Order Placed' THEN
        -- Subtract the quantity from the stock table based on the orders
        UPDATE Stock
        INNER JOIN OrderInfo ON Stock.MenuID = OrderInfo.MenuID
        SET Stock.Quantity = Stock.Quantity - OrderInfo.quantity
        WHERE OrderInfo.OrderID = NEW.OrderID;
    END IF;
END //
DELIMITER;

--  -----------------------------------------------------

DELIMITER //

CREATE TRIGGER PreventOutOfStock
BEFORE INSERT ON OrderInfo
FOR EACH ROW
BEGIN
    DECLARE currentStock INT;

    -- Get the current stock quantity for the MenuID being inserted
    SELECT Quantity INTO currentStock
    FROM Stock
    WHERE MenuID = NEW.MenuID;

    -- Check if the requested quantity exceeds the available stock
    IF NEW.quantity > currentStock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Item is out of stock. Cannot add to cart.';
    END IF;
END //

DELIMITER ;
 
 --