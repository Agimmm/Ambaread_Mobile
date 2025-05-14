<?php
$servername = "localhost";     // Host MySQL, biasanya 'localhost'
$username = "root";            // Username MySQL (default di Laragon adalah 'root')
$password = "";                // Password (kosong untuk Laragon)
$dbname = "ambaread";           // Ganti dengan nama database Anda

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Mengecek koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
