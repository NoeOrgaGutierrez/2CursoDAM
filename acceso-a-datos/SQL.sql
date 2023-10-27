CREATE TABLE JUGUETE (
    JUGUETE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    JUGUETE_NOMBRE VARCHAR2(30),
    JUGUETE_PRECIO NUMBER(4,2),
    CONSTRAINT PK_JUGUETE PRIMARY KEY (JUGUETE_ID)
);

CREATE TABLE EMPRESA (
    EMPRESA_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    EMPRESA_NOMBRE VARCHAR2(20),
    EMPRESA_CIF VARCHAR2(20),
    EMPRESA_DIRECCIONPOSTAL VARCHAR2(50),
    EMPRESA_DIRECCIONWEB VARCHAR2(100),
    EMPRESA_TELEFONO VARCHAR2(20),
    CONSTRAINT PK_EMPRESA PRIMARY KEY (EMPRESA_ID)
);

CREATE TABLE PARTICULAR (
    PARTICULAR_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    PARTICULAR_NOMBRE VARCHAR2(20),
    PARTICULAR_APELLIDO VARCHAR2(30),
    PARTICULAR_TELEFONO VARCHAR2(20),
    PARTICULAR_DIRECCION VARCHAR2(15),
    CONSTRAINT PK_PARTICULAR PRIMARY KEY (PARTICULAR_ID)
);

CREATE TABLE EMPRESAJUGUETE (
    EMPRESAJUGUETE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    EMPRESAJUGUETE_EMPRESAID NUMBER NOT NULL,
    EMPRESAJUGUETE_JUGUETE NUMBER NOT NULL,
    EMPRESAJUGUETE_CANTIDAD NUMBER(3),
    CONSTRAINT PK_EMPRESAJUGUETE PRIMARY KEY (EMPRESAJUGUETE_ID),
    CONSTRAINT FK_EMPRESAJUGUETE_EMPRESAID
    FOREIGN KEY (EMPRESAJUGUETE_EMPRESAID)
    REFERENCES EMPRESA (EMPRESA_ID),
    CONSTRAINT FK_EMPRESAJUGUETE_JUGUETEID
    FOREIGN KEY (EMPRESAJUGUETE_JUGUETE)
    REFERENCES JUGUETE (JUGUETE_ID),
    CONSTRAINT UQ_EMPRESAJUGUETE UNIQUE (EMPRESAJUGUETE_EMPRESAID, EMPRESAJUGUETE_JUGUETE)
);

CREATE TABLE PARTICULARJUGUETE (
    PARTICULARJUGUETE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    PARTICULARJUGUETE_PARTICULARID NUMBER NOT NULL,
    PARTICULARJUGUETE_JUGUETEID NUMBER NOT NULL,
    PARTICULARJUGUETE_CANTIDAD NUMBER(3),
    CONSTRAINT PK_PARTICULARJUGUETE PRIMARY KEY (PARTICULARJUGUETE_ID),
    CONSTRAINT FK_PARTICULARJUGUETE_PARTICULARID
    FOREIGN KEY (PARTICULARJUGUETE_PARTICULARID)
    REFERENCES PARTICULAR (PARTICULAR_ID),
    CONSTRAINT FK_PARTICULARJUGUETE_JUGUETEID
    FOREIGN KEY (PARTICULARJUGUETE_JUGUETEID)
    REFERENCES JUGUETE (JUGUETE_ID),
    CONSTRAINT UQ_PARTICULARJUGUETE UNIQUE (PARTICULARJUGUETE_PARTICULARID, PARTICULARJUGUETE_JUGUETEID)
);

CREATE TABLE PEDIDOEMPRESA (
    PEDIDOEMPRESA_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    PEDIDOEMPRESA_EMPRESAID NUMBER NOT NULL,
    PEDIDOEMPRESA_NOMBRE VARCHAR2(30),
    PEDIDOEMPRESA_FECHA DATE,
    PEDIDOEMPRESA_DIRECCIONENVIO VARCHAR2(50),
    CONSTRAINT PK_PEDIDOEMPRESA PRIMARY KEY (PEDIDOEMPRESA_ID),
    CONSTRAINT FK_PEDIDOEMPRESA_EMPRESAID
    FOREIGN KEY (PEDIDOEMPRESA_EMPRESAID)
    REFERENCES EMPRESA (EMPRESA_ID)
);

CREATE TABLE PEDIDOPARTICULAR (
    PEDIDOPARTICULAR_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    PEDIDOPARTICULAR_PARTICULARID NUMBER NOT NULL,
    PEDIDOPARTICULAR_FECHA DATE,
    CONSTRAINT PK_PEDIDOPARTICULAR PRIMARY KEY (PEDIDOPARTICULAR_ID),
    CONSTRAINT FK_PEDIDOPARTICULAR_PARTICULARID
    FOREIGN KEY (PEDIDOPARTICULAR_PARTICULARID)
    REFERENCES PARTICULAR (PARTICULAR_ID)
);

CREATE TABLE PEDIDOEMPRESAJUGUETE (
    PEDIDOEMPRESAJUGUETE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    PEDIDOEMPRESAJUGUETE_PEDIDOEMPRESAID NUMBER NOT NULL,
    PEDIDOEMPRESAJUGUETE_JUGUETEID NUMBER NOT NULL,
    PEDIDOEMPRESAJUGUETE_CANTIDAD NUMBER(3),
    CONSTRAINT PK_PEDIDOEMPRESAJUGUETE PRIMARY KEY (PEDIDOEMPRESAJUGUETE_ID),
    CONSTRAINT FK_PEDIDOEMPRESAJUGUETE_PEDIDOEMPRESAID
    FOREIGN KEY (PEDIDOEMPRESAJUGUETE_PEDIDOEMPRESAID)
    REFERENCES PEDIDOEMPRESA (PEDIDOEMPRESA_ID),
    CONSTRAINT FK_PEDIDOEMPRESAJUGUETE_JUGUETEID
    FOREIGN KEY (PEDIDOEMPRESAJUGUETE_JUGUETEID)
    REFERENCES JUGUETE (JUGUETE_ID),
    CONSTRAINT UQ_PEDIDOEMPRESAJUGUETE UNIQUE (PEDIDOEMPRESAJUGUETE_PEDIDOEMPRESAID, PEDIDOEMPRESAJUGUETE_JUGUETEID)
);

CREATE TABLE PEDIDOEMPRESAPARTICULAR (
    PEDIDOEMPRESAPARTICULAR_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    PEDIDOEMPRESAPARTICULAR_PEDIDOEMPRESA_ID NUMBER NOT NULL,
    PEDIODEMPRESAPARTICULAR_PARTICULAR_ID NUMBER NOT NULL,
    PEDIDOEMPRESAPARTICULAR_CANTIDAD NUMBER(3),
    CONSTRAINT PK_PEDIDOEMPRESAPARTICULAR PRIMARY KEY (PEDIDOEMPRESAPARTICULAR_ID),
    CONSTRAINT FK_PEDIDOEMPRESAPARTICULAR_PEDIDOEMPRESAID
    FOREIGN KEY (PEDIDOEMPRESAPARTICULAR_PEDIDOEMPRESA_ID)
    REFERENCES PEDIDOEMPRESA (PEDIDOEMPRESA_ID),
    CONSTRAINT FK_PEDIDOEMPRESAPARTICULAR_PARTICULARID
    FOREIGN KEY (PEDIODEMPRESAPARTICULAR_PARTICULAR_ID)
    REFERENCES PARTICULAR (PARTICULAR_ID),
    CONSTRAINT UQ_PEDIDOEMPRESAPARTICULAR UNIQUE (PEDIDOEMPRESAPARTICULAR_PEDIDOEMPRESA_ID, PEDIODEMPRESAPARTICULAR_PARTICULAR_ID)
);

CREATE TABLE ALBARAN (
    ALBARAN_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    ALBARAN_PEDIDOID NUMBER,
    ALBARAN_FECHA DATE,
    CONSTRAINT PK_ALBARAN PRIMARY KEY (ALBARAN_ID),
    CONSTRAINT FK_ALBARANPEDIDOID
    FOREIGN KEY (ALBARAN_PEDIDOID)
    REFERENCES PEDIDOEMPRESA (PEDIDOEMPRESA_ID)
);

CREATE TABLE ALBARANJUGUETE (
    ALBARANJUGUETE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    ALBARANJUGUETE_ALBARAN_ID NUMBER NOT NULL,
    ALBARANJUGUETE_JUGUETE_ID NUMBER NOT NULL,
    ALBARANJUGUETE_CANTIDAD NUMBER(3),
    CONSTRAINT PK_ALBARANJUGUETE PRIMARY KEY (ALBARANJUGUETE_ID),
    CONSTRAINT FK_ALBARANJUGUETE_ALBARANID
    FOREIGN KEY (ALBARANJUGUETE_ALBARAN_ID)
    REFERENCES ALBARAN (ALBARAN_ID),
    CONSTRAINT FK_ALBARANJUGUETE_JUGUETEID
    FOREIGN KEY (ALBARANJUGUETE_JUGUETE_ID)
    REFERENCES JUGUETE (JUGUETE_ID),
    CONSTRAINT UQ_ALBARANJUGUETE UNIQUE (ALBARANJUGUETE_ALBARAN_ID, ALBARANJUGUETE_JUGUETE_ID)
);
CREATE TABLE CLIENTE (
    CLIENTE_ID NUMBER(5) PRIMARY KEY,
    CLIENTE_NOMBRE VARCHAR2(255) NOT NULL,
    CLIENTE_APELLIDO VARCHAR2(255),
    CLIENTE_TELEFONO NUMBER,
    CLIENTE_EMAIL VARCHAR2(255) NOT NULL,
    CLIENTE_CIF VARCHAR2(20)
);

CREATE TABLE CARRITO (
    CARRITO_ID NUMBER(5) PRIMARY KEY,
    CARRITO_JUGUETEID NUMBER(5) NOT NULL,
    CARRITO_CLIENTEID NUMBER(5) NOT NULL,
    CARRITO_CANTIDAD NUMBER,
    CONSTRAINT FK_CARRITO_JUGUETEID FOREIGN KEY (CARRITO_JUGUETEID) REFERENCES JUGUETE(JUGUETE_ID),
    CONSTRAINT FK_CARRITO_CLIENTEID FOREIGN KEY (CARRITO_CLIENTEID) REFERENCES CLIENTE(CLIENTE_ID),
    CONSTRAINT UQ_CARRITO UNIQUE (CARRITO_JUGUETEID, CARRITO_CLIENTEID)
);

CREATE TABLE DIRECCIONFACTURACION (
    DIRECCIONFACTURACION_ID NUMBER(5) PRIMARY KEY,
    DIRECCIONFACTURACION_CLIENTEID NUMBER(5),
    DIRECCIONFACTURACION_NOMBRE VARCHAR2(255),
    CONSTRAINT FK_DIRECCIONFACTURACION FOREIGN KEY (DIRECCIONFACTURACION_CLIENTEID) REFERENCES CLIENTE(CLIENTE_ID)
);

CREATE TABLE DIRECCIONENVIO (
    DIRECCIONENVIO_ID NUMBER(5) PRIMARY KEY,
    DIRECCIONENVIO_CLIENTEID NUMBER(5),
    DIRECCIONENVIO_NOMBRE VARCHAR2(255),
    CONSTRAINT FK_DIRECCIONENVIO FOREIGN KEY (DIRECCIONENVIO_CLIENTEID) REFERENCES CLIENTE(CLIENTE_ID)
);

CREATE TABLE PEDIDOCLIENTE (
    PEDIDOCLIENTE_ID NUMBER(5) PRIMARY KEY,
    PEDIDOCLIENTE_CLIENTE_ID NUMBER(5) NOT NULL,
    PEDIDOCLIENTE_MPAGO VARCHAR2(50),
    PEDIDOCLIENTE_FECHA DATE,
    CONSTRAINT FK_PEDIDOCLIENTE FOREIGN KEY (PEDIDOCLIENTE_CLIENTE_ID) REFERENCES CLIENTE(CLIENTE_ID)
);

CREATE TABLE LINEAPEDIDO (
    LINEAPEDIDO_ID NUMBER(5) PRIMARY KEY,
    LINEAPEDIDO_JUGUETEID NUMBER(5) NOT NULL,
    LINEAPEDIDO_PEDIDOID NUMBER(5) NOT NULL,
    LINEAPEDIDO_CANTIDAD NUMBER,
    CONSTRAINT FK_LINEAPEDIDO_JUGUETEID FOREIGN KEY (LINEAPEDIDO_JUGUETEID) REFERENCES JUGUETE(JUGUETE_ID),
    CONSTRAINT FK_LINEAPEDIDO_PEDIDOID FOREIGN KEY (LINEAPEDIDO_PEDIDOID) REFERENCES PEDIDOCLIENTE(PEDIDOCLIENTE_ID),
    CONSTRAINT UQ_LINEAPEDIDO UNIQUE (LINEAPEDIDO_JUGUETEID, LINEAPEDIDO_PEDIDOID)
);

CREATE TABLE CLIENTEALBARAN (
    CLIENTEALBARAN_ID NUMBER(5) PRIMARY KEY,
    CLIENTALBARAN_FACTURAID NUMBER(5),
    CLIENTEALBARAN_PEDIDOID NUMBER(5) NOT NULL,
    CLIENTEALBARAN_FECHA DATE,
    CLIENTEALBARAN_ACEPTADO NUMBER(1,0),
    CONSTRAINT FK_CLIENTEALBARAN FOREIGN KEY (CLIENTALBARAN_FACTURAID) REFERENCES CLIENTEFACTURA(CLIENTEFACTURA_ID)
);

CREATE TABLE LINEAALBARAN (
    LINEAALBARAN_ID NUMBER(5) PRIMARY KEY,
    LINEAALBARAN_JUGUETEID NUMBER(5) NOT NULL,
    LINEAALBARAN_ALBARANID NUMBER(5) NOT NULL,
    LINEAALBARAN_CANTIDAD NUMBER,
    CONSTRAINT FK_LINEAALBARAN_JUGUETEID FOREIGN KEY (LINEAALBARAN_JUGUETEID) REFERENCES JUGUETE(JUGUETE_ID),
    CONSTRAINT FK_LINEAALBARAN_ALBARANID FOREIGN KEY (LINEAALBARAN_ALBARANID) REFERENCES CLIENTEALBARAN(CLIENTEALBARAN_ID),
    CONSTRAINT UQ_LINEAALBARAN UNIQUE (LINEAALBARAN_JUGUETEID, LINEAALBARAN_ALBARANID)
);

CREATE TABLE CLIENTEFACTURA (
    CLIENTEFACTURA_ID NUMBER(5) PRIMARY KEY,
    CLIENTEFACTURA_FECHA DATE,
    CLIENTEFACUTURA_ACEPTADO NUMBER(1,0)
);

CREATE TABLE TICKET (
    TICKET_ID NUMBER(5) PRIMARY KEY,
    TICKET_TIPOCOMPRA NUMBER(3),
    TICKET_TIPOTARJETA NUMBER(3),
    TICKET_TITULAR VARCHAR2(30),
    TICKET_NUMERO VARCHAR2(15),
    TICKET_DEVOLUCION DATE
);

CREATE TABLE JUGUETETICKET (
    JUGUETETICKET_ID NUMBER(5) PRIMARY KEY,
    JUGUETETICKET_JUGUETEID NUMBER(5) NOT NULL,
    JUGUETETICKET_TICKETID NUMBER(5) NOT NULL,
    JUGUETETICKET_CANTIDAD VARCHAR2(3),
    CONSTRAINT FK_JUGUETETICKET_JUGUETEID FOREIGN KEY (JUGUETETICKET_JUGUETEID) REFERENCES JUGUETE(JUGUETE_ID),
    CONSTRAINT FK_JUGUETETICKET_TICKETID FOREIGN KEY (JUGUETETICKET_TICKETID) REFERENCES TICKET(TICKET_ID),
    CONSTRAINT UQ_JUGUETETICKET UNIQUE (JUGUETETICKET_JUGUETEID, JUGUETETICKET_TICKETID)
);