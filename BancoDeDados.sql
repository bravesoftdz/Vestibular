/******************************************************************************/
/****                             ESTADO                                   ****/
/******************************************************************************/

CREATE TABLE ESTADO (
    IDESTADO  SERIAL NOT NULL,
    SIGLA     VARCHAR(2),
    NOME      VARCHAR(50)
);

ALTER TABLE ESTADO ADD CONSTRAINT PK_ESTADO PRIMARY KEY (IDESTADO);

/******************************************************************************/
/****                             CIDADE                                   ****/
/******************************************************************************/

CREATE TABLE CIDADE (
    IDCIDADE  SERIAL NOT NULL,
    NOME      VARCHAR(50),
    IDESTADO  INTEGER
);

ALTER TABLE CIDADE ADD CONSTRAINT PK_CIDADE PRIMARY KEY (IDCIDADE);

ALTER TABLE CIDADE ADD CONSTRAINT FK_CIDADE_1 FOREIGN KEY (IDESTADO) REFERENCES ESTADO (IDESTADO);

/******************************************************************************/
/****                             USUARIO                                  ****/
/******************************************************************************/

CREATE TABLE USUARIO (
    IDUSUARIO  SERIAL NOT NULL,
    SENHA      VARCHAR(50),
    EMAIL      VARCHAR(50),
    NOME       VARCHAR(50),
    IDCIDADE   INTEGER,
    TIPO       SMALLINT
);

ALTER TABLE USUARIO ADD CONSTRAINT PK_USUARIO PRIMARY KEY (IDUSUARIO);

/******************************************************************************/
/****                             VESTIBULAR                               ****/
/******************************************************************************/

CREATE TABLE VESTIBULAR (
    IDVESTIBULAR  SERIAL NOT NULL,
    DATA          VARCHAR(10)
);

ALTER TABLE VESTIBULAR ADD CONSTRAINT PK_VESTIBULAR PRIMARY KEY (IDVESTIBULAR);

/******************************************************************************/
/****                             NOTAALUNO                                ****/
/******************************************************************************/

CREATE TABLE NOTAALUNO (
    IDNOTAALUNO   SERIAL NOT NULL,
    IDUSUARIO     INTEGER,
    IDVESTIBULAR  INTEGER
);

ALTER TABLE NOTAALUNO ADD CONSTRAINT PK_NOTAALUNO PRIMARY KEY (IDNOTAALUNO);

ALTER TABLE NOTAALUNO ADD CONSTRAINT FK_NOTAALUNO_1 FOREIGN KEY (IDUSUARIO) REFERENCES USUARIO (IDUSUARIO);
ALTER TABLE NOTAALUNO ADD CONSTRAINT FK_NOTAALUNO_2 FOREIGN KEY (IDVESTIBULAR) REFERENCES VESTIBULAR (IDVESTIBULAR);
