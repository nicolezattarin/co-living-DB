SET client_encoding = 'UTF8';

-- Name: co-living; Type: SCHEMA; Schema: -; Owner: postgres
DROP SCHEMA IF EXISTS  co_living CASCADE;
CREATE SCHEMA co_living;
ALTER SCHEMA co_living OWNER TO postgres;

/**************************************************************************
                        DOMAIN DEFINITIONS
**************************************************************************/

-- Name: address; Type: DOMAIN; Schema: co-living; Owner: postgres
-- addesses can be very different according to where they are located,
-- so we can decide if we want to keep this domain or not

CREATE DOMAIN co_living.address AS character varying(256) NOT NULL
    --street name, number, city, zip code, province, country
    CONSTRAINT address_check CHECK (((VALUE)::text ~* "^[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*$"::text));
    CONSTRAINT street_check CHECK (((VALUE)::text ~* "^[^,]*" in ('[A-Za-z0-9 ]{1,50}') ::text));
    CONSTRAINT number_check CHECK (((VALUE)::text ~* "^[^,]*" in ('[0-9]{1,5}') ::text));
    CONSTRAINT city_check CHECK (((VALUE)::text ~* "^[^,]*" in ('[A-Za-z0-9 ]{1,50}') ::text));
    CONSTRAINT zip_check CHECK (((VALUE)::text ~* "^[^,]*" in ('[0-9]{5}') ::text));
    CONSTRAINT province_check CHECK (((VALUE)::text ~* "^[^,]*" in ('[A-Za-z0-9 ]{1,50}') ::text));
    CONSTRAINT country_check CHECK (((VALUE)::text ~* "^[^,]*" in ('[A-Za-z0-9 ]{1,50}') ::text));

-- Name: email; Type: DOMAIN; Schema: co-living; Owner: postgres
CREATE DOMAIN co_living.email AS character varying(256)
	CONSTRAINT properemail CHECK (((VALUE)::text ~* '^[A-Za-z0-9._%]+@[A-Za-z0-9.]+[.][A-Za-z]+$'::text));

-- Name: password; Type: DOMAIN; Schema: co-living; Owner: postgres
CREATE DOMAIN co_living.password AS character varying(256)
	CONSTRAINT properpassword CHECK (((VALUE)::text ~* '[A-Za-z0-9._%!]{8,}'::text));

-- Name: phone_number; Type: DOMAIN; Schema: co-living; Owner: postgres
CREATE DOMAIN co_living.phone_number AS character varying(15) NOT NULL
	CONSTRAINT proper_phone CHECK (((VALUE)::text ~* '[+][0-9]{2}[0-9]{9}'::text));

-- Name: serialID; Type: DOMAIN; Schema: co-living; Owner: postgres
CREATE DOMAIN co_living."serialID" AS character varying (10) NOT NULL
	CONSTRAINT proper_serial_id CHECK (((VALUE)::text ~* '[A-Z]{3}[0-9]{7}'::text));

-- Name: ID; Type: DOMAIN; Schema: co-living; Owner: postgres
-- (kind_of_doc, number)
CREATE DOMAIN co_living.ID AS character varying(256) NOT NULL
    -- must have a comma in between
    CONSTRAINT comma_check CHECK (((VALUE)::text ~* "^[^,]*,[^,]*$"::text));
    CONSTRAINT id_type_check CHECK (((VALUE)::text ~* "^[^,]*" in ('passport', 'id card', 'driving license', 'health card') ::text));
    CONSTRAINT id_number_check CHECK (((VALUE)::text ~* "^[^,]*" in ('[A-Z]{2}[0-9]{7}', '[0-9]{9}', '[A-Z]{2}[0-9]{6}', '[0-9]{10}') ::text));

-- Name: income_info; Type: DOMAIN; Schema: co-living; Owner: postgres
CREATE DOMAIN co_living.income_info AS character varying(256)
    -- annual net income
    CONSTRAINT annual_income_check CHECK (((VALUE)::text ~* "^[0-9]*$"::text));

-- Name: bank information; Type: DOMAIN; Schema: co-living; Owner: postgres
CREATE DOMAIN co_living.bank_info AS character varying(256)
    -- IBAN 
    CONSTRAINT iban_check CHECK (((VALUE)::text ~* "^[A-Z]{2}[0-9]{2}[A-Z0-9]{4}[0-9]{7}([A-Z0-9]?){0,16}$"::text));


/**************************************************************************
                        TYPES DEFINITION
**************************************************************************/

-- Name: amenities; Type: TYPE; Schema: co-living; Owner: postgres
CREATE TYPE co_living.amenities AS ENUM (
    'dishwasher',
    'washing machine',
    'iron',
    'microwave',
    'oven',
    'dryer',
    'drying rack',
    'wifi',
    'tv',
    'air conditioning',
    'heating',
    'balcony',
    'parking',
    'elevator',
);

-- Name: facilities; Type: TYPE; Schema: co-living; Owner: postgres
CREATE TYPE co_living.facilities AS ENUM (
    'gym',
    'pool',
    'sauna',
    'jacuzzi',
    'barbecue',
    'garden',
    'terrace',
    'library',
    'cinema',
    'games room',
    'playground',
    'parking',
    'elevator',
);

-- Name: common space type; Type: TYPE; Schema: co-living; Owner: postgres
CREATE TYPE co_living.common_space_type AS ENUM (
    'kitchen',
    'living room',
    'dining room',
    'garden',
    'hallway',
);
 
-- Name: type of room; Type: TYPE; Schema: co-living; Owner: postgres
CREATE TYPE co_living.offer_type AS ENUM (
    'standard',
    'premium',
);

-- Name: provided service; Type: TYPE; Schema: co-living; Owner: postgres
CREATE TYPE co_living.provided_service AS ENUM (
    'groceries',
    'transport',
    'babysitting',
    'petsitting',
    'car rental',
    'bike rental',
    'airport shuttle',
    'party planning',
    'catering',
);

/**************************************************************************
                            TABLES DEFINITION
**************************************************************************/

-- Name: common_space; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.common_space (
    common_space_name character co_living.common_space_type NOT NULL,           -- name of the common space
    co_living_addess co_living.address NOT NULL,    -- address of the co-living (external id)

    PRIMARY KEY (common_space_name, co_living_addess);
    FOREIGN KEY (co_living_addess) REFERENCES co_living.co_living(addess)
);

-- Name: event; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.event (
    event_name character varying(256),                            -- name of the event
    event_date date NOT NULL,                               -- date of the event
    starting_time time with time zone,                      -- time of the event (time with time zone)
    duration integer,                                       -- duration of the event (in minutes)
    max_tenants integer,                                    -- max number of tenants    
    max_guests integer,                                     -- max number of guests
    common_space_name co_living.common_space_type,          -- name of the common space
    co_living_addess co_living.address,                     -- address of the co-living (external id)

    PRIMARY KEY (event_name)
    FOREIGN KEY (common_space_name, co_living_address) REFERENCES co_living.common_space(common_space_name, co_living_addess)
);

-- Name: participation as guest ; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.guest_participation (
    event_name character varying(256) NOT NULL,         -- name of the event 
    guest_id co_living.ID NOT NULL,                     -- id of the guest 

    PRIMARY KEY (event_name, guest_id)
    FOREIGN KEY (event_name) REFERENCES co_living.event(event_name)
    FOREIGN KEY (guest_id) REFERENCES co_living.guest(guest_id)
);

-- Name: participation ; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.participation (
    event_name character varying(256) NOT NULL,         -- name of the event 
    tenant_id co_living."serialID" NOT NULL,            -- id of the tenant 

    PRIMARY KEY (event_name, tenant_id)
    FOREIGN KEY (event_name) REFERENCES co_living.event(event_name)
    FOREIGN KEY (tenant_id) REFERENCES co_living.tenant(tenant_id)
);

-- Name: sponsor; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.sponsor (
    parner_addess co_living.address NOT NULL,            -- address of the partner (external id)
    partner_name character varying(50) NOT NULL,         -- name of the partner
    event_name character varying(50) NOT NULL,           -- name of the event (external id)

    PRIMARY KEY (parner_addess, partner_name, event_name)
    FOREIGN KEY (parner_addess, partner_name) REFERENCES co_living.partner(partner_address, partner_name)
    FOREIGN KEY (event_name) REFERENCES co_living.event(event_name)
);

-- Name: partner; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.partner (
    partner_address co_living.address NOT NULL,               -- address of the partner
    partner_name character varying(50) NOT NULL,              -- name of the partner
    provided_services co_living.provided_service,             -- services provided by the partner

    PRIMARY KEY (partner_address, partner_name)
);

-- Name: partnership; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.partnership (
    partner_address co_living.address  NOT NULL,       -- address of the partner (external id)
    partner_name character varying(50) NOT NULL,       -- name of the partner (external id)
    co_living_address co_living.address NOT NULL,      -- address of the co-living (external id)

    PRIMARY KEY (partner_address, partner_name, co_living_address)
    FOREIGN KEY (partner_address, partner_name) REFERENCES co_living.partner(partner_address, partner_name)
    FOREIGN KEY (co_living_address) REFERENCES co_living.co_living(co_living_address)
);

-- Name: Manager; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.manager (
    manager_id co_living.ID NOT NULL,                   -- id of the manager
    manager_name character varying(50) NOT NULL,        -- name of the manager
    manager_surmane character varying(50) NOT NULL,     -- surname of the manager
    manager_phone co_living.phone_number NOT NULL,      -- phone number of the manager
    manager_email character varying(50) NOT NULL,       -- email of the manager

    PRIMARY KEY (manager_id)
);

-- Name: organize; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.organize (
    event_name character varying(256) NOT NULL,         -- name of the event (external id)
    manager_id co_living.ID NOT NULL,                   -- id of the manager (external id)

    PRIMARY KEY (event_name, manager_id)
    FOREIGN KEY (event_name) REFERENCES co_living.event(event_name)
    FOREIGN KEY (manager_id) REFERENCES co_living.manager(manager_id)
);

-- Name: co-living; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.co_living (
    co_living_address co_living.address NOT NULL,       -- address of the co-living
    emergency_contacts co_living.phone_number[],          -- emergency contacts 
    amenities co_living.amenities[],                      -- amenities 
    facilities co_living.facilities[],                    -- facilities (list)
    manager_id co_living.ID NOT NULL,                   -- id of the manager

    PRIMARY KEY (co_living_address)
    FOREIGN KEY (manager_id) REFERENCES co_living.manager(manager_id)
);

-- Name: cleaning schedule; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.cleaning_schedule (
    common_space_name co_living.common_space_type NOT NULL,     -- name of the common space
    co_living_addess co_living.address NOT NULL,                -- address of the co-living (external id)
    week_day character varying(10),                             -- day of the week
    start_time time with time zone,                             -- time of the cleaning (time with time zone)
    duration integer,                                           -- duration of the cleaning (in minutes)

    PRIMARY KEY (common_space_name, co_living_addess)
    FOREIGN KEY (common_space_name, co_living_addess) REFERENCES co_living.common_space(common_space_name, co_living_addess)
);

-- Name: room; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.room (
    co_living_addess co_living.address NOT NULL,                -- address of the co-living (external id)
    room_number integer NOT NULL,                               -- number of the room
    room_type character varying(50),                            -- type of the room

    PRIMARY KEY (co_living_addess, room_number)
    FOREIGN KEY (co_living_addess) REFERENCES co_living.co_living(co_living_address)
);

-- Name: standard_queue; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.standard_queue (
    co_living_addess co_living.address NOT NULL,                    -- address of the co-living (external id)
    room_number integer,                                            -- number of the room
    applicant_id  co_living.ID NOT NULL,                             -- id of the tenant
    entry_time timestamp with time zone NOT NULL,                    -- time of the entry in the queue

    PRIMARY KEY (co_living_addess, room_number, applicant_id)
    FOREIGN KEY (co_living_addess, room_number) REFERENCES co_living.room(co_living_addess, room_number)
    FOREIGN KEY (applicant_id) REFERENCES co_living.applicant(applicant_id)
);

-- Name: priority-queue; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.priority_queue (
    co_living_addess co_living.address NOT NULL,                    -- address of the co-living (external id)
    room_number integer,                                            -- number of the room
    applicant_id  co_living.ID NOT NULL,                            -- id of the tenant
    entry_time timestamp with time zone NOT NULL,                   -- time of the entry in the queue

    PRIMARY KEY (co_living_addess, room_number, applicant_id)
    FOREIGN KEY (co_living_addess, room_number) REFERENCES co_living.room(co_living_addess, room_number)
    FOREIGN KEY (applicant_id) REFERENCES co_living.applicant(applicant_id)
);

-- Name: applicant; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.applicant (
    applicant_id  co_living.ID NOT NULL,                  -- id of the applicant
    applicant_name character varying(50) NOT NULL,        -- name of the applicant
    surname character varying(50) NOT NULL,               -- surname of the applicant
    email co_living.email NOT NULL,                       -- email of the applicant
    income_info co_living.income_info NOT NULL,           -- income info of the applicant
    accepted boolean NOT NULL,                            -- if the applicant has been accepted

    PRIMARY KEY (applicant_id)
);

-- -- Name: form; Type: TABLE; Schema: co-living; Owner: postgres
-- CREATE TABLE co_living.form (
--     applicant_id  co_living.ID NOT NULL,                 -- id of the applicant
--     co_living_addess co_living.address NOT NULL,        -- address of the co-living (external id)
--     room_number integer,                                -- number of the room
--     form_number integer NOT NULL,                       -- number of the form

--     PRIMARY KEY (form_number)
--     FOREIGN KEY (applicant_id) REFERENCES co_living.applicant(applicant_id)
--     FOREIGN KEY (co_living_addess) REFERENCES co_living.co_living(co_living_address)
-- );

-- Name: conytract; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.contract (
    contract_number integer NOT NULL,                       -- number of the contract
    applicant_id  co_living.ID NOT NULL,                 -- id of the applicant
    co_living_addess co_living.address NOT NULL,        -- address of the co-living (external id)
    room_number integer,                                -- number of the room
    tenant_id co_living.ID NOT NULL,                    -- id of the tenant
    offer_type co_living.offer_type NOT NULL,           -- type of the offer
    start_date date NOT NULL,                           -- start date of the contract
    end_date date NOT NULL,                             -- end date of the contract
    monthly_rent integer NOT NULL,                      -- monthly rent of the contract
    manager_id co_living.ID NOT NULL,                   -- id of the manager

    PRIMARY KEY (contract_number)
    FOREIGN KEY (applicant_id) REFERENCES co_living.applicant(applicant_id)
    FOREIGN KEY (co_living_addess) REFERENCES co_living.co_living(co_living_address)
    FOREIGN KEY (co_living_addess, room_number) REFERENCES co_living.room(co_living_addess, room_number)
    FOREIGN KEY (tenant_id) REFERENCES co_living.tenant(tenant_id)
    FOREIGN KEY (manager_id) REFERENCES co_living.manager(manager_id)
);

-- Name: tenant; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.tenant (
    tenant_id co_living.ID NOT NULL,                    -- id of the tenant
    tenant_name character varying(50) NOT NULL,         -- name of the tenant
    surname character varying(50) NOT NULL,             -- surname of the tenant
    username character varying(50) NOT NULL,            -- username of the tenant
    user_password  co_living.password NOT NULL,         -- password of the tenant
    profession character varying(50),                   -- profession of the tenant
    email co_living.email NOT NULL,                    -- email of the tenant
    bank_info co_living.bank_info NOT NULL,            -- bank info of the tenant
    phone_number co_living.phone_number,                -- phone number of the tenant
    nationality character varying(50),                  -- nationality        
    national_ID co_living.national_ID,                  -- national ID of the tenant

    PRIMARY KEY (tenant_id)
);

-- Name: guest; Type: TABLE; Schema: co-living; Owner: postgres
CREATE TABLE co_living.guest (
    guest_id co_living.ID NOT NULL,                     -- id of the guest
    tenant_id co_living.ID NOT NULL,                    -- id of the tenant
    guest_name character varying(50) NOT NULL,
    guest_surname character varying(50) NOT NULL,
    email co_living.email,                              
    phone_number co_living.phone_number                