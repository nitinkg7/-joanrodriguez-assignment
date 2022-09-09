SET check_function_bodies = false;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE TABLE public.long_tails (
    tail text NOT NULL,
    json_id integer NOT NULL
);
ALTER TABLE ONLY public.long_tails
    ADD CONSTRAINT long_tails_pkey PRIMARY KEY (json_id);
