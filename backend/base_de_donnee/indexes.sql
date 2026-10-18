CREATE INDEX idx_produit_categorie      ON produit (id_categorie);
CREATE INDEX idx_produit_nom            ON produit (lower(nom));
CREATE INDEX idx_favori_produit         ON favori (id_produit);
CREATE INDEX idx_commande_utilisateur   ON commande (id_utilisateur);
CREATE INDEX idx_ligne_commande_produit ON ligne_commande (id_produit);
CREATE INDEX idx_avis_produit           ON avis (id_produit);
CREATE INDEX idx_tentative_email_date   ON tentative_connexion (email, date_tentative);