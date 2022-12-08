--
-- PostgreSQL database cluster dump
--

-- Started on 2022-12-05 23:13:49 CET

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:x3d7da1ipPxOEb+l73zyrw==$qI6sxJjYJURmWc2Uk4ZmkplxCsY19/lffxWKnu7KVM0=:yNI51b6yBMLIUF16xqzR4jm+AS+Qu3Jnqj7B/4W/pfA=';
CREATE ROLE randuser;
ALTER ROLE randuser WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS;

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2022-12-05 23:13:49 CET

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

-- Completed on 2022-12-05 23:13:49 CET

--
-- PostgreSQL database dump complete
--

--
-- Database "cldb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2022-12-05 23:13:49 CET

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
-- TOC entry 3626 (class 1262 OID 16557)
-- Name: cldb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE cldb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE cldb OWNER TO postgres;

\connect cldb

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
-- TOC entry 6 (class 2615 OID 16559)
-- Name: co-living; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "co-living";


ALTER SCHEMA "co-living" OWNER TO postgres;

--
-- TOC entry 856 (class 1247 OID 16574)
-- Name: address; Type: DOMAIN; Schema: co-living; Owner: postgres
--

CREATE DOMAIN "co-living".address AS character varying(256) NOT NULL
	CONSTRAINT proper_addess CHECK (((VALUE)::text ~* '^[A-Za-z0-9. ]+$'::text));


ALTER DOMAIN "co-living".address OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 16606)
-- Name: amenities; Type: TYPE; Schema: co-living; Owner: postgres
--

CREATE TYPE "co-living".amenities AS ENUM (
    'dishwasher',
    'washing machine',
    'iron',
    'microwave',
    'oven',
    'dryer',
    'drying rack'
);


ALTER TYPE "co-living".amenities OWNER TO postgres;

--
-- TOC entry 844 (class 1247 OID 16565)
-- Name: email; Type: DOMAIN; Schema: co-living; Owner: postgres
--

CREATE DOMAIN "co-living".email AS character varying(256)
	CONSTRAINT properemail CHECK (((VALUE)::text ~* '^[A-Za-z0-9._%]+@[A-Za-z0-9.]+[.][A-Za-z]+$'::text));


ALTER DOMAIN "co-living".email OWNER TO postgres;

--
-- TOC entry 840 (class 1247 OID 16561)
-- Name: password; Type: DOMAIN; Schema: co-living; Owner: postgres
--

CREATE DOMAIN "co-living".password AS character varying(256)
	CONSTRAINT properpassword CHECK (((VALUE)::text ~* '[A-Za-z0-9._%!]{8,}'::text));


ALTER DOMAIN "co-living".password OWNER TO postgres;

--
-- TOC entry 852 (class 1247 OID 16571)
-- Name: phone_number; Type: DOMAIN; Schema: co-living; Owner: postgres
--

CREATE DOMAIN "co-living".phone_number AS character varying(15) NOT NULL
	CONSTRAINT proper_phone CHECK (((VALUE)::text ~* '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'::text));


ALTER DOMAIN "co-living".phone_number OWNER TO postgres;

--
-- TOC entry 850 (class 1247 OID 16568)
-- Name: serialID; Type: DOMAIN; Schema: co-living; Owner: postgres
--

CREATE DOMAIN "co-living"."serialID" AS character varying NOT NULL
	CONSTRAINT proper_serial_id CHECK (((VALUE)::text ~* '[A-Z]{3}[0-9]{7}'::text));


ALTER DOMAIN "co-living"."serialID" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16590)
-- Name: common_space; Type: TABLE; Schema: co-living; Owner: postgres
--

CREATE TABLE "co-living".common_space (
    name character varying(256) NOT NULL,
    "co-living_address" "co-living".address NOT NULL
);


ALTER TABLE "co-living".common_space OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16583)
-- Name: event; Type: TABLE; Schema: co-living; Owner: postgres
--

CREATE TABLE "co-living".event (
    name character varying(256) NOT NULL,
    date date,
    "time" time with time zone,
    duration integer,
    max_tenants integer,
    max_guests integer,
    common_space_name character varying(256),
    "co-living_addess" "co-living".address
);


ALTER TABLE "co-living".event OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16576)
-- Name: sponsor; Type: TABLE; Schema: co-living; Owner: postgres
--

CREATE TABLE "co-living".sponsor (
    parner_addess "co-living".address NOT NULL,
    partner_name character varying(50) NOT NULL,
    event_name character varying(50) NOT NULL
);


ALTER TABLE "co-living".sponsor OWNER TO postgres;

--
-- TOC entry 3620 (class 0 OID 16590)
-- Dependencies: 217
-- Data for Name: common_space; Type: TABLE DATA; Schema: co-living; Owner: postgres
--

COPY "co-living".common_space (name, "co-living_address") FROM stdin;
\.


--
-- TOC entry 3619 (class 0 OID 16583)
-- Dependencies: 216
-- Data for Name: event; Type: TABLE DATA; Schema: co-living; Owner: postgres
--

COPY "co-living".event (name, date, "time", duration, max_tenants, max_guests, common_space_name, "co-living_addess") FROM stdin;
\.


--
-- TOC entry 3618 (class 0 OID 16576)
-- Dependencies: 215
-- Data for Name: sponsor; Type: TABLE DATA; Schema: co-living; Owner: postgres
--

COPY "co-living".sponsor (parner_addess, partner_name, event_name) FROM stdin;
\.


--
-- TOC entry 3475 (class 2606 OID 16596)
-- Name: common_space common_space_pkey; Type: CONSTRAINT; Schema: co-living; Owner: postgres
--

ALTER TABLE ONLY "co-living".common_space
    ADD CONSTRAINT common_space_pkey PRIMARY KEY (name, "co-living_address");


--
-- TOC entry 3473 (class 2606 OID 16589)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: co-living; Owner: postgres
--

ALTER TABLE ONLY "co-living".event
    ADD CONSTRAINT event_pkey PRIMARY KEY (name);


--
-- TOC entry 3471 (class 2606 OID 16582)
-- Name: sponsor sponsor_pkey; Type: CONSTRAINT; Schema: co-living; Owner: postgres
--

ALTER TABLE ONLY "co-living".sponsor
    ADD CONSTRAINT sponsor_pkey PRIMARY KEY (parner_addess, partner_name, event_name);


-- Completed on 2022-12-05 23:13:50 CET

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2022-12-05 23:13:50 CET

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
-- TOC entry 8 (class 2615 OID 16398)
-- Name: pgagent; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pgagent;


ALTER SCHEMA pgagent OWNER TO postgres;

--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA pgagent; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 3 (class 3079 OID 16399)
-- Name: pgagent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgagent WITH SCHEMA pgagent;


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pgagent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgagent IS 'A PostgreSQL job scheduler';


--
-- TOC entry 3482 (class 0 OID 16400)
-- Dependencies: 217
-- Data for Name: pga_jobagent; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobagent (jagpid, jaglogintime, jagstation) FROM stdin;
\.


--
-- TOC entry 3483 (class 0 OID 16409)
-- Dependencies: 219
-- Data for Name: pga_jobclass; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobclass (jclid, jclname) FROM stdin;
\.


--
-- TOC entry 3484 (class 0 OID 16419)
-- Dependencies: 221
-- Data for Name: pga_job; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobhostagent, jobenabled, jobcreated, jobchanged, jobagentid, jobnextrun, joblastrun) FROM stdin;
\.


--
-- TOC entry 3486 (class 0 OID 16467)
-- Dependencies: 225
-- Data for Name: pga_schedule; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths) FROM stdin;
\.


--
-- TOC entry 3487 (class 0 OID 16495)
-- Dependencies: 227
-- Data for Name: pga_exception; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_exception (jexid, jexscid, jexdate, jextime) FROM stdin;
\.


--
-- TOC entry 3488 (class 0 OID 16509)
-- Dependencies: 229
-- Data for Name: pga_joblog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_joblog (jlgid, jlgjobid, jlgstatus, jlgstart, jlgduration) FROM stdin;
\.


--
-- TOC entry 3485 (class 0 OID 16443)
-- Dependencies: 223
-- Data for Name: pga_jobstep; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstcode, jstconnstr, jstdbname, jstonerror, jscnextrun) FROM stdin;
\.


--
-- TOC entry 3489 (class 0 OID 16525)
-- Dependencies: 231
-- Data for Name: pga_jobsteplog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobsteplog (jslid, jsljlgid, jsljstid, jslstatus, jslresult, jslstart, jslduration, jsloutput) FROM stdin;
\.


-- Completed on 2022-12-05 23:13:50 CET

--
-- PostgreSQL database dump complete
--

-- Completed on 2022-12-05 23:13:50 CET

--
-- PostgreSQL database cluster dump complete
--

