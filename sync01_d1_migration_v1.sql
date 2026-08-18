-- SECURE ENTRY - DELIVERY SENSORY
-- SYNC-01 D1 MIGRATION (ADDITIVE / ROLLBACK-SAFE WITH WORKER v3)
-- Run these statements ONCE before deploying index_worker_delivery_v4.txt.

ALTER TABLE entries ADD COLUMN sync_lease_token TEXT;
ALTER TABLE entries ADD COLUMN sync_lease_until TEXT;

-- Verification (read-only):
PRAGMA table_info(entries);
