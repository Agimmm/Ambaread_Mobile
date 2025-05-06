import 'package:flutter/material.dart';
import '../models/book_model.dart';

// Flutter 35: State Management Provider
class BookProvider with ChangeNotifier {
  // Data buku yang dilanjutkan membaca
  final List<Book> _continueReadingBooks = [
    Book(
      title: 'Kala Malam Itu',
      author: 'Samantha Shannon',
      coverImage: 'assets/samantha.jpg',
      progress: 0.9,
      audioFile: 'aa.mp3',
    )
  ];

  // Data buku trending
  final List<Book> _trendingBooks = [
    Book(
      title: 'Bumi',
      author: 'Tere Liye',
      coverImage: 'assets/bumi.jpg',
      rating: 4.0,
      genre: 'Fantasy',
      audioFile: 'bumi_narration.mp3',
    ),
    Book(
      title: 'Sejarah Dunia Yang Disembunyikan',
      author: 'Jonathan Hitam',
      coverImage: 'assets/dunia.jpg',
      rating: 4.8,
      genre: 'Documentary',
      audioFile: 'sejarah_narration.mp3',
    )
  ];

  // Data buku trending yang sudah difilter
  List<Book> _filteredTrendingBooks = [];

  // Getter untuk mendapatkan semua buku continue reading
  List<Book> get continueReadingBooks => _continueReadingBooks;

  // Getter untuk mendapatkan buku trending (original atau filtered)
  List<Book> get trendingBooks => 
      _filteredTrendingBooks.isNotEmpty ? _filteredTrendingBooks : _trendingBooks;

  // Method untuk memperbarui progress membaca
  void updateBookProgress(Book book, double progress) {
    final int bookIndex = _continueReadingBooks.indexWhere(
        (element) => element.title == book.title);
    
    if (bookIndex != -1) {
      _continueReadingBooks[bookIndex] = book.copyWith(progress: progress);
      notifyListeners();
    }
  }

  // Filter buku berdasarkan kategori
  void filterBooksByCategory(String category) {
    if (category == 'All') {
      _filteredTrendingBooks = [];
    } else {
      _filteredTrendingBooks = _trendingBooks
          .where((book) => book.genre == category)
          .toList();
    }
    notifyListeners();
  }

  // Menambahkan buku ke daftar continue reading
  void addToContinueReading(Book book) {
    if (!_continueReadingBooks.any((element) => element.title == book.title)) {
      _continueReadingBooks.add(book.copyWith(progress: 0.0));
      notifyListeners();
    }
  }
}