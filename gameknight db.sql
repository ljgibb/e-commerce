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
    (27, 12, '2026-05-28', 1, 59.99, 'ordered', 1010);

    

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
    