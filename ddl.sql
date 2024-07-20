
select * from menu
INSERT INTO menu (itemId, itemName, descript, price) VALUES ('7', 'Hibiscus Ginger Cooler', 'This cooling beverage combines the floral notes of hibiscus with the spicy kick of ginger, creating a invigorating drink.', 5);

INSERT INTO menu (itemId, itemName, descript, price) VALUES ('8', 'Coconut Lavender Lemonade', 'This exotic twist on traditional lemonade features the tropical flavors of coconut and the floral aroma of lavender.', 5);

INSERT INTO menu (itemId, itemName, descript, price) VALUES ('9', 'Turmeric Golden Milk Latte', 'This soothing beverage, also known as "haldi doodh" in South Asian cultures, combines the earthy flavor of turmeric with the warmth of spices and creamy milk.', 5);
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
ALTER TABLE menu MODIFY COLUMN descript VARCHAR(200);
CREATE TABLE CustomersInfo (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    password1 VARCHAR(20) NOT NULL,
    PhoneNo CHAR(11) CHECK (PhoneNo <= '9' AND PhoneNo >= '0')
);



drop table CustomersInfo
select * from CustomersInfo

CREATE TABLE DeliveryInfo1(
    DeliveryID INT PRIMARY KEY,
    OrderID INT,
    CourierID INT,
    FOREIGN KEY (OrderID) REFERENCES OrderInfo(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CourierID) REFERENCES CouriersInfo1(CourierID) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO CustomersInfo (Username, Email, password1, PhoneNo)
VALUES
(6, 'john_doe', 'john@gmail.com', 'password123', '12345678910'),
(2, 'jane_smith', 'jane@gmail.com', 'securepass', '01234567891'),
(3, 'mike_wilson', 'mike@gmail.com', 'mikepass', '23456789100'),
(4, 'amy_jackson', 'amy@gmail.com', 'amypass', '78912345600'),
(5, 'david_anderson', 'david@gmail.com', 'davidpass', '34560078912');

CREATE TABLE PromoCodes (
    PromoCodeID INT PRIMARY KEY AUTO_INCREMENT,
    PromoCode VARCHAR(20) NOT NULL UNIQUE,
    Description VARCHAR(255),
    Discount int NOT NULL
);
drop table PromoCodes
select * from PromoCodes

INSERT INTO PromoCodes (PromoCode, Description, Discount) VALUES 
('GET20', '20% off your order. Applicable to orders above 50$', 20),
('NEWUSER10', 'New user discount. Applicable to orders above 40$', 10);


CREATE TABLE Order1 (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    stat varchar(20),
    FOREIGN KEY (UserID) REFERENCES CustomersInfo(UserID)
);
drop table Order1;
select * from Order1;
select * from OrderInfo;

CREATE TABLE LocationsInfo1(
    LocationID INT PRIMARY KEY auto_increment,
    address1 VARCHAR(50)
);
drop table OrderInfo;
CREATE TABLE OrderInfo (
    OrderID INT,
    MenuID INT, 
    quantity INT,
    orderstat varchar(20),
    Primary key(OrderID, MenuID, orderstat),
    FOREIGN KEY (OrderID) REFERENCES Order1(OrderID),
    FOREIGN KEY (MenuID) REFERENCES menu(ItemId)
);

CREATE TABLE Stock (
	MenuID INT,
    Quantity INT,
    PRIMARY KEY(MenuID, Quantity),
    FOREIGN KEY (MenuID) REFERENCES Menu(ItemID)
);


select * from LocationsInfo2
drop table stock
select * from Stock;

INSERT INTO Stock (MenuID, Quantity) VALUES 
(1, 100), 
(2, 100),
(3, 100),
(4, 100),
(5, 100),
(6, 100),
(7, 100),
(8, 100),
(9, 100);

drop table CouriersInfo1;

CREATE TABLE CouriersInfo1(
    CourierID INT PRIMARY KEY AUTO_INCREMENT,
    VehicleID INT NOT NULL 
);

select * from LocationsInfo1


