ALTER TABLE devices ADD COLUMN refresh_token TEXT NOT NULL;
ALTER TABLE devices ADD CONSTRAINT devices_token_key UNIQUE(token);
ALTER TABLE devices ADD CONSTRAINT devices_refresh_token_key UNIQUE(refresh_token);
