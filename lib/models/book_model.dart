// Flutter 36: Nested Model + Provider
class Book {
  final String title;
  final String author;
  final String coverImage;
  final double? rating;
  final String? genre;
  double? progress;
  final String? audioFile;
  
  Book({
    required this.title, 
    required this.author, 
    required this.coverImage, 
    this.rating, 
    this.genre,
    this.progress,
    this.audioFile,
  });

  // Membuat salinan model dengan progress baru
  Book copyWith({double? progress}) {
    return Book(
      title: this.title,
      author: this.author,
      coverImage: this.coverImage,
      rating: this.rating,
      genre: this.genre,
      progress: progress ?? this.progress,
      audioFile: this.audioFile,
    );
  }
}