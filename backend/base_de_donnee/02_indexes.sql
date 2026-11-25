SET ROLE aomi_dev;

CREATE INDEX IF NOT EXISTS idx_produit_categorie ON produit (id_categorie);
CREATE INDEX IF NOT EXISTS idx_produit_nom ON produit (lower(nom_produit));
CREATE INDEX IF NOT EXISTS idx_favori_produit ON favori (id_produit);
CREATE INDEX IF NOT EXISTS idx_panier_variante ON panier_article (id_variante);
CREATE INDEX IF NOT EXISTS idx_commande_utilisateur ON commande (id_utilisateur);
CREATE INDEX IF NOT EXISTS idx_ligne_commande_variante ON ligne_commande (id_variante);
CREATE INDEX IF NOT EXISTS idx_avis_produit ON avis (id_produit);
CREATE INDEX IF NOT EXISTS idx_tentative_email_date ON tentative_connexion (email_utilisateur, date_attempt);
CREATE INDEX IF NOT EXISTS idx_mouvement_carte ON mouvement_points (id_carte, date_mouvement);
-- Une commande ne peut rapporter, consommer ou annuler des points qu'une seule fois.
CREATE UNIQUE INDEX IF NOT EXISTS idx_mouvement_commande_type ON mouvement_points (id_commande, type_mouvement)
    WHERE id_commande IS NOT NULL AND type_mouvement <> 'ajustement';