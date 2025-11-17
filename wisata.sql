-- ==========================================================
--  CREATE DATABASE
-- ==========================================================
CREATE DATABASE IF NOT EXISTS db_wisata 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE db_wisata;

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================================
--  TABLE USERS
-- ==========================================================
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    nama_lengkap VARCHAR(100),
    foto_profil VARCHAR(255),
    ROLE ENUM('admin','user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=INNODB;

INSERT INTO users (username, `password`, nama_lengkap, ROLE, email, foto_profil) VALUES
('nabila', '12345', 'Nabila Putri Prasetyo', 'user', 'nabila@mail.com', 'https://example.com/nabila.jpg'),
('alif', '12345', 'Alif Firdaus Mulyanto', 'user', 'alif@mail.com', 'https://example.com/alif.jpg'),
('yunita', '12345', 'Yunita Putri Aurel', 'admin', 'yunita@mail.com', 'https://example.com/yunita.jpg'),
('andika', '12345', 'Andika Pratama', 'user', 'andika@mail.com', 'https://example.com/andika.jpg'),
('bunga', '12345', 'Bunga Sari', 'user', 'bunga@mail.com', 'https://example.com/bunga.jpg');

-- ==========================================================
--  TABLE KATEGORI
-- ==========================================================
DROP TABLE IF EXISTS kategori;

CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    icon VARCHAR(255)
) ENGINE=INNODB;

INSERT INTO kategori (nama_kategori, deskripsi, icon) VALUES
('Wisata Alam', 'Wisata yang menawarkan keindahan alam.', 'https://example.com/icon-alam.png'),
('Wisata Rekreasi', 'Tempat rekreasi keluarga.', 'https://example.com/icon-rekreasi.png'),
('Wisata Edukasi', 'Wisata yang bersifat edukatif.', 'https://example.com/icon-edukasi.png'),
('Wisata Sejarah Nusantara', 'Tempat bersejarah dan budaya.', 'https://example.com/icon-sejarah.png'),
('Wisata Kuliner', 'Wisata kuliner dan makanan khas.', 'https://example.com/icon-kuliner.png'),
('Wisata Petualangan', 'Wisata yang menantang adrenalin', 'https://example.com/icon-petualangan.png');

-- ==========================================================
--  TABLE WISATA
-- ==========================================================
DROP TABLE IF EXISTS wisata;

CREATE TABLE wisata (
    id_wisata INT AUTO_INCREMENT PRIMARY KEY,
    tanggal_input DATE NOT NULL,
    kode_input INT NULL,
    id_kategori INT NULL,
    nama_wisata VARCHAR(150) NOT NULL,
    jenis_daya_tarik VARCHAR(100),
    no_telp VARCHAR(30),
    deskripsi TEXT,
    sumber_link VARCHAR(255),
    alamat TEXT,
    kabupaten_kota VARCHAR(100),
    open_time TIME DEFAULT NULL,
    close_time TIME DEFAULT NULL,
    fasilitas TEXT,
    link_sosmed VARCHAR(255),
    link_gambar VARCHAR(255),
    harga_tiket DECIMAL(12,2) DEFAULT 0,
    STATUS ENUM('aktif','nonaktif') DEFAULT 'aktif',
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (kode_input) REFERENCES users(id_user) ON DELETE SET NULL,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori) ON DELETE SET NULL
) ENGINE=INNODB;

INSERT INTO wisata (tanggal_input, kode_input, id_kategori, nama_wisata, jenis_daya_tarik,
    no_telp, deskripsi, sumber_link, alamat, kabupaten_kota,
    open_time, close_time, fasilitas, link_sosmed, link_gambar,
    harga_tiket, STATUS, latitude, longitude) VALUES
('2025-10-07', 3, 1, 'Pantai Namalatu', 'Wisata Alam', '08123456789',
 'Pantai dengan pasir putih lembut dan air jernih, cocok untuk berenang.',
 'https://visitmaluku.id/namalatu',
 'Desa Latuhalat, Nusaniwe, Ambon', 'Kota Ambon',
 '08:00:00', '17:00:00', 'Toilet, Gazebo, Warung Makan, Parkir',
 'https://instagram.com/namalatu', 'https://example.com/gambar-namalatu.jpg',
 0, 'aktif', -3.678, 128.181);

INSERT INTO wisata (tanggal_input, kode_input, id_kategori, nama_wisata, jenis_daya_tarik,
    no_telp, deskripsi, sumber_link, alamat, kabupaten_kota,
    open_time, close_time, fasilitas, link_sosmed, link_gambar,
    harga_tiket, STATUS, latitude, longitude) VALUES
('2025-10-07', 1, 1, 'Air Terjun Wairinding', 'Wisata Alam', '082145678912',
 'Air terjunnya indah di tengah hutan dengan suasana sejuk dan alami.',
 'https://visitntt.id/wairinding',
 'Desa Pambota Jara, Sumba Timur, NTT', 'Kabupaten Sumba Timur',
 '07:00:00', '18:00:00', 'Tempat Istirahat, Toilet, Warung, Area Foto',
 'https://instagram.com/wairinding', 'https://example.com/gambar-wairinding.jpg',
 0, 'aktif', -9.758, 119.011);

-- ==========================================================
--  TABLE RATING & ULASAN
-- ==========================================================
DROP TABLE IF EXISTS rating_ulasan;

CREATE TABLE rating_ulasan (
    id_ulasan INT AUTO_INCREMENT PRIMARY KEY,
    id_wisata INT NOT NULL,
    id_user INT NULL,
    nama_pengunjung VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    komentar TEXT,
    tanggal DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_wisata) REFERENCES wisata(id_wisata) ON DELETE CASCADE,
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE SET NULL
) ENGINE=INNODB;

INSERT INTO rating_ulasan (id_wisata, id_user, nama_pengunjung, rating, komentar) VALUES
(1, 1, 'Rina Marlina', 5, 'Pantaiku cantik banget, bersih dan nyaman!'),
(1, 2, 'Dewi Anggraini', 4, 'Bagus tapi jalan menuju lokasi sedikit rusak.');

-- ==========================================================
--  TABLE LOG AKTIVITAS
-- ==========================================================
DROP TABLE IF EXISTS log_aktivitas;

CREATE TABLE log_aktivitas (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    aktivitas VARCHAR(255) NOT NULL,
    waktu DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50),
    device VARCHAR(100),
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
) ENGINE=INNODB;

INSERT INTO log_aktivitas (id_user, aktivitas, ip_address, device) VALUES
(1, 'Login ke sistem', '192.168.1.2', 'Chrome Windows');

-- ==========================================================
--  VIEWS
-- ==========================================================
CREATE OR REPLACE VIEW view_wisata_lengkap AS
SELECT w.*, k.nama_kategori, u.nama_lengkap AS input_by
FROM wisata w
LEFT JOIN kategori k ON w.id_kategori = k.id_kategori
LEFT JOIN users u ON w.kode_input = u.id_user;

CREATE OR REPLACE VIEW view_rating_wisata AS
SELECT w.id_wisata, w.nama_wisata,
       ROUND(AVG(r.rating), 1) AS rata_rating,
       COUNT(r.id_ulasan) AS total_ulasan
FROM wisata w
LEFT JOIN rating_ulasan r ON w.id_wisata = r.id_wisata
GROUP BY w.id_wisata;

-- ==========================================================
--  TRIGGERS
-- ==========================================================
DELIMITER $$

CREATE TRIGGER trig_add_wisata AFTER INSERT ON wisata
FOR EACH ROW
BEGIN
    INSERT INTO log_aktivitas (id_user, aktivitas)
    VALUES (NEW.kode_input, CONCAT('Menambahkan wisata: ', NEW.nama_wisata));
END $$

CREATE TRIGGER trig_update_wisata AFTER UPDATE ON wisata
FOR EACH ROW
BEGIN
    INSERT INTO log_aktivitas (id_user, aktivitas)
    VALUES (NEW.kode_input, CONCAT('Update wisata: ', NEW.nama_wisata));
END $$

DELIMITER ;

-- ==========================================================
--  STORED PROCEDURE FINAL (19 PARAMETER)
-- ==========================================================
DELIMITER $$

CREATE PROCEDURE sp_add_wisata (
    IN p_tanggal DATE,
    IN p_kode INT,
    IN p_kat INT,
    IN p_nama VARCHAR(150),
    IN p_jenis VARCHAR(100),
    IN p_telp VARCHAR(30),
    IN p_desk TEXT,
    IN p_sumber VARCHAR(255),
    IN p_alamat TEXT,
    IN p_kab VARCHAR(100),
    IN p_open TIME,
    IN p_close TIME,
    IN p_fasilitas TEXT,
    IN p_sosmed VARCHAR(255),
    IN p_gambar VARCHAR(255),
    IN p_harga DECIMAL(12,2),
    IN p_status ENUM('aktif','nonaktif'),
    IN p_lat DECIMAL(10,7),
    IN p_long DECIMAL(10,7)
)
BEGIN
    INSERT INTO wisata (
        tanggal_input, kode_input, id_kategori, nama_wisata, jenis_daya_tarik,
        no_telp, deskripsi, sumber_link, alamat, kabupaten_kota,
        open_time, close_time, fasilitas, link_sosmed, link_gambar,
        harga_tiket, STATUS, latitude, longitude
    ) VALUES (
        p_tanggal, p_kode, p_kat, p_nama, p_jenis,
        p_telp, p_desk, p_sumber, p_alamat, p_kab,
        p_open, p_close, p_fasilitas, p_sosmed, p_gambar,
        p_harga, p_status, p_lat, p_long
    );
END $$

DELIMITER ;

-- ==========================================================
--  CONTOH PANGGILAN STORED PROCEDURE
-- ==========================================================
CALL sp_add_wisata(
    '2025-11-15', 1, 2, 'Kebun Raya Bogor', 'Wisata Edukasi', '081234567890',
    'Taman botani terbesar di Indonesia.',
    'https://example.com/kebunraya',
    'Jalan Raya Kebun Raya, Bogor',
    'Kota Bogor',
    '07:00:00',
    '17:00:00',
    'Toilet, Gazebo, Area Parkir',
    'https://instagram.com/kebunraya',
    'https://example.com/gambar-kebunraya.jpg',
    15000, 'aktif', -6.595, 106.781
);

SET FOREIGN_KEY_CHECKS = 1;

-- Cek semua data wisata
SELECT * FROM wisata;

-- Cek rating & ulasan
SELECT * FROM rating_ulasan;

-- Cek log aktivitas
SELECT * FROM log_aktivitas;

-- Cek view lengkap wisata
SELECT * FROM view_wisata_lengkap;

-- Cek rating rata-rata per wisata
SELECT * FROM view_rating_wisata;
