--
-- PostgreSQL database dump
--

\restrict QzjaP7NNlqfPV6rgdUHM0wC6lXUjTxkxOGyXEy9o4NnTGno3AgUVSr8DBtPWqwY

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

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

--
-- Name: devolver_libro(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.devolver_libro(p_lector integer, p_libro integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE alquileres
    SET fecha_devolucion_real = CURRENT_DATE
    WHERE id_lector = p_lector
      AND id_libro = p_libro
      AND fecha_devolucion_real IS NULL;
END;
$$;


ALTER FUNCTION public.devolver_libro(p_lector integer, p_libro integer) OWNER TO postgres;

--
-- Name: libros_prestados(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.libros_prestados() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    cantidad INT;
BEGIN
    SELECT COUNT(*)
    INTO cantidad
    FROM alquileres
    WHERE fecha_devolucion_real IS NULL;

    RETURN cantidad;
END;
$$;


ALTER FUNCTION public.libros_prestados() OWNER TO postgres;

--
-- Name: log_devolucion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_devolucion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO logs_devoluciones(id_lector, id_libro)
    VALUES (NEW.id_lector, NEW.id_libro);

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_devolucion() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alquileres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alquileres (
    id_lector integer NOT NULL,
    id_libro integer NOT NULL,
    fecha_alquiler date NOT NULL,
    fecha_devolucion date,
    fecha_devolucion_real date
);


ALTER TABLE public.alquileres OWNER TO postgres;

--
-- Name: lectores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lectores (
    id integer NOT NULL,
    nombre character varying(50),
    apellido character varying(50),
    email character varying(50),
    fecha_nacimiento date
);


ALTER TABLE public.lectores OWNER TO postgres;

--
-- Name: lectores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lectores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lectores_id_seq OWNER TO postgres;

--
-- Name: lectores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lectores_id_seq OWNED BY public.lectores.id;


--
-- Name: libros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libros (
    id integer NOT NULL,
    titulo character varying(50),
    editorial character varying(50),
    autor character varying(50),
    isbn character varying(50)
);


ALTER TABLE public.libros OWNER TO postgres;

--
-- Name: libros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.libros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.libros_id_seq OWNER TO postgres;

--
-- Name: libros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.libros_id_seq OWNED BY public.libros.id;


--
-- Name: libros_prestados; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.libros_prestados AS
 SELECT le.nombre AS nombre_lector,
    le.apellido AS apellido_lector,
    li.titulo AS titulo_libro,
    li.editorial,
    li.isbn
   FROM ((public.alquileres a
     JOIN public.lectores le ON ((a.id_lector = le.id)))
     JOIN public.libros li ON ((a.id_libro = li.id)));


ALTER VIEW public.libros_prestados OWNER TO postgres;

--
-- Name: logs_devoluciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs_devoluciones (
    id integer NOT NULL,
    id_lector integer NOT NULL,
    id_libro integer NOT NULL,
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.logs_devoluciones OWNER TO postgres;

--
-- Name: logs_devoluciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_devoluciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_devoluciones_id_seq OWNER TO postgres;

--
-- Name: logs_devoluciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_devoluciones_id_seq OWNED BY public.logs_devoluciones.id;


--
-- Name: lectores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectores ALTER COLUMN id SET DEFAULT nextval('public.lectores_id_seq'::regclass);


--
-- Name: libros id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros ALTER COLUMN id SET DEFAULT nextval('public.libros_id_seq'::regclass);


--
-- Name: logs_devoluciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs_devoluciones ALTER COLUMN id SET DEFAULT nextval('public.logs_devoluciones_id_seq'::regclass);


--
-- Data for Name: alquileres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alquileres (id_lector, id_libro, fecha_alquiler, fecha_devolucion, fecha_devolucion_real) FROM stdin;
1	2	2025-11-23	2025-12-08	\N
1	3	2025-11-23	2025-12-08	\N
1	4	2025-11-23	2025-12-08	\N
2	7	2025-11-23	2025-12-08	\N
2	8	2025-11-23	2025-12-08	\N
2	9	2025-11-23	2025-12-08	\N
2	1	2025-11-23	2025-12-08	\N
3	3	2025-11-23	2025-12-08	\N
3	4	2025-11-23	2025-12-08	\N
3	5	2025-11-23	2025-12-08	\N
3	6	2025-11-23	2025-12-08	\N
4	8	2025-11-23	2025-12-08	\N
4	9	2025-11-23	2025-12-08	\N
4	1	2025-11-23	2025-12-08	\N
4	2	2025-11-23	2025-12-08	\N
5	3	2025-11-23	2025-12-08	\N
5	4	2025-11-23	2025-12-08	\N
5	5	2025-11-23	2025-12-08	\N
6	6	2025-11-23	2025-12-08	\N
6	7	2025-11-23	2025-12-08	\N
6	8	2025-11-23	2025-12-08	\N
7	9	2025-11-23	2025-12-08	\N
7	1	2025-11-23	2025-12-08	\N
7	2	2025-11-23	2025-12-08	\N
8	3	2025-11-23	2025-12-08	\N
9	4	2025-11-23	2025-12-08	\N
1	1	2025-11-23	2025-12-08	2025-12-02
2	6	2025-11-23	2025-12-08	2025-12-02
3	2	2025-11-23	2025-12-08	2025-12-02
4	7	2025-11-23	2025-12-08	2025-12-02
\.


--
-- Data for Name: lectores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lectores (id, nombre, apellido, email, fecha_nacimiento) FROM stdin;
1	Juan Alberto	Cortez	juancortez@gmail.com	1983-06-20
2	Antonia de los	Rios	antonarios_23@yahoo.com	1978-11-24
3	Nicolas	Martin	nico_martin23@gmail.com	1986-07-11
4	Nestor	Casco	nestor_casco2331@hotmmail.com	1981-02-11
5	Lisa	Perez	lisperez@hotmail.com	1994-08-11
6	Ana Rosa	Estagnolli	anros@abcdatos.com	1974-10-15
7	Milagros	Pastoruti	mili_2231@gmail.com	2001-01-22
8	Pedro	Alonso	alonso.pedro@impermebilizantesrosario.com	1983-09-05
9	Arturo Ezequiel	Ramirez	artu.rama@outlook.com	1998-03-29
10	Juan Ignacio	Altarez	juanaltarez.223@yahoo.com	1975-08-24
\.


--
-- Data for Name: libros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libros (id, titulo, editorial, autor, isbn) FROM stdin;
1	Cementerio de animales	Ediciones de Mente	Stephen King	4568874
2	En el nombre de la rosa	Editorial Espania	Umberto Eco	44558877
3	Cien anios de soledad	Sudamericana	Gabriel Garcia Marquez	7788845
4	El diario de Ellen Rimbauer	Editorial Maine	Stephen King	45699874
5	La hojarasca	Sudamericana	Gabriel Garcia Marquez	7787898
6	El amor en los tiempos del colera	Sudamericana	Gabriel Garcia Marquez	2564111
7	La casa de los espiritus	Ediciones Chile	Isabel Allende	5544781
8	Paula	Ediciones Chile	Isabel Allende	22545447
9	La tregua	Alfa	Mario Benedetti	2225412
10	Gracias por el fuego	Alfa	Mario Benedetti	88541254
\.


--
-- Data for Name: logs_devoluciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs_devoluciones (id, id_lector, id_libro, fecha_hora) FROM stdin;
1	2	6	2025-12-02 00:42:05.9133
2	3	2	2025-12-02 00:42:05.9133
3	4	7	2025-12-02 00:42:05.9133
\.


--
-- Name: lectores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lectores_id_seq', 10, true);


--
-- Name: libros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.libros_id_seq', 10, true);


--
-- Name: logs_devoluciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_devoluciones_id_seq', 3, true);


--
-- Name: lectores lectores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectores
    ADD CONSTRAINT lectores_pkey PRIMARY KEY (id);


--
-- Name: libros libros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros
    ADD CONSTRAINT libros_pkey PRIMARY KEY (id);


--
-- Name: logs_devoluciones logs_devoluciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs_devoluciones
    ADD CONSTRAINT logs_devoluciones_pkey PRIMARY KEY (id);


--
-- Name: alquileres pk_alquileres; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alquileres
    ADD CONSTRAINT pk_alquileres PRIMARY KEY (id_lector, id_libro, fecha_alquiler);


--
-- Name: alquileres trg_log_devolucion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_log_devolucion AFTER UPDATE ON public.alquileres FOR EACH ROW WHEN (((old.fecha_devolucion_real IS NULL) AND (new.fecha_devolucion_real IS NOT NULL))) EXECUTE FUNCTION public.log_devolucion();


--
-- Name: alquileres fk_lector; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alquileres
    ADD CONSTRAINT fk_lector FOREIGN KEY (id_lector) REFERENCES public.lectores(id);


--
-- Name: alquileres fk_libro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alquileres
    ADD CONSTRAINT fk_libro FOREIGN KEY (id_libro) REFERENCES public.libros(id);


--
-- PostgreSQL database dump complete
--

\unrestrict QzjaP7NNlqfPV6rgdUHM0wC6lXUjTxkxOGyXEy9o4NnTGno3AgUVSr8DBtPWqwY

