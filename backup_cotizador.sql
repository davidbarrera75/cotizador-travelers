--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: edificios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edificios (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    ciudad character varying(100) NOT NULL
);


ALTER TABLE public.edificios OWNER TO postgres;

--
-- Name: edificios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edificios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edificios_id_seq OWNER TO postgres;

--
-- Name: edificios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edificios_id_seq OWNED BY public.edificios.id;


--
-- Name: fichas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fichas (
    id integer NOT NULL,
    cliente character varying(255),
    edificio character varying(255),
    tipo_apartamento character varying(255),
    personas integer,
    dias integer,
    total numeric,
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT now()
);


ALTER TABLE public.fichas OWNER TO postgres;

--
-- Name: fichas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fichas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fichas_id_seq OWNER TO postgres;

--
-- Name: fichas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fichas_id_seq OWNED BY public.fichas.id;


--
-- Name: tarifas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarifas (
    id integer NOT NULL,
    tipo_apartamento_id integer NOT NULL,
    personas integer NOT NULL,
    precio integer NOT NULL
);


ALTER TABLE public.tarifas OWNER TO postgres;

--
-- Name: tarifas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarifas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tarifas_id_seq OWNER TO postgres;

--
-- Name: tarifas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarifas_id_seq OWNED BY public.tarifas.id;


--
-- Name: tipos_apartamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_apartamento (
    id integer NOT NULL,
    edificio_id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text
);


ALTER TABLE public.tipos_apartamento OWNER TO postgres;

--
-- Name: tipos_apartamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_apartamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_apartamento_id_seq OWNER TO postgres;

--
-- Name: tipos_apartamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_apartamento_id_seq OWNED BY public.tipos_apartamento.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cotizador_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO cotizador_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cotizador_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO cotizador_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cotizador_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: edificios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificios ALTER COLUMN id SET DEFAULT nextval('public.edificios_id_seq'::regclass);


--
-- Name: fichas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fichas ALTER COLUMN id SET DEFAULT nextval('public.fichas_id_seq'::regclass);


--
-- Name: tarifas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarifas ALTER COLUMN id SET DEFAULT nextval('public.tarifas_id_seq'::regclass);


--
-- Name: tipos_apartamento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_apartamento ALTER COLUMN id SET DEFAULT nextval('public.tipos_apartamento_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: cotizador_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: edificios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edificios (id, nombre, ciudad) FROM stdin;
1	Obelisco Apartamentos	Bogotá
2	Fontana Plaza	Bogotá
3	Condominio Plenitud	Bogotá
4	Castellón de Juanambú	Cali
5	Orange Suites Medellín	Medellín
6	Rioverde Living Suites	Rionegro
7	Orange Cartagena	Cartagena
8	Terrazas Tayrona	Santa Marta
\.


--
-- Data for Name: fichas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fichas (id, cliente, edificio, tipo_apartamento, personas, dias, total, descripcion, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: tarifas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarifas (id, tipo_apartamento_id, personas, precio) FROM stdin;
1	1	1	266000
2	1	2	277000
3	2	2	367000
4	2	3	377000
5	2	4	387000
6	3	1	285000
7	3	2	297000
8	4	2	385000
9	4	3	396000
10	4	4	407000
11	5	1	310000
12	5	2	321000
13	6	2	409000
14	6	3	420000
15	6	4	431000
16	7	1	170000
17	7	2	170000
18	8	2	210000
19	8	3	210000
20	8	4	210000
21	9	1	270000
22	9	2	310000
23	10	1	300000
24	10	2	340000
25	11	1	350000
26	11	2	390000
27	11	3	430000
28	12	1	400000
29	12	2	440000
30	12	3	480000
31	12	4	520000
32	13	1	298000
33	13	2	346000
34	14	1	338000
35	14	2	386000
36	14	3	434000
37	15	1	388000
38	15	2	436000
39	15	3	484000
40	15	4	532000
41	16	1	340000
42	16	2	390000
43	16	3	440000
44	16	4	490000
45	17	1	360000
46	17	2	410000
47	17	3	460000
48	17	4	510000
49	18	1	380000
50	18	2	430000
51	18	3	480000
52	18	4	530000
53	18	5	580000
54	18	6	630000
55	19	1	400000
56	19	2	450000
57	19	3	500000
58	19	4	550000
59	19	5	600000
60	19	6	650000
61	20	1	220000
62	20	2	270000
63	21	1	240000
65	22	2	310000
66	22	3	360000
67	22	4	410000
68	23	2	330000
69	23	3	380000
70	23	4	430000
64	21	2	280000
\.


--
-- Data for Name: tipos_apartamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipos_apartamento (id, edificio_id, nombre, descripcion) FROM stdin;
1	1	1 Habitación	Habitación con cama king o 2 camas sencillas, closet y baño con tina, Sala, Cocina equipada.
2	1	2 Habitaciones	Habitación con cama king o dos camas sencillas, closet y baño con tina. Segunda habitación con cama king o dos camas sencillas y baño, Sala – Comedor, Cocina equipada.
3	2	1 Habitación	Habitación con cama king o dos camas sencillas, vestier y baño, Sala y cocina americana equipada.
4	2	2 Habitaciones	Habitación con cama king o dos camas sencillas, vestier y baño. Habitación auxiliar con cama king o 2 camas sencillas, Baño auxiliar completo, Sala- comedor y Cocina americana equipada.
5	3	1 Habitación	Habitación con cama king o dos camas sencillas, walking closet y baño, Sala – comedor y Cocina equipada.
6	3	2 Habitaciones	Habitación con cama king o dos camas sencillas, walking closet y baño. Segunda habitación con 1 o 2 camas sencillas y baño, Sala – comedor y Cocina equipada.
7	4	Junior	Suite un solo ambiente. Cama Doble, Baño con tina, Sala – comedor y Cocina equipada.
8	4	Junior Suite	Suite de dos ambientes. Habitación con 2 camas dobles y baño con tina, Sala con sofá cama, Comedor, Cocina equipada y Baño auxiliar completo.
9	5	Orange	Habitación principal con cama king o dos camas sencillas y baño interno, cocina abierta con barra y balcón.
10	5	Orange Suites	Apartamento de dos ambientes. Habitación con cama king o dos camas sencillas, baño - vestier, sala con sofá cama sencillo, cocina abierta con barra, baño exterior y balcón.
11	5	Duplex Pequeño	Apartamento de dos pisos. 1° piso sala con sofá cama sencillo, cocina abierta con barra, baño exterior y balcón. 2° piso habitación con cama king o dos camas sencillas, baño - vestier y balcón.
12	5	Duplex Grande	Apartamento de dos pisos. 1° piso sala con sofá cama extradoble, comedor, cocina americana, baño exterior y balcón. 2° piso habitación con dos camas sencillas o cama King, baño - vestier y balcón.
13	6	Junior	Aparta Suite de un solo ambiente con cama king o 2 camas sencillas, baño, closet con cajilla de seguridad, sala (sofá cama sencillo), cocina abierta equipada y balcón.
14	6	Junior Suite	Apartamento de una habitación con cama king o dos camas sencillas, baño - vestier con cajilla de seguridad, sala (sofá cama doble), comedor, cocina abierta equipada y balcón.
15	6	Suite	Apartamento de dos habitaciones: Habitación Principal con cama king o dos camas sencillas y baño - vestier con cajilla de seguridad. Habitación Auxiliar con cama king o dos camas sencillas, baño auxiliar completo, sala (sofa cama doble), comedor, cocina abierta equipada y balcón.
16	7	Orange	Habitación principal con cama doble y baño interno. Segunda habitación con dos camas sencillas, Cocina equipada, Sala – comedor con balcón y segundo baño en el corredor.
17	7	Orange Suite	Habitación principal con cama king y baño interno con vestier. Segunda habitación con cama doble. Cocina equipada. Sala – comedor con balcón. Segundo baño en el corredor.
18	7	Orange Suite Superior	Habitación principal con cama king y baño interno con vestier. Segunda habitación con dos camas sencillas. Tercera habitación con un camarote y baño interno. Cocina equipada. Sala – comedor con balcón. Tercer baño en el corredor.
19	7	Deluxe	Habitación principal con cama king y baño interno con vestier. Segunda habitación con dos camas sencillas. Tercera habitación con un camarote y baño interno. Cocina equipada. Sala con sofá cama y comedor con balcón. Tercer baño en el corredor.
20	8	Suite	Habitación con cama doble y balcón.Sala con sofá cama doble y balcón.Cocina abierta equipada y barra tipo americana.Baño en el área social.
21	8	Estándar	Habitación con cama doble, baño y balcón.Sala con sofá cama doble y balcón.Cocina abierta equipada y barra tipo americano.Un baño en el área social.
22	8	Apartasuite	Habitación principal con cama doble, baño y balcón.Habitación auxiliar con dos camas sencillas o cama King y balcón.  Sala  - comedor con sofá cama doble y balcón.Cocina abierta equipada y barra tipo americano. Segundo baño en el área social.
23	8	Family	Habitación principal con cama doble, baño y balcón.Habitación auxiliar con dos camas sencillas o una cama king, baño y balcón.Sala-comedor con sofá cama doble y balcón.  Cocina abierta equipada y barra tipo americano.Segundo baño en el área social.
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cotizador_user
--

COPY public.users (id, username, password, created_at) FROM stdin;
1	admin	$2b$10$CT8vosPCt3pPJgiEX1BfuuWBMbcNlNJJYURSg086ygrb6xduGLL2i	2025-08-30 18:35:16.391047
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, username, password_hash) FROM stdin;
1	admin	$2a$10$N9qo8uLOickgx2ZMRZoMye.IKbeumMcKNAC2CGxOPs1OrX21j52rq
2	david	$2a$10$z.h2.gR8.i9.j0.k1.l2.m3.n4.o5.p6.q7.r8.s9.t0.u1.v2.w3
\.


--
-- Name: edificios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.edificios_id_seq', 8, true);


--
-- Name: fichas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fichas_id_seq', 1, false);


--
-- Name: tarifas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarifas_id_seq', 70, true);


--
-- Name: tipos_apartamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_apartamento_id_seq', 23, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cotizador_user
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 2, true);


--
-- Name: edificios edificios_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificios
    ADD CONSTRAINT edificios_nombre_key UNIQUE (nombre);


--
-- Name: edificios edificios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificios
    ADD CONSTRAINT edificios_pkey PRIMARY KEY (id);


--
-- Name: fichas fichas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fichas
    ADD CONSTRAINT fichas_pkey PRIMARY KEY (id);


--
-- Name: tarifas tarifas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarifas
    ADD CONSTRAINT tarifas_pkey PRIMARY KEY (id);


--
-- Name: tipos_apartamento tipos_apartamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_apartamento
    ADD CONSTRAINT tipos_apartamento_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: cotizador_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: cotizador_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);


--
-- Name: tarifas tarifas_tipo_apartamento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarifas
    ADD CONSTRAINT tarifas_tipo_apartamento_id_fkey FOREIGN KEY (tipo_apartamento_id) REFERENCES public.tipos_apartamento(id);


--
-- Name: tipos_apartamento tipos_apartamento_edificio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_apartamento
    ADD CONSTRAINT tipos_apartamento_edificio_id_fkey FOREIGN KEY (edificio_id) REFERENCES public.edificios(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO cotizador_user;


--
-- Name: TABLE edificios; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.edificios TO cotizador_user;


--
-- Name: SEQUENCE edificios_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.edificios_id_seq TO cotizador_user;


--
-- Name: TABLE fichas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.fichas TO cotizador_user;


--
-- Name: SEQUENCE fichas_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.fichas_id_seq TO cotizador_user;


--
-- Name: TABLE tarifas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tarifas TO cotizador_user;


--
-- Name: SEQUENCE tarifas_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tarifas_id_seq TO cotizador_user;


--
-- Name: TABLE tipos_apartamento; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tipos_apartamento TO cotizador_user;


--
-- Name: SEQUENCE tipos_apartamento_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tipos_apartamento_id_seq TO cotizador_user;


--
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuarios TO cotizador_user;


--
-- Name: SEQUENCE usuarios_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.usuarios_id_seq TO cotizador_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO cotizador_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO cotizador_user;


--
-- PostgreSQL database dump complete
--

