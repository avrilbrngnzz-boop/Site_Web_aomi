
SET ROLE aomi_dev;
CREATE TABLE IF NOT EXISTS utilisateur(
    id_utilisateur SERIAL PRIMARY KEY,
    nom  VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe  VARCHAR(255) NOT NULL,
    role_utilisateur VARCHAR(20) NOT NULL DEFAULT 'utilisateur' Check (role_utilisateur IN ('utilisateur', 'analyste', 'admin')),
    date_creation TIMESTAMPTZ  not null DEFAULT now()
);


CREATE TABLE IF NOT EXISTS tentative_connexion(
    id_tentative SERIAL PRIMARY KEY,
    email_utilisateur VARCHAR(100) NOT NULL,
    status_tentative  BOOLEAN NOT NULL ,
    date_attempt TIMESTAMPTZ not null DEFAULT now()
);



CREATE TABLE IF NOT EXISTS categorie(
    id_categorie SERIAL PRIMARY KEY,
    nom_categorie VARCHAR(100) NOT NULL UNIQUE,
    description_categorie TEXT,
    date_creation TIMESTAMPTZ NOT NULL DEFAULT now()
); 

CREATE TABLE IF NOT EXISTS produit(
    id_produit SERIAL PRIMARY KEY,
    nom_produit VARCHAR(100) NOT NULL,
    description_produit TEXT,
    image_url TEXT,
    id_categorie INTEGER NOT NULL REFERENCES categorie(id_categorie) ON DElete restrict,
    date_creation TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS variante(
    id_variante SERIAL  PRIMARY KEY,
    id_produit INTEGER not null REFERENCES produit(id_produit) ON DELETE CASCADE,
    taille varchar(10) not null CHECK (taille in ('XS','S','M','L','XL','XXL','UNIQUE')),
    prix numeric(10,2) not null CHECK(prix >0),
    quantite integer not null default 0 check(quantite>=0),
    CONSTRAINT variante_produit_taille_unique UNIQUE (id_produit,taille)
);



CREATE TABLE IF NOT EXISTS favori(
    id_utilisateur integer not null references utilisateur(id_utilisateur) ON DELETE CASCADE,
    id_produit integer not null references produit(id_produit) ON DELETE CASCADE,
    date_ajout  TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (id_utilisateur, id_produit)
);



CREATE TABLE IF NOT EXISTS panier_article(
    id_utilisateur integer not null references utilisateur(id_utilisateur) ON DELETE CASCADE,
    id_variante INT NOT NULL REFERENCES variante(id_variante) ON DELETE CASCADE,
    quantite INT NOT NULL CHECK(quantite > 0),
    date_ajout TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (id_utilisateur, id_variante)
);


CREATE TABLE IF NOT EXISTS  commande(
    id_commande SERIAL PRIMARY KEY,
    id_utilisateur INT NOT NULL REFERENCES utilisateur(id_utilisateur) ON DELETE RESTRICT,
    date_commande TIMESTAMPTZ  NOT NULL DEFAULT now(),
    statut VARCHAR(20) not null DEFAULT 'en_attente' check
    (statut in ('en_attente','payee','expediee','livree','annulee')),
    adresse_livraison text not null,
    total_prix NUMERIC(10, 2) NOT NULL DEFAULT 0 CHECK( total_prix >=0)
);

CREATE TABLE IF NOT EXISTS ligne_commande (
    id_commande INTEGER NOT NULL REFERENCES commande(id_commande) ON DELETE CASCADE,
    id_variante INT NOT NULL REFERENCES variante(id_variante) ON DELETE RESTRICT,  
    quantite INTEGER NOT NULL CHECK (quantite > 0),
    prix_unitaire NUMERIC(10,2) NOT NULL CHECK (prix_unitaire > 0), 
    PRIMARY KEY (id_commande, id_variante)
);

CREATE TABLE IF NOT EXISTS avis (
    id_avis SERIAL PRIMARY KEY,
    id_utilisateur INT NOT NULL REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    id_produit INT NOT NULL REFERENCES produit(id_produit) ON DELETE CASCADE,
    note SMALLINT NOT NULL CHECK (note BETWEEN 1 AND 5),
    commentaire TEXT,
    date_avis TIMESTAMPTZ  NOT NULL DEFAULT now(),
    UNIQUE (id_utilisateur, id_produit)
);

CREATE TABLE IF NOT EXISTS message_contact (
    id_message SERIAL PRIMARY KEY,
    id_utilisateur INTEGER REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL,  -- facultatif (visiteur)
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    sujet VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    date_envoi TIMESTAMPTZ  NOT NULL DEFAULT now(),
    traite  BOOLEAN NOT NULL DEFAULT false
);
