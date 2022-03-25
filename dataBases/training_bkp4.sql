--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4 (Debian 13.4-0+deb11u1)
-- Dumped by pg_dump version 13.4 (Debian 13.4-0+deb11u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: isx36579183
--

CREATE TABLE public.clients (
    num_clie smallint NOT NULL,
    empresa character varying(20) NOT NULL,
    rep_clie smallint NOT NULL,
    limit_credit numeric(8,2),
    nif character(9)
);


ALTER TABLE public.clients OWNER TO isx36579183;

--
-- Name: comandes; Type: TABLE; Schema: public; Owner: isx36579183
--

CREATE TABLE public.comandes (
    num_comanda integer NOT NULL,
    data date NOT NULL,
    clie smallint NOT NULL,
    rep smallint,
    fabricant character(3) NOT NULL,
    producte character(5) NOT NULL,
    quantitat smallint NOT NULL,
    import numeric(7,2) NOT NULL
);


ALTER TABLE public.comandes OWNER TO isx36579183;

--
-- Name: rep_vendes; Type: TABLE; Schema: public; Owner: isx36579183
--

CREATE TABLE public.rep_vendes (
    num_empl smallint NOT NULL,
    nom character varying(30) NOT NULL,
    edat smallint,
    oficina_rep smallint,
    carrec character varying(20),
    data_contracte date NOT NULL,
    cap smallint,
    quota numeric(8,2),
    vendes numeric(8,2),
    CONSTRAINT ck_rep_vendes_edat CHECK ((edat > 0)),
    CONSTRAINT ck_rep_vendes_nom CHECK (((nom)::text = initcap((nom)::text))),
    CONSTRAINT ck_rep_vendes_quota CHECK ((quota > (0)::numeric)),
    CONSTRAINT ck_rep_vendes_vendes CHECK ((vendes > (0)::numeric))
);


ALTER TABLE public.rep_vendes OWNER TO isx36579183;

--
-- Name: comandes_sue; Type: VIEW; Schema: public; Owner: isx36579183
--

CREATE VIEW public.comandes_sue AS
 SELECT comandes.num_comanda,
    comandes.data,
    comandes.clie,
    comandes.rep,
    comandes.fabricant,
    comandes.producte,
    comandes.quantitat,
    comandes.import
   FROM public.comandes
  WHERE (comandes.rep IN ( SELECT rep_vendes.num_empl
           FROM public.rep_vendes
          WHERE ((rep_vendes.nom)::text = 'Sue Smith'::text)));


ALTER TABLE public.comandes_sue OWNER TO isx36579183;

--
-- Name: oficines; Type: TABLE; Schema: public; Owner: isx36579183
--

CREATE TABLE public.oficines (
    oficina smallint NOT NULL,
    ciutat character varying(15) NOT NULL,
    regio character varying(10) NOT NULL,
    director smallint,
    objectiu numeric(9,2),
    vendes numeric(9,2)
);


ALTER TABLE public.oficines OWNER TO isx36579183;

--
-- Name: oficina_est; Type: VIEW; Schema: public; Owner: isx36579183
--

CREATE VIEW public.oficina_est AS
 SELECT oficines.oficina,
    oficines.ciutat,
    oficines.regio,
    oficines.director,
    oficines.objectiu,
    oficines.vendes
   FROM public.oficines
  WHERE ((oficines.regio)::text = 'Est'::text)
  WITH LOCAL CHECK OPTION;


ALTER TABLE public.oficina_est OWNER TO isx36579183;

--
-- Name: productes; Type: TABLE; Schema: public; Owner: isx36579183
--

CREATE TABLE public.productes (
    id_fabricant character(3) NOT NULL,
    id_producte character(5) NOT NULL,
    descripcio character varying(20) NOT NULL,
    preu numeric(7,2) NOT NULL,
    estoc integer
);


ALTER TABLE public.productes OWNER TO isx36579183;

--
-- Name: productes_sense_comandes; Type: TABLE; Schema: public; Owner: isx36579183
--

CREATE TABLE public.productes_sense_comandes (
    producte character(5),
    id_fabricant character(3),
    id_producte character(5)
);


ALTER TABLE public.productes_sense_comandes OWNER TO isx36579183;

--
-- Name: rep_oest; Type: VIEW; Schema: public; Owner: isx36579183
--

CREATE VIEW public.rep_oest AS
 SELECT rep_vendes.num_empl,
    rep_vendes.nom,
    rep_vendes.edat,
    rep_vendes.oficina_rep,
    rep_vendes.carrec,
    rep_vendes.data_contracte,
    rep_vendes.cap,
    rep_vendes.quota,
    rep_vendes.vendes
   FROM public.rep_vendes
  WHERE (rep_vendes.oficina_rep IN ( SELECT oficines.oficina
           FROM public.oficines
          WHERE ((oficines.regio)::text = 'Oest'::text)));


ALTER TABLE public.rep_oest OWNER TO isx36579183;

--
-- Name: rep_vendes_baixa; Type: TABLE; Schema: public; Owner: isx36579183
--

CREATE TABLE public.rep_vendes_baixa (
    baixa timestamp without time zone
)
INHERITS (public.rep_vendes);


ALTER TABLE public.rep_vendes_baixa OWNER TO isx36579183;

--
-- Name: topemp; Type: VIEW; Schema: public; Owner: isx36579183
--

CREATE VIEW public.topemp AS
 SELECT rep_vendes.oficina_rep,
    sum(rep_vendes.vendes) AS sum
   FROM public.rep_vendes
  GROUP BY rep_vendes.oficina_rep;


ALTER TABLE public.topemp OWNER TO isx36579183;

--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: isx36579183
--

COPY public.clients (num_clie, empresa, rep_clie, limit_credit, nif) FROM stdin;
2111	JCP Inc.	103	50000.00	\N
2102	First Corp.	101	65000.00	\N
2103	Acme Mfg.	105	50000.00	\N
2123	Carter & Sons	102	40000.00	\N
2107	Ace International	110	35000.00	\N
2115	Smithson Corp.	101	20000.00	\N
2101	Jones Mfg.	106	65000.00	\N
2112	Zetacorp	108	50000.00	\N
2121	QMA Assoc.	103	45000.00	\N
2114	Orion Corp	102	20000.00	\N
2124	Peter Brothers	107	40000.00	\N
2108	Holm & Landis	109	55000.00	\N
2117	J.P. Sinclair	106	35000.00	\N
2122	Three-Way Lines	105	30000.00	\N
2120	Rico Enterprises	102	50000.00	\N
2106	Fred Lewis Corp.	102	65000.00	\N
2119	Solomon Inc.	109	25000.00	\N
2118	Midwest Systems	108	60000.00	\N
2113	Ian & Schmidt	104	20000.00	\N
2109	Chen Associates	103	25000.00	\N
2105	AAA Investments	101	45000.00	\N
\.


--
-- Data for Name: comandes; Type: TABLE DATA; Schema: public; Owner: isx36579183
--

COPY public.comandes (num_comanda, data, clie, rep, fabricant, producte, quantitat, import) FROM stdin;
112961	1989-12-17	2117	106	rei	2a44l	7	31500.00
113012	1990-01-11	2111	105	aci	41003	35	3745.00
112989	1990-01-03	2101	106	fea	114  	6	1458.00
113051	1990-02-10	2118	108	qsa	k47  	4	1420.00
112968	1989-10-12	2102	101	aci	41004	34	3978.00
110036	1990-01-30	2107	110	aci	4100z	9	22500.00
113045	1990-02-02	2112	108	rei	2a44r	10	45000.00
112963	1989-12-17	2103	105	aci	41004	28	3276.00
113013	1990-01-14	2118	108	bic	41003	1	652.00
113058	1990-02-23	2108	109	fea	112  	10	1480.00
112997	1990-01-08	2124	107	bic	41003	1	652.00
112983	1989-12-27	2103	105	aci	41004	6	702.00
113024	1990-01-20	2114	108	qsa	xk47 	20	7100.00
113062	1990-02-24	2124	107	fea	114  	10	2430.00
112979	1989-10-12	2114	102	aci	4100z	6	15000.00
113027	1990-01-22	2103	105	aci	41002	54	4104.00
113007	1990-01-08	2112	108	imm	773c 	3	2925.00
113069	1990-03-02	2109	107	imm	775c 	22	31350.00
113034	1990-01-29	2107	110	rei	2a45c	8	632.00
112992	1989-11-04	2118	108	aci	41002	10	760.00
112975	1989-12-12	2111	103	rei	2a44g	6	2100.00
113055	1990-02-15	2108	101	aci	4100x	6	150.00
113048	1990-02-10	2120	102	imm	779c 	2	3750.00
112993	1989-01-04	2106	102	rei	2a45c	24	1896.00
113065	1990-02-27	2106	102	qsa	xk47 	6	2130.00
113003	1990-01-25	2108	109	imm	779c 	3	5625.00
113049	1990-02-10	2118	108	qsa	xk47 	2	776.00
112987	1989-12-31	2103	105	aci	4100y	11	27500.00
113057	1990-02-18	2111	103	aci	4100x	24	600.00
113042	1990-02-02	2113	101	rei	2a44r	5	22500.00
\.


--
-- Data for Name: oficines; Type: TABLE DATA; Schema: public; Owner: isx36579183
--

COPY public.oficines (oficina, ciutat, regio, director, objectiu, vendes) FROM stdin;
22	Denver	Oest	108	300000.00	186042.00
11	New York	Est	106	575000.00	692637.00
12	Chicago	Est	104	800000.00	735042.00
13	Atlanta	Est	105	350000.00	367911.00
21	Los Angeles	Oest	108	725000.00	835915.00
\.


--
-- Data for Name: productes; Type: TABLE DATA; Schema: public; Owner: isx36579183
--

COPY public.productes (id_fabricant, id_producte, descripcio, preu, estoc) FROM stdin;
rei	2a45c	V Stago Trinquet	79.00	210
aci	4100y	Extractor	2750.00	25
qsa	xk47 	Reductor	355.00	38
imm	779c 	Riosta 2-Tm	1875.00	9
aci	41003	Article Tipus 3	107.00	207
aci	41004	Article Tipus 4	117.00	139
bic	41003	Manovella	652.00	3
rei	2a44l	Frontissa Esq.	4500.00	12
fea	112  	Coberta	148.00	115
imm	775c 	Riosta 1-Tm	1425.00	5
aci	4100z	Muntador	2500.00	28
aci	41002	Article Tipus 2	76.00	167
rei	2a44r	Frontissa Dta.	4500.00	12
imm	773c 	Riosta 1/2-Tm	975.00	28
aci	4100x	Peu de rei	25.00	37
fea	114  	Bancada Motor	243.00	15
rei	2a44g	Passador Frontissa	350.00	14
\.


--
-- Data for Name: productes_sense_comandes; Type: TABLE DATA; Schema: public; Owner: isx36579183
--

COPY public.productes_sense_comandes (producte, id_fabricant, id_producte) FROM stdin;
\N	aci	41001
\N	qsa	xk48 
\N	bic	41089
\N	qsa	xk48a
\N	imm	887x 
\N	imm	887h 
\N	imm	887p 
\N	bic	41672
\.


--
-- Data for Name: rep_vendes; Type: TABLE DATA; Schema: public; Owner: isx36579183
--

COPY public.rep_vendes (num_empl, nom, edat, oficina_rep, carrec, data_contracte, cap, quota, vendes) FROM stdin;
105	Bill Adams	37	13	Representant Vendes	1988-02-12	104	350000.00	367911.00
109	Mary Jones	31	11	Representant Vendes	1989-10-12	106	300000.00	392725.00
102	Sue Smith	48	21	Representant Vendes	1986-12-10	108	350000.00	474050.00
106	Sam Clark	52	11	VP Vendes	1988-06-14	\N	275000.00	299912.00
104	Bob Smith	33	12	Dir Vendes	1987-05-19	106	200000.00	142594.00
101	Dan Roberts	45	12	Representant Vendes	1986-10-20	104	300000.00	305673.00
110	Tom Snyder	41	\N	Representant Vendes	1990-01-13	101	\N	75985.00
108	Larry Fitch	62	21	Dir Vendes	1989-10-12	106	350000.00	361865.00
103	Paul Cruz	29	12	Representant Vendes	1987-03-01	104	275000.00	286775.00
107	Nancy Angelli	49	22	Representant Vendes	1988-11-14	108	300000.00	186042.00
\.


--
-- Data for Name: rep_vendes_baixa; Type: TABLE DATA; Schema: public; Owner: isx36579183
--

COPY public.rep_vendes_baixa (num_empl, nom, edat, oficina_rep, carrec, data_contracte, cap, quota, vendes, baixa) FROM stdin;
\.


--
-- Name: clients nif_unique; Type: CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT nif_unique UNIQUE (nif);


--
-- Name: clients pk_clients_num_clie; Type: CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT pk_clients_num_clie PRIMARY KEY (num_clie);


--
-- Name: comandes pk_comanda_num_comanda; Type: CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.comandes
    ADD CONSTRAINT pk_comanda_num_comanda PRIMARY KEY (num_comanda);


--
-- Name: oficines pk_oficines_oficina; Type: CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.oficines
    ADD CONSTRAINT pk_oficines_oficina PRIMARY KEY (oficina);


--
-- Name: productes pk_producte_fp; Type: CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.productes
    ADD CONSTRAINT pk_producte_fp PRIMARY KEY (id_fabricant, id_producte);


--
-- Name: rep_vendes pk_rep_vendes_num_empl; Type: CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.rep_vendes
    ADD CONSTRAINT pk_rep_vendes_num_empl PRIMARY KEY (num_empl);


--
-- Name: clients fk_clients_rep_clie; Type: FK CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT fk_clients_rep_clie FOREIGN KEY (rep_clie) REFERENCES public.rep_vendes(num_empl);


--
-- Name: comandes fk_comandes_clie; Type: FK CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.comandes
    ADD CONSTRAINT fk_comandes_clie FOREIGN KEY (clie) REFERENCES public.clients(num_clie);


--
-- Name: comandes fk_comandes_rep; Type: FK CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.comandes
    ADD CONSTRAINT fk_comandes_rep FOREIGN KEY (rep) REFERENCES public.rep_vendes(num_empl);


--
-- Name: oficines fk_oficina_director; Type: FK CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.oficines
    ADD CONSTRAINT fk_oficina_director FOREIGN KEY (director) REFERENCES public.rep_vendes(num_empl);


--
-- Name: rep_vendes fk_rep_vendes_cap; Type: FK CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.rep_vendes
    ADD CONSTRAINT fk_rep_vendes_cap FOREIGN KEY (cap) REFERENCES public.rep_vendes(num_empl);


--
-- Name: rep_vendes fk_rep_vendes_oficina_rep; Type: FK CONSTRAINT; Schema: public; Owner: isx36579183
--

ALTER TABLE ONLY public.rep_vendes
    ADD CONSTRAINT fk_rep_vendes_oficina_rep FOREIGN KEY (oficina_rep) REFERENCES public.oficines(oficina);


--
-- Name: TABLE clients; Type: ACL; Schema: public; Owner: isx36579183
--

GRANT SELECT ON TABLE public.clients TO isx6223835;


--
-- Name: TABLE comandes; Type: ACL; Schema: public; Owner: isx36579183
--

GRANT SELECT ON TABLE public.comandes TO guest;
GRANT SELECT ON TABLE public.comandes TO isx6223835;


--
-- Name: TABLE rep_vendes; Type: ACL; Schema: public; Owner: isx36579183
--

GRANT SELECT ON TABLE public.rep_vendes TO guest;
GRANT SELECT ON TABLE public.rep_vendes TO isx6223835;


--
-- Name: TABLE oficines; Type: ACL; Schema: public; Owner: isx36579183
--

GRANT SELECT ON TABLE public.oficines TO guest;
GRANT SELECT ON TABLE public.oficines TO isx6223835;


--
-- Name: TABLE productes; Type: ACL; Schema: public; Owner: isx36579183
--

GRANT SELECT ON TABLE public.productes TO guest;
GRANT SELECT ON TABLE public.productes TO isx6223835;


--
-- PostgreSQL database dump complete
--

