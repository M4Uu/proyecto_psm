DROP DATABES IF EXISTS chickendb
CREATE DATABASE chickendb
USE chickendb

CREATE TABLE admin(
  id BINARY(16) PRIMARY KEY UNIQUE DEFAULT (UUID_TO_BIN(UUID())),
  user varchar(20) NOT NULL UNIQUE,
  password varchar(30) NOT NULL
);

INSERT INTO admin(user, password) VALUES
  ("admin","admin");

SELECT * FROM admin;

CREATE TABLE users(
  id BINARY(16) PRIMARY KEY UNIQUE DEFAULT (UUID_TO_BIN(UUID())),
  user varchar(20) NOT NULL UNIQUE,
  password varchar(30) NOT NULL
);

CREATE TABLE info_user(
  id BINARY(16) PRIMARY KEY UNIQUE DEFAULT (UUID_TO_BIN(UUID())),
  user_id BINARY(16)
  FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE,
  email varchar(30) NOT NULL UNIQUE,
  phone integer NOT NULL UNIQUE,
  first_name varchar(20) NOT NULL,
  last_name varchar(20) NOT NULL,
  location_id BINARY(16);
  FOREIGN KEY (location_id) REFERENCES location(id) ON UPDATE CASCADE
);

CREATE TABLE location(
  id BINARY(16) PRIMARY KEY UNIQUE DEFAULT (UUID_TO_BIN(UUID())),
  city varchar(30) NOT NULL,
  parish varchar(30) NOT NULL,
  street varchar(30) NOT NULL,
  building varchar(30) NOT NULL
);

CREATE TABLE item(
  id BINARY(16) PRIMARY KEY UNIQUE DEFAULT (UUID_TO_BIN(UUID())),
  name varchar(30) NOT NULL,
  price varchar(30) NOT NULL,
  stock varchar(30) NOT NULL,
);

CREATE TABLE invoice(
  id BINARY(16) PRIMARY KEY UNIQUE DEFAULT (UUID_TO_BIN(UUID())),
  created_hour TIME DEFAULT CURRENT_TIME,
  created_date DATE DEFAULT CURRENT_DATE,
  user_id BINARY(16),
  FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE,
  total DECIMAL(10,2) NOT NULL
);

CREATE TABLE detail_invoice(
    id BINARY(16) PRIMARY KEY UNIQUE DEFAULT (UUID_TO_BIN(UUID())),
    invoice_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unitary_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * unitary_price) STORED,
    FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    FOREIGN KEY (item_id) REFERENCES item(id)
);