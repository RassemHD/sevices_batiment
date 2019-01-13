CREATE TABLE IF NOT EXISTS utilisateurs(
	no_util CHAR(50),
	nom VARCHAR(30) NOT NULL,
	prenom VARCHAR(30) NOT NULL,
	adresse VARCHAR(60) NOT NULL,
	telephone CHAR(15) NOT NULL,
	mail VARCHAR(50) NOT NULL,
	mot_de_passe VARCHAR(80) NOT NULL,
	pic_dest VARCHAR(80),
	date_up VARCHAR(60),
	confirme BOOLEAN NOT NULL DEFAULT FALSE, 
	CONSTRAINT pk_util PRIMARY KEY(no_util),
	CONSTRAINT login_passwd UNIQUE(mail,mot_de_passe)
);

CREATE TABLE IF NOT EXISTS clients(
	no_util_cli CHAR(50),
    CONSTRAINT pk_cli PRIMARY KEY(no_util_cli),
    CONSTRAINT fk_cli_util FOREIGN KEY (no_util_cli) REFERENCES utilisateurs(no_util)  
);

CREATE TABLE IF NOT EXISTS professionnels(
    no_util_pro CHAR(50),
    metier VARCHAR(30),
	diplome VARCHAR(60),
	annees_exp INT,
	note INT DEFAULT 0,
    CONSTRAINT pk_pro PRIMARY KEY(no_util_pro),
    CONSTRAINT fk_pro_util FOREIGN KEY (no_util_pro) REFERENCES utilisateurs(no_util)
);

CREATE TABLE IF NOT EXISTS materiels(
	no_materiel CHAR(15),
	nom_materiel VARCHAR(80),
	image VARCHAR(100),
	prix_loc REAL,
	description VARCHAR(1000),
    CONSTRAINT pk_mat PRIMARY KEY (no_materiel)
);

CREATE TABLE IF NOT EXISTS locations(
	no_util CHAR(50) NOT NULL,
	no_materiel CHAR(30) NOT NULL,
	date_debut DATE NOT NULL,
	date_fin DATE NOT NULL,
	adresse_remise VARCHAR(60) NOT NULL,
	montant REAL,
	CONSTRAINT pk_louer PRIMARY KEY(no_util,no_materiel,date_debut),
	CONSTRAINT fk_loc_util FOREIGN KEY (no_util) REFERENCES utilisateurs(no_util),
	CONSTRAINT fk_loc_mat FOREIGN KEY (no_materiel) REFERENCES materiels(no_materiel),
	CONSTRAINT c_date_loc CHECK(date_fin > date_debut)
);


CREATE TABLE IF NOT EXISTS contacter(
	no_util_pro CHAR(50),
	no_util_cli CHAR(50),
	date_contacte DATE NOT NULL,
	rendez_vous DATE,
	motif VARCHAR(200) NOT NULL,
	valider BOOLEAN,
	CONSTRAINT pk_contact PRIMARY KEY(no_util_pro,no_util_cli,rendez_vous),
	CONSTRAINT fk_cont_pro FOREIGN KEY(no_util_pro) REFERENCES professionnels(no_util_pro),
	CONSTRAINT fk_cont_cli FOREIGN KEY(no_util_cli) REFERENCES clients(no_util_cli)
);