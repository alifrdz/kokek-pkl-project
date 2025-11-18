CREATE DATABASE db_wisata;
USE db_wisata;

CREATE TABLE kabupaten (
    id_kabupaten INT AUTO_INCREMENT PRIMARY KEY,
    nama_kabupaten VARCHAR(100) NOT NULL
);

INSERT INTO kabupaten (nama_kabupaten) VALUES
-- SUMATRA
('Medan'),
('Padang'),
('Pekanbaru'),
('Palembang'),
('Banda Aceh'),
('Bandar Lampung'),

-- KALIMANTAN
('Balikpapan'),
('Samarinda'),
('Banjarmasin'),
('Pontianak'),
('Tarakan'),

-- SULAWESI
('Makassar'),
('Manado'),
('Kendari'),
('Palu'),
('Gorontalo'),

-- PAPUA
('Jayapura'),
('Merauke'),
('Biak'),
('Nabire'),
('Timika');

SELECT w.*, k.nama_kabupaten 
FROM wisata w
LEFT JOIN kabupaten k ON w.id_kabupaten = k.id_kabupaten
WHERE w.nama_wisata LIKE CONCAT('%', 'pantai', '%');

INSERT INTO wisata 
(nama_wisata, jenis_daya_tarik, deskripsi, gambar, alamat, id_kabupaten)
VALUES
-- SUMATRA (id_kabupaten contoh: Medan = 1)
('Danau Toba', 'Danau', 
 'Danau vulkanik terbesar di Indonesia dengan pemandangan alam yang menakjubkan.',
 'danau_toba.jpg',
 'Parapat, Kabupaten Simalungun, Sumatra Utara', 
 1),

-- SUMATRA (Padang = 2)
('Pantai Air Manis', 'Pantai',
 'Pantai terkenal dengan legenda Malin Kundang dan pasir halus.',
 'pantai_air_manis.jpg',
 'Jl. Pantai Air Manis, Padang Selatan',
 2),

-- KALIMANTAN (Balikpapan = 7)
('Pantai Lamaru', 'Pantai',
 'Pantai keluarga dengan suasana tenang, cocok untuk piknik dan bermain air.',
 'pantai_lamaru.jpg',
 'Lamaru, Balikpapan Timur',
 7),

-- SULAWESI (Makassar = 12)
('Pantai Losari', 'Pantai',
 'Ikon wisata Kota Makassar, terkenal dengan sunset indah dan kuliner lokal.',
 'pantai_losari.jpg',
 'Jalan Penghibur, Kota Makassar',
 12),

-- PAPUA (Jayapura = 17)
('Danau Sentani', 'Danau',
 'Danau alami terbesar di Papua, dikelilingi pegunungan hijau dan desa adat.',
 'danau_sentani.jpg',
 'Kabupaten Jayapura, Papua',
 17),

-- SULAWESI (Manado = 13)
('Taman Laut Bunaken', 'Taman Laut',
 'Destinasi snorkeling dan diving terbaik dengan terumbu karang dunia.',
 'bunaken.jpg',
 'Pulau Bunaken, Manado',
 13);

-- CREATE
INSERT INTO wisata (nama_wisata, jenis_daya_tarik, deskripsi, gambar, alamat, id_kabupaten)
VALUES ('Nama wisata', 'Jenis', 'Deskripsi', 'gambar.jpg', 'Alamat lengkap', 3);

-- READ (Semua Wisata)
SELECT w.*, k.nama_kabupaten
FROM wisata w
LEFT JOIN kabupaten k ON w.id_kabupaten = k.id_kabupaten
ORDER BY id_wisata DESC;

-- READ DETAIL (by ID)
SELECT w.*, k.nama_kabupaten
FROM wisata w
LEFT JOIN kabupaten k ON w.id_kabupaten = k.id_kabupaten
WHERE w.id_wisata = 1;

-- SEARCH WISATA
SELECT w.*, k.nama_kabupaten 
FROM wisata w
LEFT JOIN kabupaten k ON w.id_kabupaten = k.id_kabupaten
WHERE w.nama_wisata LIKE CONCAT('%', 'pantai', '%');

-- UPDATE
UPDATE wisata 
SET nama_wisata = 'Nama Baru',
    jenis_daya_tarik = 'Jenis Baru',
    deskripsi = 'Deskripsi Baru',
    gambar = 'foto_baru.jpg',
    alamat = 'Alamat Baru',
    id_kabupaten = 10
WHERE id_wisata = 1;

-- DELETE
DELETE FROM wisata
WHERE id_wisata = 1;
