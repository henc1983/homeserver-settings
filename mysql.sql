CREATE USER 'homeserver'@'localhost' IDENTIFIED BY 'Kangen1983';

GRANT ALL ON *.* TO 'homeserver'@'localhost';

CREATE DATABASE homeserver;

use homeserver;

CREATE TABLE temperature_sensors (
    device_id varchar(20) PRIMARY KEY UNIQUE,
    isAverage tinyint(1) DEFAULT 1,
);
CREATE TABLE devices (
    device_id varchar(20) PRIMARY KEY UNIQUE,
    slug varchar(100),
    name varchar(100),
    type varchar(20) DEFAULT "dht11"
    connection varchar(100) DEFAULT "mqtt",
    topic varchar(100),
    payload varchar(100),
    payload_type varchar(20) DEFAULT "object"
);

CREATE TABLE thermostat (
    name varchar(30) PRIMARY KEY UNIQUE,
    value FLOAT(10)
);
CREATE TABLE settings (
    name varchar(30) PRIMARY KEY UNIQUE,
    value varchar(150)
);
CREATE TABLE rooms (
    slug varchar(100) PRIMARY KEY UNIQUE,
    name varchar(150),
    devices varchar(255)
);
CREATE TABLE payload_types (
    name varchar(10) PRIMARY KEY UNIQUE
);
CREATE TABLE device_types (
    name varchar(10) PRIMARY KEY UNIQUE
);
CREATE TABLE connections (
    name varchar(10) PRIMARY KEY UNIQUE
);

INSERT INTO thermostat (name, value) VALUES ('temperature', 21.5);
INSERT INTO thermostat (name, value) VALUES ('eco', 1);
INSERT INTO thermostat (name, value) VALUES ('ambient_up_eco', 0.1);
INSERT INTO thermostat (name, value) VALUES ('ambient_down_eco', 0.3);
INSERT INTO thermostat (name, value) VALUES ('ambient_up', 0.2);
INSERT INTO thermostat (name, value) VALUES ('ambient_down', 0.2);

INSERT INTO settings (name, value) VALUES ('ui_theme', 'dark');


INSERT INTO payload_types (name) VALUES ('object');
INSERT INTO payload_types (name) VALUES ('string');
INSERT INTO payload_types (name) VALUES ('float');
INSERT INTO payload_types (name) VALUES ('integer');
INSERT INTO payload_types (name) VALUES ('array');

INSERT INTO device_types (name) VALUES ('analog_temp');
INSERT INTO device_types (name) VALUES ('dht11');
INSERT INTO device_types (name) VALUES ('dht22');
INSERT INTO device_types (name) VALUES ('relay');
INSERT INTO device_types (name) VALUES ('rgb');

INSERT INTO connections (name) VALUES ('mqtt');
INSERT INTO connections (name) VALUES ('http');
INSERT INTO connections (name) VALUES ('https');