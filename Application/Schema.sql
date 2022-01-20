-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE devices (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    token TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    pairing_code TEXT DEFAULT NULL UNIQUE,
    refresh_token TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL UNIQUE
);
