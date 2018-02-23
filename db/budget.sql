DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;


CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transations (
  id SERIAL4 PRIMARY KEY,
  amount INT4,
  merchant_id INT4 REFERENCES merchants,
  tag_id INT4 REFERENCES tags
);
