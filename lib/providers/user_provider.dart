import 'package:flutter/material.dart';
import '../models/user_model.dart';

// Flutter 35: State Management Provider
class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(
    username: 'User',
    email: 'user@example.com',
    readingDate: DateTime.now(),
  );

  // Getter untuk mendapatkan user
  UserModel get user => _user;

  // Update user profile
  void updateProfile({String? username, String? email}) {
    _user = _user.copyWith(
      username: username,
      email: email,
    );
    notifyListeners();
  }

  // Update reading date (untuk DatePicker)
  void updateReadingDate(DateTime date) {
    _user = _user.copyWith(readingDate: date);
    notifyListeners();
  }

  // Menambahkan buku ke daftar saved books
  void addToSavedBooks(String bookTitle) {
    if (!_user.savedBooks.contains(bookTitle)) {
      final newSavedBooks = List<String>.from(_user.savedBooks)..add(bookTitle);
      _user = _user.copyWith(savedBooks: newSavedBooks);
      notifyListeners();
    }
  }

  // Menghapus buku dari daftar saved books
  void removeFromSavedBooks(String bookTitle) {
    if (_user.savedBooks.contains(bookTitle)) {
      final newSavedBooks = List<String>.from(_user.savedBooks)..remove(bookTitle);
      _user = _user.copyWith(savedBooks: newSavedBooks);
      notifyListeners();
    }
  }
}