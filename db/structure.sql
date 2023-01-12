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
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: inquiry_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.inquiry_status AS ENUM (
    'on_hold',
    'accepted',
    'rejected'
);


--
-- Name: job_payment; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.job_payment AS ENUM (
    'hourly_rate',
    'fixed_rate'
);


--
-- Name: job_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.job_status AS ENUM (
    'open',
    'close'
);


--
-- Name: project_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.project_status AS ENUM (
    'past',
    'upcoming'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_analytics_views_per_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_analytics_views_per_days (
    id bigint NOT NULL,
    site character varying NOT NULL,
    page character varying NOT NULL,
    date date NOT NULL,
    total bigint DEFAULT 1 NOT NULL,
    referrer_host character varying,
    referrer_path character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: active_analytics_views_per_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_analytics_views_per_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_analytics_views_per_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_analytics_views_per_days_id_seq OWNED BY public.active_analytics_views_per_days.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: chatrooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chatrooms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    author_id integer NOT NULL,
    receiver_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: collabs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collabs (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: collabs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.collabs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.collabs_id_seq OWNED BY public.collabs.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    title character varying,
    venue character varying,
    address character varying,
    date timestamp without time zone,
    organizer character varying,
    organizer_type character varying DEFAULT 'random'::character varying,
    genre character varying,
    attendees integer[] DEFAULT '{}'::integer[],
    description text,
    media text,
    recommended boolean DEFAULT false,
    slug character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: inquiries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inquiries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    experience text,
    motivation text,
    job_id uuid NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status public.inquiry_status DEFAULT 'on_hold'::public.inquiry_status
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying,
    location character varying,
    money integer,
    skills_needed character varying,
    description text,
    project_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    payment public.job_payment DEFAULT 'fixed_rate'::public.job_payment,
    status public.job_status DEFAULT 'open'::public.job_status
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    content character varying NOT NULL,
    anchor_id integer NOT NULL,
    read_by_receiver boolean DEFAULT false,
    chatroom_id uuid NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: mirrors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mirrors (
    id bigint NOT NULL,
    grid_x character varying,
    grid_y character varying,
    grid_h character varying,
    grid_w character varying,
    crop_x character varying,
    crop_y character varying,
    crop_h character varying,
    crop_w character varying,
    default_position integer,
    user_id bigint NOT NULL,
    project_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: mirrors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mirrors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mirrors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mirrors_id_seq OWNED BY public.mirrors.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    title character varying,
    description text,
    location character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category character varying,
    date timestamp without time zone,
    status public.project_status DEFAULT 'past'::public.project_status,
    slug character varying
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    bio text,
    skills character varying,
    slug character varying,
    username public.citext,
    title character varying,
    website character varying,
    facebook character varying,
    instagram character varying,
    soundcloud character varying,
    youtube character varying,
    mixcloud character varying,
    linkedin character varying,
    twitter character varying,
    admin boolean DEFAULT false NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_analytics_views_per_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_analytics_views_per_days ALTER COLUMN id SET DEFAULT nextval('public.active_analytics_views_per_days_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: collabs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collabs ALTER COLUMN id SET DEFAULT nextval('public.collabs_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: mirrors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mirrors ALTER COLUMN id SET DEFAULT nextval('public.mirrors_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: active_analytics_views_per_days active_analytics_views_per_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_analytics_views_per_days
    ADD CONSTRAINT active_analytics_views_per_days_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: chatrooms chatrooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chatrooms
    ADD CONSTRAINT chatrooms_pkey PRIMARY KEY (id);


--
-- Name: collabs collabs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collabs
    ADD CONSTRAINT collabs_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: inquiries inquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT inquiries_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: mirrors mirrors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mirrors
    ADD CONSTRAINT mirrors_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_analytics_views_per_days_on_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_analytics_views_per_days_on_date ON public.active_analytics_views_per_days USING btree (date);


--
-- Name: index_active_analytics_views_per_days_on_referrer_and_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_analytics_views_per_days_on_referrer_and_date ON public.active_analytics_views_per_days USING btree (referrer_host, referrer_path, date);


--
-- Name: index_active_analytics_views_per_days_on_site_and_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_analytics_views_per_days_on_site_and_date ON public.active_analytics_views_per_days USING btree (site, page, date);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_chatrooms_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chatrooms_on_author_id ON public.chatrooms USING btree (author_id);


--
-- Name: index_chatrooms_on_author_id_and_receiver_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_chatrooms_on_author_id_and_receiver_id ON public.chatrooms USING btree (author_id, receiver_id);


--
-- Name: index_chatrooms_on_receiver_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chatrooms_on_receiver_id ON public.chatrooms USING btree (receiver_id);


--
-- Name: index_chatrooms_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_chatrooms_on_updated_at ON public.chatrooms USING btree (updated_at);


--
-- Name: index_collabs_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collabs_on_project_id ON public.collabs USING btree (project_id);


--
-- Name: index_collabs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collabs_on_user_id ON public.collabs USING btree (user_id);


--
-- Name: index_inquiries_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inquiries_on_job_id ON public.inquiries USING btree (job_id);


--
-- Name: index_inquiries_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inquiries_on_status ON public.inquiries USING btree (status);


--
-- Name: index_inquiries_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inquiries_on_user_id ON public.inquiries USING btree (user_id);


--
-- Name: index_jobs_on_payment; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_payment ON public.jobs USING btree (payment);


--
-- Name: index_jobs_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_project_id ON public.jobs USING btree (project_id);


--
-- Name: index_jobs_on_skills_needed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_skills_needed ON public.jobs USING btree (skills_needed);


--
-- Name: index_jobs_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_status ON public.jobs USING btree (status);


--
-- Name: index_messages_on_anchor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_anchor_id ON public.messages USING btree (anchor_id);


--
-- Name: index_messages_on_chatroom_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_chatroom_id ON public.messages USING btree (chatroom_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_user_id ON public.messages USING btree (user_id);


--
-- Name: index_mirrors_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mirrors_on_project_id ON public.mirrors USING btree (project_id);


--
-- Name: index_mirrors_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mirrors_on_user_id ON public.mirrors USING btree (user_id);


--
-- Name: index_projects_on_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_category ON public.projects USING btree (category);


--
-- Name: index_projects_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_description ON public.projects USING btree (description);


--
-- Name: index_projects_on_location; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_location ON public.projects USING btree (location);


--
-- Name: index_projects_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_projects_on_slug ON public.projects USING btree (slug);


--
-- Name: index_projects_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_status ON public.projects USING btree (status);


--
-- Name: index_projects_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_projects_on_title ON public.projects USING btree (title);


--
-- Name: index_projects_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_user_id ON public.projects USING btree (user_id);


--
-- Name: index_users_on_bio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_bio ON public.users USING btree (bio);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_facebook; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_facebook ON public.users USING btree (facebook);


--
-- Name: index_users_on_instagram; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_instagram ON public.users USING btree (instagram);


--
-- Name: index_users_on_linkedin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_linkedin ON public.users USING btree (linkedin);


--
-- Name: index_users_on_mixcloud; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_mixcloud ON public.users USING btree (mixcloud);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_skills; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_skills ON public.users USING btree (skills);


--
-- Name: index_users_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_slug ON public.users USING btree (slug);


--
-- Name: index_users_on_soundcloud; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_soundcloud ON public.users USING btree (soundcloud);


--
-- Name: index_users_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_title ON public.users USING btree (title);


--
-- Name: index_users_on_twitter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_twitter ON public.users USING btree (twitter);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON public.users USING btree (username);


--
-- Name: index_users_on_website; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_website ON public.users USING btree (website);


--
-- Name: index_users_on_youtube; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_youtube ON public.users USING btree (youtube);


--
-- Name: messages_chatroom_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_chatroom_id_idx ON public.messages USING btree (chatroom_id);


--
-- Name: messages_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_user_id_idx ON public.messages USING btree (user_id);


--
-- Name: jobs fk_rails_1977e8b5a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT fk_rails_1977e8b5a6 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: collabs fk_rails_1b614bbf2a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collabs
    ADD CONSTRAINT fk_rails_1b614bbf2a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: collabs fk_rails_250a8a2ab4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collabs
    ADD CONSTRAINT fk_rails_250a8a2ab4 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: messages fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: mirrors fk_rails_4c43f43cd8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mirrors
    ADD CONSTRAINT fk_rails_4c43f43cd8 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: messages fk_rails_5d3b5a27f5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_5d3b5a27f5 FOREIGN KEY (chatroom_id) REFERENCES public.chatrooms(id);


--
-- Name: inquiries fk_rails_7fdff2c1ec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT fk_rails_7fdff2c1ec FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: projects fk_rails_b872a6760a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_b872a6760a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: mirrors fk_rails_df01aa8daa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mirrors
    ADD CONSTRAINT fk_rails_df01aa8daa FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: inquiries fk_rails_f3802824b9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT fk_rails_f3802824b9 FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210614095434'),
('20210614101222'),
('20210614101346'),
('20210614101943'),
('20210614102032'),
('20210614103757'),
('20210614104722'),
('20210614104944'),
('20210614105441'),
('20210614112356'),
('20210614113112'),
('20210616093735'),
('20210616094343'),
('20210920114449'),
('20210921095721'),
('20210921095837'),
('20211203141552'),
('20211223112000'),
('20211223112412'),
('20220119135430'),
('20220212110522'),
('20220212110617'),
('20220212110630'),
('20220212110642'),
('20220212110714'),
('20220212110731'),
('20220212110741'),
('20220212110751'),
('20220412221901'),
('20220917144447'),
('20221221160448'),
('20230112114901');


