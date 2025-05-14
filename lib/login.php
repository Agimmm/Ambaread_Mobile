<?php
include 'config.php'; // Pastikan koneksi database benar

$username = $_POST['username'];
$password = $_POST['password'];

// Cek jika email atau password kosong
if (empty($username) || empty($password)) {
    echo json_encode(['status' => 'error', 'message' => 'Username and password cannot be empty']);
    exit();
}

$sql = "SELECT * FROM users WHERE username = '$username' LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    // Verifikasi password
    if (password_verify($password, $user['password'])) {
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid password']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'User not found']);
}

$conn->close();
?>
