CREATE TABLE IF NOT EXISTS entries (
  id TEXT PRIMARY KEY,
  created_at TEXT NOT NULL,
  client_txn_id TEXT NOT NULL UNIQUE,
  device_id TEXT,

  name_passport TEXT,
  mykad_passport TEXT,
  regnum TEXT,
  contact TEXT,
  remark TEXT,

  unit_number TEXT,
  tower TEXT,
  reason TEXT,
  reason_other TEXT,

  reg_norm TEXT,
  id_norm TEXT,

  image_key TEXT,
  image_sha256 TEXT,

  drive_file_id TEXT,
  drive_url TEXT,

  sync_status TEXT,
  sync_attempts INTEGER,
  sync_error TEXT
);

=====================================
-- carian utama
CREATE INDEX IF NOT EXISTS idx_entries_reg_norm_created
  ON entries(reg_norm, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_entries_id_norm_created
  ON entries(id_norm, created_at DESC);

-- proof hyperlink (partial index untuk laju query drive_url)
CREATE INDEX IF NOT EXISTS idx_entries_reg_norm_proof
  ON entries(reg_norm, created_at DESC)
  WHERE drive_url IS NOT NULL AND drive_url <> '';

CREATE INDEX IF NOT EXISTS idx_entries_id_norm_proof
  ON entries(id_norm, created_at DESC)
  WHERE drive_url IS NOT NULL AND drive_url <> '';

-- cleanup retention
CREATE INDEX IF NOT EXISTS idx_entries_created_at
  ON entries(created_at);

===================================
CREATE INDEX IF NOT EXISTS idx_entries_reg_created ON entries(reg_norm, created_at);
CREATE INDEX IF NOT EXISTS idx_entries_id_created  ON entries(id_norm, created_at);

-- untuk proof lookup (drive_url)
CREATE INDEX IF NOT EXISTS idx_entries_reg_drive_created ON entries(reg_norm, drive_url, created_at);
CREATE INDEX IF NOT EXISTS idx_entries_id_drive_created  ON entries(id_norm, drive_url, created_at);


