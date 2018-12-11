DROP TABLE IF EXISTS question_follows; 
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions; 
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

INSERT INTO 
    users(fname, lname)
VALUES
    ('Eddard', 'Stark'), ('Arya', 'Stark'), ('Sansa', 'Stark');


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    
    FOREIGN KEY(author_id) REFERENCES users(id)
);
INSERT INTO
  questions (title, body, author_id)
SELECT
  "Ned Question", "NED NED NED", 1
FROM
  users
WHERE
  users.fname = "Eddard" AND users.lname = "Stark";

INSERT INTO
  questions (title, body, author_id)
SELECT
  "Arya Question", "test output", users.id
FROM
  users
WHERE
  users.fname = "Arya" AND users.lname = "Stark";

INSERT INTO
  questions (title, body, author_id)
SELECT
  "Sansa Question", "MEOW MEOW ", users.id
FROM
  users
WHERE
  users.fname = "Sansa" AND users.lname = "Stark";

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Eddard" AND lname = "Stark"),
  (SELECT id FROM questions WHERE title = "Ned Question")),

  ((SELECT id FROM users WHERE fname = "Arya" AND lname = "Stark"),
  (SELECT id FROM questions WHERE title = "Arya Question")
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    writer_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY(parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY(writer_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  replies (question_id, parent_reply_id, writer_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "Arya Question"),
  NULL,
  (SELECT id FROM users WHERE fname = "Eddard" AND lname = "Stark"),
  "Did you say NOW NOW NOW?"
);

INSERT INTO
  replies (question_id, parent_reply_id, writer_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "Sansa Question"),
  (SELECT id FROM replies WHERE body = "Did you say NOW NOW NOW?"),
  (SELECT id FROM users WHERE fname = "Sansa" AND lname = "Stark"),
  "I think she said MEOW MEOW MEOW."
);


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)

);


