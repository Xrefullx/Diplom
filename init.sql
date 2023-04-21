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
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    "nameStatus" text
);


ALTER TABLE public.status OWNER TO postgres;

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
    problem text
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
-- Data for Name: board; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.board (id, "userId", title, description) FROM stdin;
1	1	test	test
\.


--
-- Data for Name: reason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reason (id, "nameReason") FROM stdin;
1	test
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id, "nameStatus") FROM stdin;
1	Test
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task (id, title, userid, reasonid, boardid, statusid, icon, phone, email, companyname, problem) FROM stdin;
2	Новая задача	\N	1	\N	\N	\N	+1234567890	example@email.com	Example Company	Не работает
6	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
7	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
9	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
10	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
11	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
12	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
13	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
14	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
8	Новое название задачи	1	1	1	1	https://example.com/icon.png	+1234567890	user@example.com	Example Company	Не работает
15	New Handler	\N	1	1	1	\N	9951731743	example@email.com	TestCompany	Не работает
16	New Handler	\N	1	1	1	\N	9951731743	example@email.com	TestCompany	Не работает
17	New Handler	\N	1	1	1	\N	9951731743	example@email.com	TestCompany	Не работает
18	New Handler	\N	1	1	1	\N	9951731743	example@email.com	TestCompany	Не работает
19	New Handler	\N	1	1	1	\N	9951731743	example@email.com	TestCompany	Не работает
20	New Handler	\N	1	1	1	\N	9951731743	example@email.com	TestCompany	Не работает
21	New Handler	\N	1	1	1	\N	9951731743	example@email.com	TestCompany	Не работает
22	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
23	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
24	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
25	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Ксюша, ты прекрасна, это говорю я , бот	Не работает
5	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	Не работает
26	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	
27	Новая задача	\N	1	1	1	\N	+1234567890	example@email.com	Изменил название	
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, login, password, "FIO") FROM stdin;
1	pyotr	63f6b4dd210e08712e3c759158bf83f409e2bad47154b30b694d8e8245b82491	Test
\.


--
-- Name: board_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.board_id_seq', 1, true);


--
-- Name: reason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reason_id_seq', 1, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 1, true);


--
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_id_seq', 27, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: board board_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board
    ADD CONSTRAINT board_pkey PRIMARY KEY (id);


--
-- Name: reason reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reason
    ADD CONSTRAINT reason_pkey PRIMARY KEY (id);


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
-- Name: task reason_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT reason_task FOREIGN KEY (reasonid) REFERENCES public.reason(id) NOT VALID;


--
-- Name: task status_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT status_task FOREIGN KEY (statusid) REFERENCES public.status(id) NOT VALID;


--
-- Name: task user_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT user_task FOREIGN KEY (userid) REFERENCES public."user"(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

