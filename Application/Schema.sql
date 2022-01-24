-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE devices (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    token TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    pairing_code TEXT DEFAULT NULL UNIQUE,
    refresh_token TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL UNIQUE,
    enabled BOOLEAN DEFAULT true NOT NULL,
    last_used TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    numeric_id SERIAL NOT NULL UNIQUE
);
CREATE TABLE authorities (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE nurses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    pin_code TEXT NOT NULL UNIQUE
);
CREATE TABLE nurse_authority_refs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    nurse_id UUID NOT NULL,
    authority_id UUID NOT NULL
);
CREATE INDEX nurse_authority_refs_nurse_id_index ON nurse_authority_refs (nurse_id);
CREATE INDEX nurse_authority_refs_authority_id_index ON nurse_authority_refs (authority_id);
ALTER TABLE nurse_authority_refs ADD CONSTRAINT nurse_authority_refs_ref_authority_id FOREIGN KEY (authority_id) REFERENCES authorities (id) ON DELETE NO ACTION;
ALTER TABLE nurse_authority_refs ADD CONSTRAINT nurse_authority_refs_ref_nurse_id FOREIGN KEY (nurse_id) REFERENCES nurses (id) ON DELETE NO ACTION;
