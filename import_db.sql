PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER INTEGER NOT NULL,
    user_id INTEGER INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id) 

);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    parent_reply_id INTEGER,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id) 
);


INSERT INTO
    users (fname, lname)
VALUES
    ('Ned', 'N'), ('Kush', 'K') ;

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Ned Q', 'Ned body', (SELECT id FROM users WHERE fname = 'Ned' AND lname = 'N')),
    ('Kush Q', 'Kush body', (SELECT id FROM users WHERE fname = 'Kush' AND lname = 'K'));

INSERT INTO
    question_follows (question_id, user_id)
VALUES
    ((SELECT id FROM questions WHERE title = 'Kush Q' ),
    (SELECT id FROM users WHERE fname = 'Kush' AND lname = 'K'));

INSERT INTO
    question_follows (question_id, user_id)
VALUES
    ((SELECT id FROM questions WHERE title = 'Ned Q' ),
    (SELECT id FROM users WHERE fname = 'Ned' AND lname = 'N'));

INSERT INTO 
    replies (question_id, author_id, body, parent_reply_id)
VALUES 
    (
    (SELECT id FROM questions WHERE title = 'Ned Q' ),
    (SELECT id FROM users WHERE fname = 'Ned' AND lname = 'N' ),
    'SF Resturants',
    (NULL)
    );

INSERT INTO 
    replies (question_id, author_id, body, parent_reply_id)
VALUES
    (
        (SELECT id FROM questions WHERE title = 'Ned Q'),
        (SELECT id FROM users WHERE fname = 'Kush' AND lname = 'K'),
        'Dumpling Time',
        (SELECT id FROM replies WHERE body = 'SF Resturants')
    );

INSERT INTO
    question_likes (user_id, question_id)
VALUES
    (
        (SELECT id FROM users WHERE fname = 'Kush' AND lname = "K" ),
        (SELECT id FROM questions WHERE title = 'Ned Q')
    );