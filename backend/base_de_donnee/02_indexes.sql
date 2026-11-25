SET ROLE aomi_dev

CREATE INDEX IF NOT EXISTS idx_produit_categorie ON produit (id_categorie);
CREATE INDEX IF NOT EXISTS idx_produit_nom ON produit (lower(nom_produit));
CREATE INDEX IF NOT EXISTS idx_favori_produit ON favori (id_produit);
CREATE INDEX IF NOT EXISTS idx_panier_variante ON panier_article (id_variante);
CREATE INDEX IF NOT EXISTS idx_commande_utilisateur ON commande (id_utilisateur);
CREATE INDEX IF NOT EXISTS idx_ligne_commande_variante ON ligne_commande (id_variante);
CREATE INDEX IF NOT EXISTS idx_avis_produit ON avis (id_produit);
CREATE INDEX IF NOT EXISTS idx_tentative_email_date ON tentative_connexion (email_utilisateur, date_attempt);