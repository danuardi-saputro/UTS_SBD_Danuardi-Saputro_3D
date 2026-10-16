DROP TABLE IF EXISTS vote CASCADE;
DROP TABLE IF EXISTS bill_sponsor CASCADE;
DROP TABLE IF EXISTS bill CASCADE;
DROP TABLE IF EXISTS congress_person CASCADE;
DROP TABLE IF EXISTS state CASCADE;

CREATE TABLE state (
    state_name VARCHAR(50) PRIMARY KEY,
    region VARCHAR(20) NOT NULL,
    CONSTRAINT chk_state_region CHECK (region IN ('Northeast', 'Midwest', 'Southeast', 'Southwest', 'West'))
);

CREATE TABLE congress_person (
    congress_person_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    state_name VARCHAR(50) NOT NULL,
    district INT NOT NULL,
    start_date DATE NOT NULL,
    party VARCHAR(20) NOT NULL,
    CONSTRAINT fk_cp_state FOREIGN KEY (state_name) REFERENCES state (state_name) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_cp_party CHECK (party IN ('Republican', 'Democrat', 'Independent', 'Other'))
);

CREATE TABLE bill (
    bill_id SERIAL PRIMARY KEY,
    bill_name VARCHAR(150) NOT NULL UNIQUE,
    date_of_vote DATE NOT NULL,
    passed_or_failed VARCHAR(5) NOT NULL,
    CONSTRAINT chk_bill_passed CHECK (passed_or_failed IN ('Yes', 'No'))
);

CREATE TABLE bill_sponsor (
    bill_id INT NOT NULL,
    congress_person_id INT NOT NULL,
    PRIMARY KEY (bill_id, congress_person_id),
    CONSTRAINT fk_bs_bill FOREIGN KEY (bill_id) REFERENCES bill (bill_id) ON DELETE CASCADE,
    CONSTRAINT fk_bs_cp FOREIGN KEY (congress_person_id) REFERENCES congress_person (congress_person_id) ON DELETE CASCADE
);

CREATE TABLE vote (
    congress_person_id INT NOT NULL,
    bill_id INT NOT NULL,
    vote_cast VARCHAR(10) NOT NULL,
    PRIMARY KEY (congress_person_id, bill_id),
    CONSTRAINT fk_vote_cp FOREIGN KEY (congress_person_id) REFERENCES congress_person (congress_person_id) ON DELETE CASCADE,
    CONSTRAINT fk_vote_bill FOREIGN KEY (bill_id) REFERENCES bill (bill_id) ON DELETE CASCADE,
    CONSTRAINT chk_vote_cast CHECK (vote_cast IN ('Yes', 'No', 'Abstain', 'Absent'))
);

INSERT INTO state (state_name, region) VALUES
('California', 'West'),
('Texas', 'Southwest'),
('New York', 'Northeast');

INSERT INTO congress_person (name, state_name, district, start_date, party) VALUES
('Nancy Pelosi', 'California', 11, '1987-06-02', 'Democrat'),
('Kevin McCarthy', 'California', 20, '2007-01-03', 'Republican'),
('Ted Cruz', 'Texas', 1, '2013-01-03', 'Republican');

INSERT INTO bill (bill_name, date_of_vote, passed_or_failed) VALUES
('Infrastructure Investment and Jobs Act', '2021-11-05', 'Yes'),
('Clean Energy Development Bill', '2022-03-15', 'No');

INSERT INTO bill_sponsor (bill_id, congress_person_id) VALUES
(1, 1),
(2, 1);

INSERT INTO vote (congress_person_id, bill_id, vote_cast) VALUES
(1, 1, 'Yes'),
(2, 1, 'No'),
(3, 1, 'No'),
(1, 2, 'Yes'),
(2, 2, 'No'),
(3, 2, 'Abstain');
