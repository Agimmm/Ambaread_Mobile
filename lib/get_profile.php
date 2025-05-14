<?php
include 'config.php'; // Pastikan koneksi ke database sudah benar

// Aktifkan session untuk mengambil data user yang sedang login
session_start();

// Cek jika user_id ada di session
if (isset($_SESSION['user_id'])) {
    $user_id = $_SESSION['user_id']; // Ambil user_id dari session
} else {
    // Jika session tidak ada, kirimkan pesan error
    echo json_encode([
        'status' => 'error',
        'message' => 'User not logged in'
    ]);
    exit();
}

// Gunakan prepared statement untuk menghindari SQL injection
$sql = "SELECT username, foto_profil FROM users WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id); // Bind user_id sebagai integer
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Ambil data user jika ditemukan
    $user = $result->fetch_assoc();
    
    // Menambahkan URL gambar yang lengkap untuk akses
    $foto_profil = $user['foto_profil'];
    $foto_url = "http://your-server-url/$foto_profil"; // Ganti dengan URL gambar yang valid di server Anda

    echo json_encode([
        'status' => 'success',
        'username' => $user['username'],
        'foto_profil' => $foto_url, // Kirim URL lengkap untuk gambar
    ]);
} else {
    // Jika tidak ada user yang ditemukan
    echo json_encode([
        'status' => 'error',
        'message' => 'User not found'
    ]);
}

$stmt->close();
$conn->close();
?>
