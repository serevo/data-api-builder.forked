-- Copyright (c) Microsoft Corporation.
-- Licensed under the MIT License.

DROP VIEW IF EXISTS books_view_all;
DROP VIEW IF EXISTS books_view_with_mapping;
DROP VIEW IF EXISTS stocks_view_selected;
DROP VIEW IF EXISTS books_publishers_view_composite;
DROP VIEW IF EXISTS books_publishers_view_composite_insertable;
DROP TABLE IF EXISTS book_author_link;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS book_website_placements;
DROP TABLE IF EXISTS website_users;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS default_books;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS clubs;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS magazines;
DROP TABLE IF EXISTS stocks_price;
DROP TABLE IF EXISTS stocks;
DROP TABLE IF EXISTS comics;
DROP TABLE IF EXISTS brokers;
DROP TABLE IF EXISTS type_table;
DROP TABLE IF EXISTS trees;
DROP TABLE IF EXISTS fungi;
DROP TABLE IF EXISTS empty_table;
DROP TABLE IF EXISTS notebooks;
DROP TABLE IF EXISTS journals;
DROP TABLE IF EXISTS aow;
DROP TABLE IF EXISTS series;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS graphql_incompatible;
DROP TABLE IF EXISTS GQLmappings;
DROP TABLE IF EXISTS bookmarks;
DROP TABLE IF EXISTS mappedbookmarks;
DROP TABLE IF EXISTS books_sold;
DROP TABLE IF EXISTS default_with_function_table;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_profiles;
DROP TABLE IF EXISTS dimaccount;

CREATE TABLE publishers(
    id int AUTO_INCREMENT PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE books(
    id int AUTO_INCREMENT PRIMARY KEY,
    title text NOT NULL,
    publisher_id int NOT NULL
);

CREATE TABLE default_books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) DEFAULT 'Placeholder'
);

CREATE TABLE players(
    id int AUTO_INCREMENT PRIMARY KEY,
    name text NOT NULL,
    current_club_id int NOT NULL,
    new_club_id int NOT NULL
);

CREATE TABLE clubs(
    id int AUTO_INCREMENT PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE book_website_placements(
    id int AUTO_INCREMENT PRIMARY KEY,
    book_id int UNIQUE NOT NULL,
    price int NOT NULL
);

CREATE TABLE website_users(
    id int PRIMARY KEY,
    username text NULL
);

CREATE TABLE authors(
    id int AUTO_INCREMENT PRIMARY KEY,
    name text NOT NULL,
    birthdate text NOT NULL
);

CREATE TABLE reviews(
    book_id int NOT NULL,
    id int AUTO_INCREMENT,
    content text DEFAULT ('Its a classic') NOT NULL,
    PRIMARY KEY(book_id, id),
    INDEX (id)
);

CREATE TABLE book_author_link(
    book_id int NOT NULL,
    author_id int NOT NULL,
    PRIMARY KEY(book_id, author_id)
);

CREATE TABLE magazines(
    id int PRIMARY KEY,
    title text NOT NULL,
    issue_number int NULL
);

CREATE TABLE comics(
    id int PRIMARY KEY,
    title text NOT NULL,
    volume int AUTO_INCREMENT UNIQUE KEY,
    categoryName varchar(100) NOT NULL UNIQUE,
    series_id int NULL
);

CREATE TABLE stocks(
    categoryid int NOT NULL,
    pieceid int NOT NULL,
    categoryName varchar(100) NOT NULL,
    piecesAvailable int DEFAULT (0),
    piecesRequired int DEFAULT (0) NOT NULL,
    PRIMARY KEY(categoryid, pieceid)
);

CREATE TABLE stocks_price(
    categoryid int NOT NULL,
    pieceid int NOT NULL,
    instant datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    price double,
    is_wholesale_price boolean,
    PRIMARY KEY(categoryid, pieceid, instant)
);

CREATE TABLE brokers(
    `ID Number` int PRIMARY KEY,
    `First Name` text NOT NULL,
    `Last Name` text NOT NULL
);

CREATE TABLE type_table(
    id int AUTO_INCREMENT PRIMARY KEY,
    byte_types tinyint unsigned,
    short_types smallint,
    int_types int,
    long_types bigint,
    string_types text,
    single_types float,
    float_types double,
    decimal_types decimal(38, 19),
    boolean_types boolean,
    datetime_types datetime,
    bytearray_types blob
);

CREATE TABLE trees (
    treeId int PRIMARY KEY,
    species text,
    region text,
    height text
);

CREATE TABLE fungi (
    speciesid int PRIMARY KEY,
    region text,
    habitat varchar(6)
);

CREATE TABLE empty_table (
    id int PRIMARY KEY
);

CREATE TABLE notebooks (
    id int PRIMARY KEY,
    notebookname text,
    color text,
    ownername text
);

CREATE TABLE journals (
    id int PRIMARY KEY,
    journalname text,
    color text,
    ownername text
);

CREATE TABLE aow (
    NoteNum int PRIMARY KEY,
    DetailAssessmentAndPlanning text,
    WagingWar text,
    StrategicAttack text
);

CREATE TABLE series (
    id int AUTO_INCREMENT PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE sales (
    id int AUTO_INCREMENT PRIMARY KEY,
    item_name text NOT NULL,
    subtotal decimal(18,2) NOT NULL,
    tax decimal(18,2) NOT NULL,
    total decimal(18,2) generated always as (subtotal + tax) stored
);

CREATE TABLE graphql_incompatible (
    __typeName int PRIMARY KEY,
    conformingName text
);

CREATE TABLE GQLmappings (
    __column1 int PRIMARY KEY,
    __column2 text,
    column3 text
);

CREATE TABLE bookmarks(
    id int AUTO_INCREMENT PRIMARY KEY,
    bkname text NOT NULL
);

CREATE TABLE mappedbookmarks(
    id int AUTO_INCREMENT PRIMARY KEY,
    bkname text NOT NULL
);

CREATE TABLE books_sold (
  id INT PRIMARY KEY NOT NULL,
  book_name VARCHAR(50),
  copies_sold INT DEFAULT 0,
  last_sold_on DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_sold_on_date DATETIME GENERATED ALWAYS AS (last_sold_on) STORED
);

CREATE TABLE default_with_function_table
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_value INT,
    `current_date` TIMESTAMP DEFAULT (CURRENT_DATE) NOT NULL,
    `current_timestamp` TIMESTAMP DEFAULT (NOW()) NOT NULL,
    random_number INT DEFAULT (FLOOR(RAND() * 1000)) NOT NULL,
    next_date TIMESTAMP DEFAULT (CURRENT_DATE + INTERVAL 1 DAY),
    default_string_with_parenthesis VARCHAR(100) DEFAULT ('()'),
    default_function_string_with_parenthesis VARCHAR(100) DEFAULT ('NOW()'),
    default_integer INT DEFAULT 100,
    default_date_string DATETIME DEFAULT ("1999-01-08 10:23:54")
);

CREATE TABLE users (
    userid INT AUTO_INCREMENT PRIMARY KEY,
    username NVARCHAR(50) UNIQUE,
    email NVARCHAR(100)
);

CREATE TABLE user_profiles (
    profileid INT AUTO_INCREMENT PRIMARY KEY,
    username NVARCHAR(50) UNIQUE,
    profilepictureurl NVARCHAR(255),
    userid INT
);

CREATE TABLE dimaccount (
    AccountKey INT AUTO_INCREMENT NOT NULL,
    ParentAccountKey INT,
    PRIMARY KEY (AccountKey)
);

ALTER TABLE dimaccount
ADD CONSTRAINT FK_DimAccount_DimAccount
FOREIGN KEY (ParentAccountKey)
REFERENCES dimaccount (AccountKey);

INSERT INTO dimaccount(AccountKey, ParentAccountKey)
VALUES (1, null),
(2, 1),
(3, 2),
(4, 2);

ALTER TABLE books
ADD CONSTRAINT book_publisher_fk
FOREIGN KEY (publisher_id)
REFERENCES publishers (id)
ON DELETE CASCADE;

ALTER TABLE players
ADD CONSTRAINT player_club_fk
FOREIGN KEY (current_club_id)
REFERENCES clubs (id)
ON DELETE CASCADE;

ALTER TABLE book_website_placements
ADD CONSTRAINT book_website_placement_book_fk
FOREIGN KEY (book_id)
REFERENCES books (id)
ON DELETE CASCADE;

ALTER TABLE reviews
ADD CONSTRAINT review_book_fk
FOREIGN KEY (book_id)
REFERENCES books (id)
ON DELETE CASCADE;

ALTER TABLE book_author_link
ADD CONSTRAINT book_author_link_book_fk
FOREIGN KEY (book_id)
REFERENCES books (id)
ON DELETE CASCADE;

ALTER TABLE book_author_link
ADD CONSTRAINT book_author_link_author_fk
FOREIGN KEY (author_id)
REFERENCES authors (id)
ON DELETE CASCADE;

ALTER TABLE stocks
ADD CONSTRAINT stocks_comics_fk
FOREIGN KEY (categoryName)
REFERENCES comics (categoryName)
ON DELETE CASCADE;

ALTER TABLE stocks_price
ADD CONSTRAINT stocks_price_stocks_fk
FOREIGN KEY (categoryid, pieceid)
REFERENCES stocks (categoryid, pieceid)
ON DELETE CASCADE;

ALTER TABLE comics
ADD CONSTRAINT comics_series_fk
FOREIGN KEY (series_id)
REFERENCES series(id)
ON DELETE CASCADE;

INSERT INTO bookmarks (id, bkname)
WITH RECURSIVE nums AS (
    SELECT 1 AS id
    UNION ALL
    SELECT id + 1 AS id
    FROM nums
    WHERE nums.id <= 999
)
SELECT 
id,
concat('Test Item #', id)
FROM nums;

INSERT INTO mappedbookmarks (id, bkname)
WITH RECURSIVE nums AS (
    SELECT 1 AS id
    UNION ALL
    SELECT id + 1 AS id
    FROM nums
    WHERE nums.id <= 999
)
SELECT 
id,
concat('Test Item #', id)
FROM nums;

INSERT INTO GQLmappings(__column1, __column2, column3) VALUES (1, 'Incompatible GraphQL Name', 'Compatible GraphQL Name');
INSERT INTO GQLmappings(__column1, __column2, column3) VALUES (3, 'Old Value', 'Record to be Updated');
INSERT INTO GQLmappings(__column1, __column2, column3) VALUES (4, 'Lost Record', 'Record to be Deleted');
INSERT INTO GQLmappings(__column1, __column2, column3) VALUES (5, 'Filtered Record', 'Record to be Filtered on Find');
INSERT INTO publishers(id, name) VALUES (1234, 'Big Company'), (2345, 'Small Town Publisher'), (2323, 'TBD Publishing One'), (2324, 'TBD Publishing Two Ltd'), (1940, 'Policy Publisher 01'), (1941, 'Policy Publisher 02'), (1156, 'The First Publisher');
INSERT INTO authors(id, name, birthdate) VALUES (123, 'Jelte', '2001-01-01'), (124, 'Aniruddh', '2002-02-02'), (125, 'Aniruddh', '2001-01-01'), (126, 'Aaron', '2001-01-01');
INSERT INTO clubs(id, name) VALUES (1111, 'Manchester United'), (1112, 'FC Barcelona'), (1113, 'Real Madrid');
INSERT INTO players(id, name, current_club_id, new_club_id)
    VALUES 
        (1, 'Cristiano Ronaldo', 1113, 1111),
        (2, 'Leonel Messi', 1112, 1113);
INSERT INTO books(id, title, publisher_id)
    VALUES
        (1, 'Awesome book', 1234),
        (2, 'Also Awesome book', 1234),
        (3, 'Great wall of china explained', 2345),
        (4, 'US history in a nutshell', 2345),
        (5, 'Chernobyl Diaries', 2323),
        (6, 'The Palace Door', 2324),
        (7, 'The Groovy Bar', 2324),
        (8, 'Time to Eat', 2324),
        (9, 'Policy-Test-01', 1940),
        (10, 'Policy-Test-02', 1940),
        (11, 'Policy-Test-04', 1941),
        (12, 'Time to Eat 2', 1941),
        (13, 'Before Sunrise', 1234),
        (14, 'Before Sunset', 1234),
        (15, 'SQL_CONN', 1234),
        (16, 'SOME%CONN', 1234),
        (17, 'CONN%_CONN', 1234),
        (18, '[Special Book]', 1234),
        (19, 'ME\\YOU', 1234),
        (20, 'C:\\\\LIFE', 1234);
INSERT INTO book_website_placements(book_id, price) VALUES (1, 100), (2, 50), (3, 23), (5, 33);
INSERT INTO website_users(id, username) VALUES (1, 'George'), (2, NULL), (3, ''), (4, 'book_lover_95'), (5, 'null');
INSERT INTO book_author_link(book_id, author_id) VALUES (1, 123), (2, 124), (3, 123), (3, 124), (4, 123), (4, 124), (5, 126);
INSERT INTO reviews(id, book_id, content) VALUES (567, 1, 'Indeed a great book'), (568, 1, 'I loved it'), (569, 1, 'best book I read in years');
INSERT INTO magazines(id, title, issue_number) VALUES (1, 'Vogue', 1234), (11, 'Sports Illustrated', NULL), (3, 'Fitness', NULL);
INSERT INTO series(id, name) VALUES (3001, 'Foundation'), (3002, 'Hyperion Cantos');
INSERT INTO comics(id, title, categoryName, series_id)
VALUES (1, 'Star Trek', 'SciFi', NULL), (2, 'Cinderella', 'Tales', 3001), (3,'Únknown','', 3002), (4, 'Alexander the Great', 'Historical', NULL);
INSERT INTO stocks(categoryid, pieceid, categoryName) VALUES (1, 1, 'SciFi'), (2, 1, 'Tales'),(0,1,''),(100, 99, 'Historical');
INSERT INTO brokers(`ID Number`, `First Name`, `Last Name`) VALUES (1, 'Michael', 'Burry'), (2, 'Jordan', 'Belfort');
INSERT INTO stocks_price(categoryid, pieceid, price, is_wholesale_price) VALUES (2, 1, 100.57, true), (1, 1, 42.75, false);
INSERT INTO stocks_price(categoryid, pieceid, instant, price, is_wholesale_price) VALUES (2, 1, '2023-08-21 15:11:04', 100.57, 1);
INSERT INTO type_table(id, byte_types, short_types, int_types, long_types, string_types, single_types, float_types, decimal_types, boolean_types, datetime_types, bytearray_types) VALUES
    (1, 1, 1, 1, 1, '', 0.33, 0.33, 0.333333, true, '1999-01-08 10:23:54', 0xABCDEF0123),
    (2, 0, -1, -1, -1, 'lksa;jdflasdf;alsdflksdfkldj', -9.2, -9.2, -9.292929, false, '1999-01-08 10:23:00', 0x98AB7511AABB1234),
    (3, 0, -32768, -2147483648, -9223372036854775808, '', -3.4E38, -1.7E308, 2.929292E-19, true, '1753-01-01 00:00:00.000', 0x00000000),
    (4, 255, 32767, 2147483647, 9223372036854775807, 'null', 3.4E38, 1.7E308, 2.929292E-14, true, '9999-12-31 23:59:59', 0xFFFFFFFF),
    (5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO trees(treeId, species, region, height) VALUES (1, 'Tsuga terophylla', 'Pacific Northwest', '30m'), (2, 'Pseudotsuga menziesii', 'Pacific Northwest', '40m');
INSERT INTO trees(treeId, species, region, height) VALUES (4, 'test', 'Pacific Northwest', '0m');
INSERT INTO fungi(speciesid, region, habitat) VALUES (1, 'northeast', 'forest'), (2, 'southwest', 'sand');
INSERT INTO fungi(speciesid, region, habitat) VALUES (3, 'northeast', 'test');
INSERT INTO notebooks(id, notebookname, color, ownername) VALUES (1, 'Notebook1', 'red', 'Sean'), (2, 'Notebook2', 'green', 'Ani'), (3, 'Notebook3', 'blue', 'Jarupat'), (4, 'Notebook4', 'yellow', 'Aaron');
INSERT INTO journals(id, journalname, color, ownername)
VALUES
    (1, 'Journal1', 'red', 'Sean'),
    (2, 'Journal2', 'green', 'Ani'),
    (3, 'Journal3', 'blue', 'Jarupat'),
    (4, 'Journal4', 'yellow', 'Aaron'),
    (5, 'Journal5', null, 'Abhishek'),
    (6, 'Journal6', 'green', null),
    (7, 'Journal7', null, null);
INSERT INTO aow(NoteNum, DetailAssessmentAndPlanning, WagingWar, StrategicAttack) VALUES (1, 'chapter one notes: ', 'chapter two notes: ', 'chapter three notes: ');
INSERT INTO sales(id, item_name, subtotal, tax) VALUES (1, 'Watch', 249.00, 20.59), (2, 'Montior', 120.50, 11.12);
INSERT INTO books_sold (id, book_name, last_sold_on) VALUES (1, 'Awesome Book', '2023-08-28 10:00:00');

INSERT INTO users (username, email) VALUES ('john_doe', 'john.doe@example.com'), ('jane_smith', 'jane.smith@example.com');
INSERT INTO user_profiles (username, profilepictureurl, userid) VALUES ('john_doe', 'https://example.com/profiles/john_doe.jpg', 1), ('jane_smith', 'https://example.com/profiles/jane_smith.jpg', 2);


-- Starting with id > 5000 is chosen arbitrarily so that the incremented id-s won't conflict with the manually inserted ids in this script
-- AUTO_INCREMENT is set to 5001 so the next autogenerated id will be 5001

ALTER TABLE books AUTO_INCREMENT = 5001;
ALTER TABLE book_website_placements AUTO_INCREMENT = 5001;
ALTER TABLE publishers AUTO_INCREMENT = 5001;
ALTER TABLE authors AUTO_INCREMENT = 5001;
ALTER TABLE reviews AUTO_INCREMENT = 5001;
ALTER TABLE comics AUTO_INCREMENT = 5001;
ALTER TABLE type_table AUTO_INCREMENT = 5001;
ALTER TABLE sales AUTO_INCREMENT = 5001;
ALTER TABLE players AUTO_INCREMENT = 5001;
ALTER TABLE clubs AUTO_INCREMENT = 5001;

ALTER TABLE default_with_function_table AUTO_INCREMENT = 5001;

prepare stmt1 from  'CREATE VIEW books_view_all AS SELECT * FROM books';

prepare stmt2 from  'CREATE VIEW books_view_with_mapping AS SELECT * FROM books';

prepare stmt3 from 'CREATE VIEW stocks_view_selected AS SELECT
                    categoryid,pieceid,categoryName,piecesAvailable
                    FROM stocks';

prepare stmt4 from 'CREATE VIEW books_publishers_view_composite as SELECT
                    books.id,books.title,publishers.name,publishers.id as pub_id
                    FROM books,publishers
                    where publishers.id = books.publisher_id';

prepare stmt5 from 'CREATE VIEW books_publishers_view_composite_insertable as SELECT
                    books.id, books.title, publishers.name, books.publisher_id
                    FROM books,publishers
                    where publishers.id = books.publisher_id';

execute stmt1;
execute stmt2;
execute stmt3;
execute stmt4;
execute stmt5;
