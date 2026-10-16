-- =============================================================================
-- SOAL 3.35: AIRLINE DATABASE (Berdasarkan Gambar 3.21 Buku Elmasri)
-- DDL Script untuk PostgreSQL
-- =============================================================================

DROP TABLE IF EXISTS seat_reservation CASCADE;
DROP TABLE IF EXISTS leg_instance CASCADE;
DROP TABLE IF EXISTS flight_leg CASCADE;
DROP TABLE IF EXISTS fare CASCADE;
DROP TABLE IF EXISTS flight CASCADE;
DROP TABLE IF EXISTS airplane CASCADE;
DROP TABLE IF EXISTS can_land CASCADE;
DROP TABLE IF EXISTS airplane_type CASCADE;
DROP TABLE IF EXISTS airport CASCADE;

-- 1. Tabel AIRPORT
CREATE TABLE airport (
    airport_code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL
);

-- 2. Tabel AIRPLANE_TYPE
CREATE TABLE airplane_type (
    type_name VARCHAR(50) PRIMARY KEY,
    max_seats INT NOT NULL,
    company VARCHAR(50) NOT NULL
);

-- 3. Tabel CAN_LAND (Relasi M:N AIRPLANE_TYPE - AIRPORT)
CREATE TABLE can_land (
    type_name VARCHAR(50) NOT NULL,
    airport_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (type_name, airport_code),
    CONSTRAINT fk_cl_type FOREIGN KEY (type_name) REFERENCES airplane_type (type_name) ON DELETE CASCADE,
    CONSTRAINT fk_cl_airport FOREIGN KEY (airport_code) REFERENCES airport (airport_code) ON DELETE CASCADE
);

-- 4. Tabel AIRPLANE
CREATE TABLE airplane (
    airplane_id INT PRIMARY KEY,
    total_no_of_seats INT NOT NULL,
    type_name VARCHAR(50) NOT NULL,
    CONSTRAINT fk_plane_type FOREIGN KEY (type_name) REFERENCES airplane_type (type_name) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 5. Tabel FLIGHT
CREATE TABLE flight (
    flight_number VARCHAR(20) PRIMARY KEY,
    airline VARCHAR(50) NOT NULL,
    weekdays VARCHAR(50) NOT NULL
);

-- 6. Tabel FARE
CREATE TABLE fare (
    flight_number VARCHAR(20) NOT NULL,
    fare_code VARCHAR(20) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    restrictions VARCHAR(255),
    PRIMARY KEY (flight_number, fare_code),
    CONSTRAINT fk_fare_flight FOREIGN KEY (flight_number) REFERENCES flight (flight_number) ON DELETE CASCADE
);

-- 7. Tabel FLIGHT_LEG (Entitas Lemah dari FLIGHT)
CREATE TABLE flight_leg (
    flight_number VARCHAR(20) NOT NULL,
    leg_no INT NOT NULL,
    departure_airport_code VARCHAR(10) NOT NULL,
    arrival_airport_code VARCHAR(10) NOT NULL,
    scheduled_dep_time TIME NOT NULL,
    scheduled_arr_time TIME NOT NULL,
    PRIMARY KEY (flight_number, leg_no),
    CONSTRAINT fk_fl_flight FOREIGN KEY (flight_number) REFERENCES flight (flight_number) ON DELETE CASCADE,
    CONSTRAINT fk_fl_dep_airport FOREIGN KEY (departure_airport_code) REFERENCES airport (airport_code),
    CONSTRAINT fk_fl_arr_airport FOREIGN KEY (arrival_airport_code) REFERENCES airport (airport_code)
);

-- 8. Tabel LEG_INSTANCE (Instance dari FLIGHT_LEG pada tanggal tertentu)
CREATE TABLE leg_instance (
    flight_number VARCHAR(20) NOT NULL,
    leg_no INT NOT NULL,
    flight_date DATE NOT NULL,
    airplane_id INT,
    departure_airport_code VARCHAR(10) NOT NULL,
    arrival_airport_code VARCHAR(10) NOT NULL,
    dep_time TIME,
    arr_time TIME,
    no_of_avail_seats INT NOT NULL,
    PRIMARY KEY (flight_number, leg_no, flight_date),
    CONSTRAINT fk_li_leg FOREIGN KEY (flight_number, leg_no) 
        REFERENCES flight_leg (flight_number, leg_no) ON DELETE CASCADE,
    CONSTRAINT fk_li_plane FOREIGN KEY (airplane_id) REFERENCES airplane (airplane_id),
    CONSTRAINT fk_li_dep_airport FOREIGN KEY (departure_airport_code) REFERENCES airport (airport_code),
    CONSTRAINT fk_li_arr_airport FOREIGN KEY (arrival_airport_code) REFERENCES airport (airport_code)
);

-- 9. Tabel SEAT_RESERVATION (Reservasi tempat duduk pada suatu leg instance)
CREATE TABLE seat_reservation (
    flight_number VARCHAR(20) NOT NULL,
    leg_no INT NOT NULL,
    flight_date DATE NOT NULL,
    seat_no VARCHAR(10) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(30),
    PRIMARY KEY (flight_number, leg_no, flight_date, seat_no),
    CONSTRAINT fk_sr_instance FOREIGN KEY (flight_number, leg_no, flight_date)
        REFERENCES leg_instance (flight_number, leg_no, flight_date) ON DELETE CASCADE
);

-- SAMPLE DATA (Untuk pengujian)
INSERT INTO airport (airport_code, name, city, state) VALUES
('CGK', 'Soekarno-Hatta International Airport', 'Tangerang', 'Banten'),
('DPS', 'I Gusti Ngurah Rai International Airport', 'Denpasar', 'Bali'),
('SUB', 'Juanda International Airport', 'Surabaya', 'Jawa Timur');

INSERT INTO airplane_type (type_name, max_seats, company) VALUES
('Boeing 737-800', 189, 'Boeing'),
('Airbus A320-200', 180, 'Airbus');

INSERT INTO can_land (type_name, airport_code) VALUES
('Boeing 737-800', 'CGK'),
('Boeing 737-800', 'DPS'),
('Airbus A320-200', 'CGK'),
('Airbus A320-200', 'DPS'),
('Airbus A320-200', 'SUB');

INSERT INTO airplane (airplane_id, total_no_of_seats, type_name) VALUES
(101, 180, 'Airbus A320-200'),
(102, 189, 'Boeing 737-800');

INSERT INTO flight (flight_number, airline, weekdays) VALUES
('GA-402', 'Garuda Indonesia', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
('QZ-7510', 'AirAsia Indonesia', 'Mon,Wed,Fri,Sun');

INSERT INTO fare (flight_number, fare_code, amount, restrictions) VALUES
('GA-402', 'ECONOMY', 1500000.00, 'Non-refundable'),
('GA-402', 'BUSINESS', 3500000.00, 'Free reschedule'),
('QZ-7510', 'PROMO', 850000.00, 'Cabin baggage only');

INSERT INTO flight_leg (flight_number, leg_no, departure_airport_code, arrival_airport_code, scheduled_dep_time, scheduled_arr_time) VALUES
('GA-402', 1, 'CGK', 'DPS', '07:30:00', '10:20:00'),
('QZ-7510', 1, 'CGK', 'SUB', '09:00:00', '10:30:00');

INSERT INTO leg_instance (flight_number, leg_no, flight_date, airplane_id, departure_airport_code, arrival_airport_code, dep_time, arr_time, no_of_avail_seats) VALUES
('GA-402', 1, '2026-11-01', 101, 'CGK', 'DPS', '07:35:00', '10:25:00', 178),
('QZ-7510', 1, '2026-11-01', 102, 'CGK', 'SUB', '09:00:00', '10:30:00', 187);

INSERT INTO seat_reservation (flight_number, leg_no, flight_date, seat_no, customer_name, customer_phone) VALUES
('GA-402', 1, '2026-11-01', '12A', 'Danu Aryo', '081234567890'),
('GA-402', 1, '2026-11-01', '12B', 'Rizal Broer', '081298765432');
