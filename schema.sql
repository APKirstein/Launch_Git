-- stack_table schema
-- Github URLS/Secure list

DROP TABLE urls;
DROP TABLE users;
DROP TABLE secure_users;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  name VARCHAR(1020) UNIQUE NOT NULL
);

CREATE TABLE urls(
  id SERIAL PRIMARY KEY,
  url VARCHAR(1020),
  user_id INT REFERENCES users(id)
);

CREATE TABLE secure_users(
  users_id INT REFERENCES users(id),
  secure_list VARCHAR(1020) UNIQUE NOT NULL
);
psql launch_
