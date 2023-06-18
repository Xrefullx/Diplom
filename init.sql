--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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

--
-- Name: add_task(character varying, character varying, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_task(s_phone character varying, title character varying, reason_id integer, email character varying, companyname character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    phone_error TEXT = 'Номер телефона пустой';
    title_error TEXT = 'Добавьте описание проблемы';
    email_error TEXT = 'Добавьте описание email';
    companyname_error TEXT = 'Добавьте описание название компании';
BEGIN
    IF s_phone IS NULL THEN
		RAISE EXCEPTION USING MESSAGE = phone_error;
    END IF;

    IF length(s_phone) > 10 THEN
        RAISE EXCEPTION 'Проверьте номер телефона';
    END IF;

    IF title IS NULL OR title = ' ' THEN
        RAISE EXCEPTION USING MESSAGE = title_error;
    END IF;

    IF email IS NULL OR email = ' ' THEN
        RAISE EXCEPTION USING MESSAGE = email_error;
    END IF;

    IF companyname IS NULL OR companyname = ' ' THEN
        RAISE EXCEPTION USING MESSAGE = companyname_error;
    END IF;

    INSERT INTO public.task(s_phone, title, reason_id, email, companyname)
    VALUES (s_phone, title, reason_id, email, companyname);
END;
$$;


ALTER FUNCTION public.add_task(s_phone character varying, title character varying, reason_id integer, email character varying, companyname character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: board; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.board (
    id integer NOT NULL,
    "userId" integer,
    title text,
    description text
);


ALTER TABLE public.board OWNER TO postgres;

--
-- Name: board_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.board ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.board_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reason (
    id integer NOT NULL,
    "nameReason" text
);


ALTER TABLE public.reason OWNER TO postgres;

--
-- Name: reasonDescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."reasonDescription" (
    id integer NOT NULL,
    description text
);


ALTER TABLE public."reasonDescription" OWNER TO postgres;

--
-- Name: reason_description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reason_description (
    id integer NOT NULL,
    id_reason integer NOT NULL,
    id_description integer NOT NULL
);


ALTER TABLE public.reason_description OWNER TO postgres;

--
-- Name: reason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reason ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    description text,
    full_access integer
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    "nameStatus" text
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: statusDescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."statusDescription" (
    id integer NOT NULL,
    description text
);


ALTER TABLE public."statusDescription" OWNER TO postgres;

--
-- Name: status_description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_description (
    id_status integer NOT NULL,
    id_description integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.status_description OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.status ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    id integer NOT NULL,
    title text,
    userid integer,
    reasonid integer,
    boardid integer,
    statusid integer,
    icon text,
    phone text,
    email text,
    companyname text,
    problem text,
    description text,
    date date
);


ALTER TABLE public.task OWNER TO postgres;

--
-- Name: task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.task ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    login text,
    password text,
    "FIO" text
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."user" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id_user integer NOT NULL,
    id_roles integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    idmum integer NOT NULL,
    login text,
    password text,
    s_name1 text,
    s_name2 text,
    s_name3 text,
    f_admin integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: board; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.board (id, "userId", title, description) FROM stdin;
1	1	test	test
\.


--
-- Data for Name: reason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reason (id, "nameReason") FROM stdin;
1	Не работает лояльность
2	Проблема с кассой
3	Проблема с акцией
4	Не начисляются бонусы
5	Не предоставляется скидка
6	Необходимость отчёта
7	Другое
\.


--
-- Data for Name: reasonDescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."reasonDescription" (id, description) FROM stdin;
\.


--
-- Data for Name: reason_description; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reason_description (id, id_reason, id_description) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, description, full_access) FROM stdin;
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id, "nameStatus") FROM stdin;
1	не обработана
2	в работе
3	на проверке
4	решена
\.


--
-- Data for Name: statusDescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."statusDescription" (id, description) FROM stdin;
\.


--
-- Data for Name: status_description; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status_description (id_status, id_description, id) FROM stdin;
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task (id, title, userid, reasonid, boardid, statusid, icon, phone, email, companyname, problem, description, date) FROM stdin;
29	Необходим отчёт	1	1	1	1	😕	79132434312	12223@mail.ru	Город Красоты	Отчёт о продажах за апрель 2023	передано разработчику	\N
28	проблема со списанием	1	1	1	1	😕	79132432312	123@mail.ru	Город Красоты	На товар не проходит списание на товар из категории одежды	передано разработчику на вторую линию	\N
30	Не работает лояльность на точке	1	1	1	2	😕	79132434312	12223@mail.ru	Позитив	На торговой точке мира 23 не работает лояльность	передано разработчику	\N
31	$2	\N	1	1	1	\N	$1	$4	$5	$8	\N	\N
32		\N	1	1	1	\N	+1234567890	example@email.com			\N	\N
33		\N	1	1	1	\N	+1234567890	example@email.com			\N	\N
34	Новая задача	\N	2	1	1	\N	9951731743	pyotr_gorbunov_01@mail.ru	zxcczxczxc		\N	\N
35	Новая задача	\N	4	1	1	\N	9951731743	pyotr_gorbunov_01@mail.ru	MaxBonus		\N	\N
36	Новая задача	\N	5	1	1	\N	9951731743	pyotr_gorbunov_01@mail.ru	MaxBonus		\N	\N
37	Новая задача	\N	5	1	1	\N	9951731743	pyotr_gorbunov_01@mail.ru	MaxBonus		\N	\N
38	Новая задача	\N	5	1	1	\N	9951731743	pyotr_gorbunov_01@mail.ru	MaxBonus		\N	\N
39	Новая задача	\N	4	1	1	\N	9951731743	pyotr_gorbunov_01@mail.ru	MaxBonus		\N	\N
40	Новая задача	\N	4	1	1	\N	9951731743	pyotr_gorbunov_01@mail.ru	MaxBonus		\N	\N
41		\N	1	1	1	\N	+1234567890	example@email.com			test	\N
42		\N	1	1	1	\N	+1234567890	example@email.com			test	\N
43		\N	1	1	1	\N	+1234567890	example@email.com			test	\N
44		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
45		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
46		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
47		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
48		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
49		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
50		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
54		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
55		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
56		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
57		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
59		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
60		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
61		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
62		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
64		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
65		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
68		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
69		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
70		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
72		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
75		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
76		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
78		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
80		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
82		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
83		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
85		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
86		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
94		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
96		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
98		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
99		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
102		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
103		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
104		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
105		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
106		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
107		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
110		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
111		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
112		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
118		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
119		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
120		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
126		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
127		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
131		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
132		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
133		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
137		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
139		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
142		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
144		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
145		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
149		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
150		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
157		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
158		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
51		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
53		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
58		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
63		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
66		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
67		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
71		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
73		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
74		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
77		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
79		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
81		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
84		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
87		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
88		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
89		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
90		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
93		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
100		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
101		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
108		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
109		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
113		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
115		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
116		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
117		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
121		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
122		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
123		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
124		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
125		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
128		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
129		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
130		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
134		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
135		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
136		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
140		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
52		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
91		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
92		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
95		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
97		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
114		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
138		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
141		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
143		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
146		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
147		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
148		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
151		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
152		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
153		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
154		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
155		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
156		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
159		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2018		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2025		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2019		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2020		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2021		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2022		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2023		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2024		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2026		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2027		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2028		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2029		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2030		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2031		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2032		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2033		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2034		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2035		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2036		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2037		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2038		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2039		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2040		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2041		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2042		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2043		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
2044		\N	1	1	1	\N	+1234567890	example@email.com	Изменил название		test	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, login, password, "FIO") FROM stdin;
1	pyotr	63f6b4dd210e08712e3c759158bf83f409e2bad47154b30b694d8e8245b82491	Test
2	Manager	5b735a567f0cc6e62316be35748a7945e4cba158896a2e6ccbddaa2b208ad5fe	Анастасия
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id_user, id_roles, id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (idmum, login, password, s_name1, s_name2, s_name3, f_admin) FROM stdin;
\.


--
-- Name: board_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.board_id_seq', 1, true);


--
-- Name: reason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reason_id_seq', 7, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 4, true);


--
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_id_seq', 2044, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- Name: board board_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board
    ADD CONSTRAINT board_pkey PRIMARY KEY (id);


--
-- Name: reasonDescription reasonDescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reasonDescription"
    ADD CONSTRAINT "reasonDescription_pkey" PRIMARY KEY (id);


--
-- Name: reason_description reason_descriptiom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reason_description
    ADD CONSTRAINT reason_descriptiom_pkey PRIMARY KEY (id_reason);


--
-- Name: reason reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reason
    ADD CONSTRAINT reason_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: statusDescription statusDescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."statusDescription"
    ADD CONSTRAINT "statusDescription_pkey" PRIMARY KEY (id);


--
-- Name: status_description status_description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_description
    ADD CONSTRAINT status_description_pkey PRIMARY KEY (id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (idmum);


--
-- Name: board board_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board
    ADD CONSTRAINT board_id FOREIGN KEY ("userId") REFERENCES public."user"(id) NOT VALID;


--
-- Name: task board_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT board_task FOREIGN KEY (boardid) REFERENCES public.board(id) NOT VALID;


--
-- Name: reason_description descriptiom_reason; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reason_description
    ADD CONSTRAINT descriptiom_reason FOREIGN KEY (id_description) REFERENCES public."reasonDescription"(id) NOT VALID;


--
-- Name: status_description description_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_description
    ADD CONSTRAINT description_status FOREIGN KEY (id_description) REFERENCES public."statusDescription"(id) NOT VALID;


--
-- Name: reason_description reason_descriptiom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reason_description
    ADD CONSTRAINT reason_descriptiom FOREIGN KEY (id_reason) REFERENCES public.reason(id) NOT VALID;


--
-- Name: task reason_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT reason_task FOREIGN KEY (reasonid) REFERENCES public.reason(id) NOT VALID;


--
-- Name: user_roles roles_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT roles_user FOREIGN KEY (id_roles) REFERENCES public.roles(id) NOT VALID;


--
-- Name: status_description status_description; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_description
    ADD CONSTRAINT status_description FOREIGN KEY (id_status) REFERENCES public.status(id) NOT VALID;


--
-- Name: task status_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT status_task FOREIGN KEY (statusid) REFERENCES public.status(id) NOT VALID;


--
-- Name: user_roles user_roles; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles FOREIGN KEY (id_user) REFERENCES public."user"(id) NOT VALID;


--
-- Name: task user_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT user_task FOREIGN KEY (userid) REFERENCES public."user"(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

