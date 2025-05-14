// Flutter 36: Nested Model + Provider
class UserModel {
  String username;
  String email;
  DateTime readingDate;
  List<String> savedBooks;

  UserModel({
    required this.username,
    required this.email,
    required this.readingDate,
    this.savedBooks = const [],
  });

  UserModel copyWith({
    String? username,
    String? email,
    DateTime? readingDate,
    List<String>? savedBooks,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      readingDate: readingDate ?? this.readingDate,
      savedBooks: savedBooks ?? this.savedBooks,
    );
  }
}