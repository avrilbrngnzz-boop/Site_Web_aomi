CREATE DATABASE IF NOT EXISTS aomi_db;

USE aomi_db;

CREATE TABLE IF NOT EXISTS user(
    id_user INT PRIMARY KEY AUTO_INCREMENT,
    nom_utilisateur VARCHAR(50) NOT NULL,
    email_utilisateur VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe_utilisateur VARCHAR(255) NOT NULL,
    role_utilisateur ENUM('utilisateur', 'analyste', 'admin') NOT NULL DEFAULT 'utilisateur',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS categorie(
    id_categorie INT PRIMARY KEY AUTO_INCREMENT,
    nom_categorie VARCHAR(100) NOT NULL UNIQUE,
    description_categorie TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

CREATE TABLE IF NOT EXISTS produit(
    id_produit INT PRIMARY KEY AUTO_INCREMENT,
    nom_produit VARCHAR(100) NOT NULL,
    description_produit TEXT,
    prix_produit DECIMAL(10, 2) NOT NULL,
    id_categorie INT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie)
);

CREATE TABLE IF NOT EXISTS login_attempts(
    id_attempt INT PRIMARY KEY AUTO_INCREMENT,
    email_utilisateur VARCHAR(100) NOT NULL,
    date_attempt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS  stock(
    id_stock INT PRIMARY KEY AUTO_INCREMENT,
    id_produit INT,
    quantite_stock INT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_produit) REFERENCES produit(id_produit)
);  

CREATE TABLE IF NOT EXISTS  commande(
    id_commande INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_prix DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY(id_user) REFERENCES user(id_user)
);


CREATE TABLE IF NOT EXISTS article(
    id_article INT PRIMARY KEY AUTO_INCREMENT,
    id_produit INT,
    quantite INT NOT NULL,
    prix_ligne DECIMAL(10, 2) NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_produit) REFERENCES produit(id_produit)
);

CREATE TABLE IF NOT EXISTS feedback(
    id_feedback INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    commentaire TEXT NOT NULL,
    date_feedback TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_user) REFERENCES user(id_user)
);