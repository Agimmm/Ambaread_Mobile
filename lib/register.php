<?php
include 'config.php'; // Pastikan file config.php di-include dengan benar

// Ambil data dari form (POST request)
$email = $_POST['email'];
$password = $_POST['password'];
$username = $_POST['username']; // Misalnya username ditambahkan sebagai input

// Cek apakah email sudah terdaftar
$sql = "SELECT * FROM users WHERE email = '$email' LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Jika email sudah ada
    echo json_encode(['status' => 'error', 'message' => 'Email already registered']);
} else {
    // Pastikan password tidak kosong sebelum di-hash
    if (empty($password)) {
        echo json_encode(['status' => 'error', 'message' => 'Password cannot be empty']);
        exit;
    }
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    // Masukkan data ke dalam database
    // Menambahkan 'verified' dengan nilai default 0
    $sql = "INSERT INTO users (email, password, username, verified) VALUES ('$email', '$hashedPassword', '$username', 0)";

    if ($conn->query($sql) === TRUE) {
        // Jika berhasil
        echo json_encode(['status' => 'success', 'message' => 'Registration successful']);
    } else {
        // Jika gagal
        echo json_encode(['status' => 'error', 'message' => 'Registration failed']);
    }
}

// Tutup koneksi
$conn->close();
?>
