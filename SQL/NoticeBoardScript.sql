DROP DATABASE IF EXISTS baza_sklep;
CREATE DATABASE IF NOT EXISTS baza_sklep;
USE baza_sklep;

DROP TABLE IF EXISTS opinions;
CREATE TABLE opinions(
	opinion_id INT AUTO_INCREMENT NOT NULL,
	opinion VARCHAR(250) NOT NULL,
	rating INT(10) NOT NULL,
	PRIMARY KEY(opinion_id)
);

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	user_id INT AUTO_INCREMENT NOT NULL,
	opinion_id INT,
	username VARCHAR(30) NOT NULL,
	password VARCHAR(60) NOT NULL,
	creation_date TIMESTAMP,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	birth_date DATE,
	email VARCHAR(50),
	enabled BOOLEAN DEFAULT 1,
	PRIMARY KEY(user_id),
	FOREIGN KEY(opinion_id) REFERENCES opinions(opinion_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS role;
CREATE TABLE role(
	role_id INT AUTO_INCREMENT NOT NULL,
	role_name VARCHAR(50) NOT NULL,
	PRIMARY KEY(role_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS users_roles;
CREATE TABLE users_roles (
	user_id INT(11) NOT NULL,
	role_id INT(11) NOT NULL,
	PRIMARY KEY(user_id, role_id),
	KEY FK_ROLE_idx (role_id),
	
	CONSTRAINT FK_USER FOREIGN KEY(user_id)
	REFERENCES users(user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	
	CONSTRAINT FK_ROLE FOREIGN KEY (role_id)
	REFERENCES role(role_id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS product_category;
CREATE TABLE product_category(
	category_id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(60) NOT NULL,
	PRIMARY KEY(category_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS auction;
CREATE TABLE auction(
	auction_id INT AUTO_INCREMENT NOT NULL,
	user_id INT NOT NULL,
	title VARCHAR(100),
	description VARCHAR(250),
	contact_phone VARCHAR(10),
	contact_email VARCHAR(50),
	creation_date TIMESTAMP ,
	PRIMARY KEY(auction_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS product;
CREATE TABLE product(
	product_id INT AUTO_INCREMENT NOT NULL,
	auction_id INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	price FLOAT NOT NULL,
	category_id INT NOT NULL,
	PRIMARY KEY(product_id),
	FOREIGN KEY(category_id) REFERENCES product_category(category_id),
	FOREIGN KEY(auction_id) REFERENCES auction(auction_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO users (username,password,first_name,last_name,email,enabled) values ('test','$2a$04$DmDGQSg/iB5bnFGMNCqPx.VNnMzDCd1IbESoQGxjO3nSbqOBhZNaa','ayyy','lmao','ayylamao@google.pl',1);
INSERT INTO users (username,password,first_name,last_name,email,enabled) values ('guest','$2a$04$DmDGQSg/iB5bnFGMNCqPx.VNnMzDCd1IbESoQGxjO3nSbqOBhZNaa','off','roblox','offroblox@lidik.de',1);
INSERT INTO role (role_name) values ('ROLE_USER'),('ROLE_ADMIN');
INSERT INTO users_roles(user_id,role_id) VALUES (1,1),(1,2),(2,1);
INSERT INTO product_category(name) VALUES ('Technologia'),('Dom'),('Sport'),('Odziez'),('Praca');

