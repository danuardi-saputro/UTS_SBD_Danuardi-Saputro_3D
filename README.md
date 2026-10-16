# Laporan Ujian Tengah Semester (UTS) - Sistem Basis Data

**Nama**: Danuardi Saputro  
**Email**: danuardi.saputro25@mhs.uinjkt.ac.id  
**Kelas**: 3D  
**Program Studi**: Sistem Informasi  
**Mata Kuliah**: Sistem Basis Data  
**Dosen Pengampu**: Pak Rizal Broer, M.Kom  
**Repositori GitHub**: [https://github.com/danuardi-saputro/UTS_SBD_Danuardi-Saputro_3D](https://github.com/danuardi-saputro/UTS_SBD_Danuardi-Saputro_3D)  

---

## Ringkasan Proyek
Repositori ini berisi seluruh dokumentasi, berkas pemodelan, dan skrip implementasi untuk Ujian Tengah Semester (UTS) mata kuliah Sistem Basis Data. Pengerjaan mencakup perancangan **Logical Model**, transformasi ke **Physical/Relational Model** menggunakan **Oracle SQL Developer Data Modeler**, pembuatan skrip **DDL (Data Definition Language)**, serta eksekusi (*dump*) pada sistem basis data **PostgreSQL**.

Studi kasus diambil dari buku teks *Fundamentals of Database Systems* (R. Elmasri & S. B. Navathe, 7th Edition):
1. **Soal 3.21**: U.S. House of Representatives Voting Database (Bobot: 25%)
2. **Soal 3.34**: CONFERENCE_REVIEW Database (Bobot: 35%)
3. **Soal 3.35**: AIRLINE Database System - Gambar 3.21 (Bobot: 40%)

---

## Struktur Repositori

```text
UTS_SBD_Danuardi-Saputro_3D/
├── README.md                                # Dokumentasi utama repositori
├── Laporan_UTS_SBD_Danuardi_Saputro_3D.pdf  # Berkas laporan utama format PDF
├── Laporan_UTS_SBD_Danuardi_Saputro_3D.docx # Berkas laporan utama format Word
├── buku/                                    # Buku teks referensi studi kasus UTS
│   └── Fundamentals_of_Database_Systems_7th_Edition_Elmasri.pdf
├── model/                                   # Berkas proyek Oracle Data Modeler (.dmd)
│   ├── UTS_SBD_Model.dmd
│   └── UTS_SBD_Model/
├── screenshots/                             # Dokumentasi tangkapan layar proses
│   ├── soal_3_21_logical_model.png
│   ├── soal_3_21_relational_model.png
│   ├── soal_3_21_ddl.png
│   ├── soal_3_21_postgresql_dump.png
│   ├── soal_3_34_logical_model.png
│   ├── soal_3_34_relational_model.png
│   ├── soal_3_34_ddl.png
│   ├── soal_3_34_postgresql_dump.png
│   ├── soal_3_35_logical_model.png
│   ├── soal_3_35_relational_model.png
│   ├── soal_3_35_ddl.png
│   └── soal_3_35_postgresql_dump.png
└── sql/                                     # Skrip DDL PostgreSQL lengkap
    ├── soal_3_21.sql
    ├── soal_3_34.sql
    └── soal_3_35.sql
```

---

## Rincian Pengerjaan Soal

### 1. Soal 3.21: U.S. House of Representatives Voting Database
- **Deskripsi**: Merancang skema pemungutan suara anggota DPR AS selama sesi kongres dua tahunan.
- **Entitas Utama**: `STATE`, `CONGRESS_PERSON`, `BILL`, `SPONSORS` (M:N), dan `VOTE` (M:N dengan pilihan suara: Yes, No, Abstain, Absent).
- **Skrip DDL**: [`sql/soal_3_21.sql`](sql/soal_3_21.sql)

### 2. Soal 3.34: CONFERENCE_REVIEW Database
- **Deskripsi**: Sistem peninjauan karya ilmiah pada konferensi akademik.
- **Entitas Utama**: `AUTHOR` (termasuk relasi Contact Author), `PAPER`, `WRITES` (M:N), `REVIEWER`, `REVIEWER_TOPIC`, dan `REVIEW_ASSIGNMENT` (dengan evaluasi 4 kriteria skala 1-10, rekomendasi, komentar panitia dan feedback penulis).
- **Skrip DDL**: [`sql/soal_3_34.sql`](sql/soal_3_34.sql)

### 3. Soal 3.35: AIRLINE Database System (Gambar 3.21 Buku Elmasri)
- **Deskripsi**: Implementasi menyeluruh sistem penerbangan komersial sesuai Gambar 3.21 buku Elmasri.
- **Entitas Utama**: `AIRPORT`, `AIRPLANE_TYPE`, `CAN_LAND`, `AIRPLANE`, `FLIGHT`, `FARE`, `FLIGHT_LEG`, `LEG_INSTANCE`, dan `SEAT_RESERVATION`.
- **Skrip DDL**: [`sql/soal_3_35.sql`](sql/soal_3_35.sql)
