CREATE DATABASE GameKnight;

USE GameKnight;

CREATE TABLE Game (
    GameID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
	YearPublished SMALLINT,
    Publisher VARCHAR(30),
    Country VARCHAR(20),
    QuantityOnHand SMALLINT
);

INSERT INTO Game
(Name, YearPublished, Publisher, Country, QuantityOnHand)
VALUES
('Chess', 1475, 'Public Domain', 'India', 12),
('The Crew: The Quest for Planet 9', 2019, 'Kosmos', 'Germany', 17),
('The Crew: Mission Deep Sea', 2021, 'Kosmos', 'Germany', 15),
('Canvas', 2021, 'Road to Infamy', 'USA', 6),
('Wingspan', 2019, 'Stonemeier Games', 'USA', 2),
('Forbidden Island', 2010, 'Gamewright', 'USA', 4),
('Wavelength', 2019, 'Palm Court', Null, 0),
('Mysterium Park', 2020, 'Libellud', 'France', 14),
('Nacho Stack!', 2022, 'Professor Puzzle Games', 'UK', 25),
('Checkers', 1150, 'Public Domain', Null, 15),
('Love Letter', 2019, 'Z-man Games', 'USA', 30),
('7 Wonders', 2010, 'Repos Production', 'Belgium', 2),
('Yu-Gi-Oh! 2 Player Starter Set', '2024', 'Konami', 'Japan', 14), 
('Blazing Dominion', '2026', 'Konami', 'Japan', 0), 
('Secrets of Strixhaven Collector Booster Box', '2026', 'Wizards of the Coast', 'USA', 3),
('Secrets of Strixhaven Draft Night', 2026, 'Wizards of the Coast', 'USA', 5), 
('Secrets of Strixhaven Play Boosters', 2026, 'Wizards of the Coast', 'USA', 10), 
('Lorwyn Eclipsed Commander Deck Blight Curse', '2026', 'Wizards of the Coast', 'USA', 4), 
('Lorwyn Eclipsed Collector Booster', '2026', 'Wizards of the Coast', 'USA', 8), 
('Lorwyn Eclipsed Theme Deck - Pirates', '2026', 'Wizards of the Coast', 'USA', 5), 
('Lorwyn Eclipsed Theme Deck - Angels', 2026, 'Wizards of the Coast', 'USA', 6), 
('Marvel Spider-Man Play Boosters', 2024, 'Wizards of the Coast', 'USA', 2),
('High Rollers Club Pin', '2024', 'Game Knight', 'USA', 48),
('Game Knight Tote', '2023', 'Game Knight', 'USA', 31),
('Game Knight Mug', 2026, 'Game Knight', 'USA', 10),
('Rider-Waite Tarot Deck', '1909', 'Public Domain', 'UK', 4),
('Game Knight Dragon Mug', 2026, 'Game Knight', 'USA', 9),
('Game Knight and Princess Tee S', 2026, 'Game Knight', 'USA', 5),
('Game Knight and Princess Tee M',  2026, 'Game Knight', 'USA', 4),
('Game Knight and Princess Tee L',  2026, 'Game Knight', 'USA', 6),
('Game Knight and Princess Tee XL', 2026, 'Game Knight', 'USA', 7),
('Game Knight and Princess Tee XXL', 2026, 'Game Knight', 'USA', 4);

CREATE TABLE BoardGame(
GameID INT Primary Key,
FOREIGN KEY (GameID) REFERENCES Game(GameID),
Competitive BOOLEAN,
NumberOfPlayers VARCHAR(6)
);

INSERT INTO BoardGame
(GameID, Competitive, NumberOfPlayers)
VALUES
(1, TRUE, '2'),
(2, FALSE, '2-5'),
(3, FALSE, '2-5'),
(4, TRUE, '1-5'),
(5, TRUE, '1-5'),
(6, FALSE, '2-4'),
(7, FALSE, '2-12'),
(8, FALSE, '2-6'),
(9, TRUE, '2-6'),
(10, TRUE, '2'),
(11, TRUE, '2-6'),
(12, TRUE, '2-7');

CREATE TABLE TradingCardGame(
GameID INT Primary Key,
FOREIGN KEY (GameID) REFERENCES Game(GameID),
Generation TINYINT,
PackSize SMALLINT
);

INSERT INTO TradingCardGame
(GameID, Generation, PackSize)
VALUES
(13, 1, 88),
(14, 1, 9),
(15, 2, 180),
(16, 2, 168),
(17, 4, 14),
(18, 1, 100),
(19, 1, 15),
(20, 2, 60),
(21, 2, 60),
(22, 4, 14);


CREATE TABLE Merch(
GameID INT Primary Key,
FOREIGN KEY (GameID) REFERENCES Game(GameID),
Type VARCHAR(20),
Description VARCHAR(80)
);

INSERT INTO Merch
(GameID, Type, Description)
VALUES
(23, 'Accessory', 'Enamel High Roller pin'),
(24, 'Accessory', 'Canvas Game Knight tote bag'),
(25, 'Kitchen', 'Ceramic Game Knight coffee mug'),
(26, 'Playable', 'Rider-Waite Tarot Deck (78 cards)'),
(27, 'Kitchen', 'Ceramic Dragon mug'),
(28, 'Apparel', 'Knight and Princess Tee Size Small'),
(29, 'Apparel', 'Knight and Princess Tee Size Medium'),
(30, 'Apparel', 'Knight and Princess Tee Size Large'),
(31, 'Apparel', 'Knight and Princess Tee Size X-Large'),
(32, 'Apparel', 'Knight and Princess Tee Size XX-Large');

CREATE TABLE Customer (
	CustomerID INT PRIMARY KEY UNIQUE AUTO_INCREMENT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PaymentMethod ENUM('visa', 'master_card', 'american_express', 'discover', 'check', 'cash'),
    StreetAddress VARCHAR(50),
    City VARCHAR(25),
    State CHAR(2),
    CONSTRAINT chk_state CHECK (State REGEXP '^[A-Z]{2}$'),
    Country CHAR(3),
    CONSTRAINT chk_country CHECK (Country REGEXP '^[A-Z]{3}'),
    PostalCode INT(5)
    CONSTRAINT chk_postalcode CHECK (PostalCode REGEXP '^[0-9]{5}')

);


CREATE TABLE Order_ (
	CustomerID INT NOT NULL,
	GameID SMALLINT NOT NULL,
    OrderDate DATE NOT NULL,
    Quantity INT(50),
    Price DECIMAL(13, 2),
    OrderStatus ENUM('ordered', 'received', 'shipped', 'complete', 'canceled', 'return_pending', 
		'returned'),
	OrderID SMALLINT,
    PRIMARY KEY (CustomerID, GameID, OrderDate)
);



CREATE TABLE Review (
	CustomerID INT NOT NULL,
	GameID SMALLINT NOT NULL,
    ReviewDate DATE NOT NULL,
    Rating FLOAT,
    ReviewText VARCHAR(500),
    ReviewStatus ENUM('submitted', 'verified', 'posted'),
    PRIMARY KEY (CustomerID, GameID, ReviewDate)
);



INSERT INTO Customer (
		CustomerID, FirstName, LastName, PaymentMethod, StreetAddress, City, State, Country, PostalCode)
	VALUES

		(21, 'John', 'Connor', 'visa', '19828 Valerio Street', 'Winnetka', 'CA', 'USA', 91306),
		(22, 'Sarah', 'Connor', 'cash', '14239 Gilmore Street', 'Van Nuys', 'CA', 'USA', 91401),
		(23, 'Kyle', 'Reese', 'master_card', '432 Broadway', 'Los Angeles', 'CA', 'USA', 90013),
		(24, 'Ellen', 'Ripley', 'american_express', '1000 Commercial Ave', 'Houston', 'TX', 'USA', 77002),
		(25, 'Marty', 'McFly', 'discover', '9303 Lyon Drive', 'Hill Valley', 'CA', 'USA', 95420),
		(26, 'Emmett', 'Brown', 'visa', '1640 Riverside Drive', 'Hill Valley', 'CA', 'USA', 95420),
		(27, 'Dana', 'Barrett', 'master_card', '55 Central Park West', 'New York', 'NY', 'USA', 10023),
		(28, 'Peter', 'Venkman', 'cash', '14 North Moore Street', 'New York', 'NY', 'USA', 10013),
		(29, 'Thomas', 'Anderson', 'visa', '2240 North Dayton Street', 'Chicago', 'IL', 'USA', 60614),
		(30, 'Trinity', 'Moss', 'american_express', '500 W Madison St', 'Chicago', 'IL', 'USA', 60661);

        

INSERT INTO Order_ (
    CustomerID, GameID, OrderDate, Quantity, Price, OrderStatus, OrderID
) VALUES

    (22, 2, '2026-05-01', 1, 13.99, 'complete', 1001),
    (25, 5, '2026-05-05', 2, 69.95, 'shipped', 1002),
    (30, 7, '2026-05-10', 1, 39.95, 'canceled', 1003),
    (29, 16, '2026-05-12', 3, 149.97, 'returned', 1004),
    (28, 19, '2026-05-15', 5, 5.99, 'complete', 1005),
    (28, 28, '2026-05-18', 1, 29.99, 'ordered', 1006),
    (24, 15, '2026-05-20', 1, 749.95, 'received', 1007),
    (23, 29, '2026-05-22', 1, 29.99, 'return_pending', 1008),
    (21, 5, '2026-05-25', 1, 69.95, 'shipped', 1009),
    (27, 12, '2026-05-28', 1, 59.99, 'ordered', 1010),
	(21, 1, '2026-01-05', 1, 15.00, 'complete', 1011),
    (22, 4, '2026-01-10', 1, 35.50, 'shipped', 1012),
    (23, 10, '2026-01-12', 2, 20.00, 'complete', 1013),
    (24, 11, '2026-01-15', 1, 11.99, 'complete', 1014),
    (25, 14, '2026-02-01', 1, 45.00, 'canceled', 1015),
    (26, 18, '2026-02-05', 1, 40.00, 'complete', 1016),
    (27, 23, '2026-02-14', 3, 29.97, 'shipped', 1017),
    (28, 24, '2026-02-20', 1, 15.99, 'ordered', 1018),
    (29, 25, '2026-02-25', 2, 24.00, 'received', 1019),
    (30, 26, '2026-03-01', 1, 22.50, 'return_pending', 1020),
    (21, 2, '2026-03-05', 1, 13.99, 'complete', 1021),
    (22, 6, '2026-03-10', 1, 19.99, 'shipped', 1022),
    (23, 8, '2026-03-15', 1, 44.99, 'ordered', 1023),
    (24, 13, '2026-03-20', 2, 19.98, 'canceled', 1024),
    (25, 20, '2026-04-01', 1, 14.99, 'complete', 1025),
    (26, 21, '2026-04-05', 1, 14.99, 'returned', 1026),
    (27, 30, '2026-04-10', 2, 59.98, 'shipped', 1027),
    (28, 31, '2026-04-15', 1, 29.99, 'received', 1028),
    (29, 32, '2026-04-20', 1, 29.99, 'complete', 1029),
    (30, 1, '2026-04-25', 1, 15.00, 'ordered', 1030),
    (21, 3, '2026-05-02', 1, 14.99, 'complete', 1031),
    (22, 12, '2026-05-04', 1, 59.99, 'shipped', 1032),
    (23, 17, '2026-05-06', 4, 15.96, 'complete', 1033),
    (24, 22, '2026-05-08', 2, 9.98, 'canceled', 1034),
    (25, 27, '2026-05-11', 1, 18.50, 'returned', 1035),
    (26, 9, '2026-05-14', 1, 12.99, 'complete', 1036),
    (27, 4, '2026-05-16', 1, 35.50, 'ordered', 1037),
    (28, 15, '2026-05-19', 1, 249.99, 'received', 1038),
    (29, 10, '2026-05-21', 1, 10.00, 'return_pending', 1039),
    (30, 8, '2026-05-24', 1, 44.99, 'shipped', 1040),
	-- Order 1041: Customer 21 buys 3 games on the same day
    (21, 1, '2026-06-01', 1, 15.00, 'complete', 1041),
    (21, 2, '2026-06-01', 1, 13.99, 'complete', 1041),
    (21, 3, '2026-06-01', 1, 14.99, 'complete', 1041),
    -- Order 1042: Customer 25 buys 4 games on the same day
    (25, 13, '2026-06-02', 1, 9.99, 'shipped', 1042),
    (25, 14, '2026-06-02', 1, 45.00, 'shipped', 1042),
    (25, 15, '2026-06-02', 2, 24.99, 'shipped', 1042),
    (25, 16, '2026-06-02', 1, 15.00, 'shipped', 1042),
    -- Order 1043: Customer 28 buys 2 t-shirts on the same day
    (28, 28, '2026-06-03', 1, 29.99, 'ordered', 1043),
    (28, 29, '2026-06-03', 1, 29.99, 'ordered', 1043),
    -- Order 1044: Customer 30 buys 3 games on the same day
    (30, 4, '2026-06-04', 1, 35.50, 'received', 1044),
    (30, 5, '2026-06-04', 1, 69.95, 'received', 1044),
    (30, 6, '2026-06-04', 1, 19.99, 'received', 1044),
    -- Order 1045: Customer 22 buys 2 games on the same day
    (22, 10, '2026-06-05', 1, 10.00, 'complete', 1045),
    (22, 11, '2026-06-05', 1, 11.99, 'complete', 1045),
    -- Orders 1046 through 1061: Standard single-item orders
    (23, 7, '2026-06-06', 1, 39.95, 'complete', 1046),
    (24, 8, '2026-06-07', 1, 44.99, 'canceled', 1047),
    (26, 9, '2026-06-08', 2, 12.99, 'shipped', 1048),
    (27, 12, '2026-06-09', 1, 59.99, 'returned', 1049),
    (29, 17, '2026-06-10', 3, 15.96, 'complete', 1050),
    (21, 18, '2026-06-11', 1, 40.00, 'ordered', 1051),
    (25, 19, '2026-06-12', 4, 5.99, 'received', 1052),
    (28, 20, '2026-06-13', 1, 14.99, 'complete', 1053),
    (30, 21, '2026-06-14', 1, 14.99, 'shipped', 1054),
    (22, 22, '2026-06-15', 1, 9.98, 'canceled', 1055),
    (23, 23, '2026-06-16', 2, 29.97, 'return_pending', 1056),
    (24, 24, '2026-06-17', 1, 15.99, 'complete', 1057),
    (26, 25, '2026-06-18', 1, 24.00, 'shipped', 1058),
    (27, 26, '2026-06-19', 1, 22.50, 'ordered', 1059),
    (29, 27, '2026-06-20', 1, 18.50, 'received', 1060),
    (21, 30, '2026-06-21', 1, 29.99, 'complete', 1061);
    

INSERT INTO Review (
    CustomerID, GameID, ReviewDate, Rating, ReviewText, ReviewStatus
) VALUES
    (22, 3, '2026-05-01', 5.0, 'Absolute masterpiece. The graphics and storytelling are out of this world!', 'posted'),
    (25, 9, '2026-05-03', 4.5, 'Really solid gameplay loop, but the final boss felt a little underwhelming.', 'verified'),
    (30, 13, '2026-05-05', 2.0, 'Way too many bugs right now. I keep clipping through the floor. Waiting for a patch.', 'posted'),
    (29, 17, '2026-05-07', 3.5, 'An average experience. It is fun, but I would wait for it to go on sale.', 'submitted'),
    (28, 21, '2026-05-09', 4.0, 'Loved the multiplayer co-op, but the single-player campaign is a bit short.', 'verified'),
    (28, 25, '2026-05-11', 5.0, 'Best game I have played all year. Cannot recommend this enough!', 'posted'),
    (24, 29, '2026-05-13', 1.0, 'Completely unplayable on my system. It crashes to desktop every ten minutes.', 'submitted'),
    (23, 4, '2026-05-15', 4.8, 'Almost perfect. The sound design and original score are top tier.', 'posted'),
    (21, 8, '2026-05-17', 2.5, 'The heavy reliance on microtransactions completely ruins the immersion for me.', 'verified'),
    (27, 12, '2026-05-19', 3.0, 'A decent time killer for a weekend, but nothing memorable.', 'posted');
    
