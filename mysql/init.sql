CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'usrmoodle'@'localhost' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON moodle.* TO 'usrmoodle'@'localhost';
FLUSH PRIVILEGES;
EXIT;