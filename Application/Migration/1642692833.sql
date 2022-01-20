CREATE TABLE devices (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    token TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    pairing_code TEXT DEFAULT null
);
ALTER TABLE devices ADD CONSTRAINT devices_pairing_code_key UNIQUE(pairing_code);
