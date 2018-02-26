DROP TABLE IF EXISTS budgets;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;


CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  dt DATE,
  amount INT4,
  merchant_id INT4 REFERENCES merchants ON DELETE CASCADE,
  tag_id INT4 REFERENCES tags ON DELETE CASCADE
);

CREATE TABLE budgets (
  id SERIAL4 PRIMARY KEY,
  amount INT4,
  tag_id INT4 UNIQUE REFERENCES tags ON DELETE CASCADE
);

CREATE INDEX indx_dates ON transactions (dt);
CREATE INDEX indx_dates_with_tags ON transactions (dt, tag_id);
