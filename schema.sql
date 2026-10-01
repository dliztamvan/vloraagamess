PRAGMA foreign_keys=ON;
CREATE TABLE IF NOT EXISTS users (
 id TEXT PRIMARY KEY, email TEXT UNIQUE NOT NULL, name TEXT NOT NULL, password_hash TEXT NOT NULL,
 role TEXT NOT NULL DEFAULT 'buyer', verified INTEGER NOT NULL DEFAULT 0, balance INTEGER NOT NULL DEFAULT 0,
 created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS sessions (token TEXT PRIMARY KEY, user_id TEXT NOT NULL, expires_at INTEGER NOT NULL);
CREATE TABLE IF NOT EXISTS products (
 id TEXT PRIMARY KEY, seller_id TEXT NOT NULL, title TEXT NOT NULL, game TEXT NOT NULL, description TEXT DEFAULT '',
 price INTEGER NOT NULL, active INTEGER NOT NULL DEFAULT 1, created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS transactions (
 id TEXT PRIMARY KEY, buyer_id TEXT NOT NULL, seller_id TEXT NOT NULL, product_id TEXT NOT NULL,
 title TEXT NOT NULL, price INTEGER NOT NULL, fee INTEGER NOT NULL, total INTEGER NOT NULL,
 status TEXT NOT NULL DEFAULT 'waiting_payment', created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS messages (
 id TEXT PRIMARY KEY, room_id TEXT NOT NULL, uid TEXT NOT NULL, name TEXT NOT NULL, role TEXT NOT NULL,
 text TEXT NOT NULL, created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS deliveries (
 transaction_id TEXT PRIMARY KEY, email TEXT NOT NULL, password_cipher TEXT NOT NULL, created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS withdrawals (
 id TEXT PRIMARY KEY, seller_id TEXT NOT NULL, amount INTEGER NOT NULL, method TEXT NOT NULL,
 destination TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'requested', created_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_products_active ON products(active);
CREATE INDEX IF NOT EXISTS idx_messages_room ON messages(room_id,created_at);
CREATE INDEX IF NOT EXISTS idx_tx_buyer ON transactions(buyer_id);
CREATE INDEX IF NOT EXISTS idx_tx_seller ON transactions(seller_id);
