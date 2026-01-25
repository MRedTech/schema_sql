-- D1 SCHEMA - Secure Entry
-- Run: wrangler d1 execute <DB_NAME> --file=./schema.sql

PRAGMA foreign_keys=OFF;

CREATE TABLE IF NOT EXISTS records_latest (
  primaryKey TEXT PRIMARY KEY,            -- "DOC:XXXX" or "REG:XXXX"
  name       TEXT,
  phone      TEXT,
  docNo      TEXT,
  regNo      TEXT,
  category   TEXT,
  tower      TEXT,
  unitNo     TEXT,

  photoId    TEXT,                        -- Drive fileId (latest)
  photoUrl   TEXT,                        -- Drive share URL (latest)
  photoUpdatedAt INTEGER,                 -- ms epoch

  createdAt  INTEGER NOT NULL,
  updatedAt  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS key_aliases (
  aliasKey   TEXT PRIMARY KEY,            -- "DOC:..." or "REG:..."
  primaryKey TEXT NOT NULL,               -- points to records_latest.primaryKey
  updatedAt  INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS visits_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  primaryKey TEXT NOT NULL,
  ts INTEGER NOT NULL,                    -- ms epoch
  purpose TEXT
);

CREATE TABLE IF NOT EXISTS photos (
  photoId    TEXT PRIMARY KEY,            -- Drive fileId
  primaryKey TEXT NOT NULL,               -- owner record
  createdAt  INTEGER NOT NULL,
  expiresAt  INTEGER NOT NULL,            -- ms epoch
  deletedAt  INTEGER
);

CREATE INDEX IF NOT EXISTS idx_visits_pk_ts ON visits_log(primaryKey, ts);
CREATE INDEX IF NOT EXISTS idx_photos_expires ON photos(expiresAt, deletedAt);
CREATE INDEX IF NOT EXISTS idx_records_updated ON records_latest(updatedAt);
