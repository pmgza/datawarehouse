-- Script history for PostgreSQL
CREATE DATABASE datawarehouse;

\ connect datawarehouse CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER pmg_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    host '*****************************************',
    dbname 'pmg',
    port '5432'
);

CREATE SERVER pa_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    host '*****************************************',
    dbname 'pa_postgres_prod',
    port '5432'
);

CREATE USER MAPPING FOR current_user SERVER pmg_server OPTIONS (
    user 'pmg',
    password '*****************************************'
);

CREATE USER MAPPING FOR current_user SERVER pa_server OPTIONS (
    user 'postgres',
    password '*****************************************'
);

IMPORT FOREIGN SCHEMA public
LIMIT
    TO (member)
FROM
    SERVER pmg_server INTO public;

CREATE TYPE meeting_attendance_enum AS ENUM ('A', 'AP', 'DE', 'L', 'LDE', 'P', 'Y', 'U');

IMPORT FOREIGN SCHEMA public
LIMIT
    TO ("committee_meeting_attendance")
FROM
    SERVER pmg_server INTO public;

IMPORT FOREIGN SCHEMA public
LIMIT
    TO (core_identifier)
FROM
    SERVER pa_server INTO public;

IMPORT FOREIGN SCHEMA public
LIMIT
    TO (core_person)
FROM
    SERVER pa_server INTO public;

IMPORT FOREIGN SCHEMA public
LIMIT
    TO (core_position)
FROM
    SERVER pa_server INTO public;

IMPORT FOREIGN SCHEMA public
LIMIT
    TO (core_organisation)
FROM
    SERVER pa_server INTO public;

IMPORT FOREIGN SCHEMA public
LIMIT
    TO (core_organisationkind)
FROM
    SERVER pa_server INTO public;

-- Show all foreign tables
\ detr