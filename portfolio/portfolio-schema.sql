-- psql -U postgres -d sqlpuzzles < portfolio.sql

CREATE TABLE portfolios (
  id INTEGER UNIQUE NOT NULL,
  stuff TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE succession (
  chain INTEGER NOT NULL,
  next INTEGER NOT NULL DEFAULT 0 CHECK (next >= 0),
  date DATE NOT NULL,
  portfolio_id INTEGER NOT NULL REFERENCES portfolios(id),
  PRIMARY KEY (chain, next)
);

