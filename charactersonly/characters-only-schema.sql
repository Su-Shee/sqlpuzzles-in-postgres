-- psql -U postgres -d sqlpuzzles < characters-only-schema.sql

CREATE TABLE sometext (
  textdata TEXT NOT NULL,
    CONSTRAINT characters_only 
    CHECK (textdata ~* '^[a-zA-ZöäüßÖÄÜ]+$')
    -- CHECK (textdata SIMILAR TO...)
    -- \p{} would be interesting to grab all "Letters"
);


