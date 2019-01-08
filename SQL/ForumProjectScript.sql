DROP DATABASE IF EXISTS forum_project_database;

CREATE DATABASE IF NOT EXISTS forum_project_database;
USE forum_project_database;

DROP TABLE IF EXISTS forum_category;
CREATE TABLE forum_category(
	id_category INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(64) NOT NULL,
	description TEXT NOT NULL,
    PRIMARY KEY (id_category)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id_user INT(11) NOT NULL AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	password CHAR(68) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	enabled INT(1) NOT NULL,
	PRIMARY KEY (id_user)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS role;
CREATE TABLE role (
	id_role INT(11) NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_role)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS users_roles;
CREATE TABLE users_roles (
	id_user INT(11) NOT NULL,
	id_role INT(11) NOT NULL,
	PRIMARY KEY(id_user, id_role),
	KEY FK_ROLE_idx (id_role),
	
	CONSTRAINT FK_USER FOREIGN KEY(id_user)
	REFERENCES users(id_user) ON DELETE NO ACTION ON UPDATE NO ACTION,
	
	CONSTRAINT FK_ROLE FOREIGN KEY (id_role)
	REFERENCES role(id_role) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS forum_post;
CREATE TABLE forum_post(
	id_post INT NOT NULL AUTO_INCREMENT,
	id_category INT NOT NULL,
	id_user INT(11),
	title VARCHAR(90),
	content TEXT NOT NULL,
	date TIMESTAMP,
	PRIMARY KEY(id_post),
	FOREIGN KEY(id_user) REFERENCES users(id_user),
	CONSTRAINT post_category FOREIGN KEY(id_category) REFERENCES forum_category(id_category) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT INTO users (username,password,first_name,last_name,email,enabled) values ('test','$2a$04$DmDGQSg/iB5bnFGMNCqPx.VNnMzDCd1IbESoQGxjO3nSbqOBhZNaa','ayyy','lmao','ayylamao@google.pl',1);
INSERT INTO users (username,password,first_name,last_name,email,enabled) values ('guest','$2a$04$DmDGQSg/iB5bnFGMNCqPx.VNnMzDCd1IbESoQGxjO3nSbqOBhZNaa','off','roblox','offroblox@lidik.de',1);
INSERT INTO role (name) values ('ROLE_USER'),('ROLE_ADMIN');
INSERT INTO users_roles(id_user,id_role) VALUES (1,1),(1,2),(2,1)