DROP TABLE IF EXISTS review_assignment CASCADE;
DROP TABLE IF EXISTS reviewer_topic CASCADE;
DROP TABLE IF EXISTS reviewer CASCADE;
DROP TABLE IF EXISTS paper_author CASCADE;
DROP TABLE IF EXISTS paper CASCADE;
DROP TABLE IF EXISTS author CASCADE;

CREATE TABLE author (
    author_email VARCHAR(100) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE paper (
    paper_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    abstract TEXT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    contact_author_email VARCHAR(100) NOT NULL,
    CONSTRAINT fk_paper_contact_author FOREIGN KEY (contact_author_email) 
        REFERENCES author (author_email) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE paper_author (
    paper_id INT NOT NULL,
    author_email VARCHAR(100) NOT NULL,
    author_order INT NOT NULL DEFAULT 1,
    PRIMARY KEY (paper_id, author_email),
    CONSTRAINT fk_pa_paper FOREIGN KEY (paper_id) REFERENCES paper (paper_id) ON DELETE CASCADE,
    CONSTRAINT fk_pa_author FOREIGN KEY (author_email) REFERENCES author (author_email) ON DELETE CASCADE
);

CREATE TABLE reviewer (
    reviewer_email VARCHAR(100) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(30),
    affiliation VARCHAR(100)
);

CREATE TABLE reviewer_topic (
    reviewer_email VARCHAR(100) NOT NULL,
    topic VARCHAR(100) NOT NULL,
    PRIMARY KEY (reviewer_email, topic),
    CONSTRAINT fk_rt_reviewer FOREIGN KEY (reviewer_email) REFERENCES reviewer (reviewer_email) ON DELETE CASCADE
);

CREATE TABLE review_assignment (
    paper_id INT NOT NULL,
    reviewer_email VARCHAR(100) NOT NULL,
    technical_merit INT NOT NULL,
    readability INT NOT NULL,
    originality INT NOT NULL,
    relevance INT NOT NULL,
    overall_recommendation VARCHAR(30) NOT NULL,
    committee_comments TEXT,
    author_feedback TEXT,
    PRIMARY KEY (paper_id, reviewer_email),
    CONSTRAINT fk_ra_paper FOREIGN KEY (paper_id) REFERENCES paper (paper_id) ON DELETE CASCADE,
    CONSTRAINT fk_ra_reviewer FOREIGN KEY (reviewer_email) REFERENCES reviewer (reviewer_email) ON DELETE CASCADE,
    CONSTRAINT chk_tech_merit CHECK (technical_merit BETWEEN 1 AND 10),
    CONSTRAINT chk_readability CHECK (readability BETWEEN 1 AND 10),
    CONSTRAINT chk_originality CHECK (originality BETWEEN 1 AND 10),
    CONSTRAINT chk_relevance CHECK (relevance BETWEEN 1 AND 10),
    CONSTRAINT chk_recommendation CHECK (overall_recommendation IN ('Strong Accept', 'Accept', 'Weak Accept', 'Borderline', 'Weak Reject', 'Reject', 'Strong Reject'))
);

INSERT INTO author (author_email, first_name, last_name) VALUES
('alice@acm.org', 'Alice', 'Smith'),
('bob@ieee.org', 'Bob', 'Jones'),
('charlie@mit.edu', 'Charlie', 'Brown');

INSERT INTO paper (title, abstract, file_name, contact_author_email) VALUES
('Optimizing Query Plans in Distributed DB', 'This paper explores query optimization...', 'paper1_opt.pdf', 'alice@acm.org'),
('Deep Learning for Database Tuning', 'Automated indexing using RL...', 'paper2_tune.pdf', 'charlie@mit.edu');

INSERT INTO paper_author (paper_id, author_email, author_order) VALUES
(1, 'alice@acm.org', 1),
(1, 'bob@ieee.org', 2),
(2, 'charlie@mit.edu', 1);

INSERT INTO reviewer (reviewer_email, first_name, last_name, phone_number, affiliation) VALUES
('rev1@stanford.edu', 'David', 'Clark', '+1-555-0101', 'Stanford University'),
('rev2@oxford.ac.uk', 'Elena', 'Rostova', '+44-20-7946-0958', 'Oxford University'),
('rev3@ntu.edu.sg', 'Feng', 'Wei', '+65-6790-5152', 'NTU Singapore');

INSERT INTO reviewer_topic (reviewer_email, topic) VALUES
('rev1@stanford.edu', 'Query Optimization'),
('rev1@stanford.edu', 'Relational Databases'),
('rev2@oxford.ac.uk', 'Machine Learning'),
('rev3@ntu.edu.sg', 'Distributed Systems');

INSERT INTO review_assignment (paper_id, reviewer_email, technical_merit, readability, originality, relevance, overall_recommendation, committee_comments, author_feedback) VALUES
(1, 'rev1@stanford.edu', 8, 9, 8, 9, 'Accept', 'Solid paper, good contribution.', 'Well-written paper with strong empirical validation.'),
(1, 'rev3@ntu.edu.sg', 7, 8, 7, 8, 'Accept', 'Interesting results for distributed scale.', 'Please expand the benchmark section.'),
(2, 'rev2@oxford.ac.uk', 9, 9, 9, 10, 'Strong Accept', 'Very novel approach to index tuning.', 'Excellent novelty and presentation.');
