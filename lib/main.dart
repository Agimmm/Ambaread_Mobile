import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'buku.dart';
import 'landingpage.dart';
import 'library_page.dart';
import 'profile_page.dart';
import 'genre_page.dart';
import 'models/book_model.dart';
import 'providers/book_provider.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase terlebih dahulu

  // Panggil fungsi untuk cek koneksi Firebase
  checkFirebaseConnection();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: AmbaRead(), // Aplikasi kamu
    ),
  );
}

// Fungsi untuk mengecek status koneksi Firebase
void checkFirebaseConnection() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;  // Mengecek status login pengguna
    if (user != null) {
      print("Firebase Connected, User: ${user.email}");
    } else {
      print("Firebase Connected, but no user signed in.");
    }
  } catch (e) {
    print("Error connecting to Firebase: $e");
  }
}

class AmbaRead extends StatelessWidget {
  const AmbaRead({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmbaRead',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: WelcomePage(),
    );
  }
}

class AmbaReadHomePage extends StatefulWidget {
  const AmbaReadHomePage({super.key});

  @override
  _AmbaReadHomePageState createState() => _AmbaReadHomePageState();
}

class _AmbaReadHomePageState extends State<AmbaReadHomePage> {
  final List<String> categories = ['All', 'Romance', 'Sci-Fi', 'Fantasy', 'Classics'];
  int _selectedCategoryIndex = 2;
  DateTime _selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 250,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: _selectedDate,
            onDateTimeChanged: (val) {
              setState(() {
                _selectedDate = val;
              });
              Provider.of<UserProvider>(context, listen: false).updateReadingDate(_selectedDate);
            },
          ),
        ),
      );
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
        Provider.of<UserProvider>(context, listen: false).updateReadingDate(_selectedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Amba', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            Text('Read', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: Icon(Icons.calendar_today), onPressed: () => _selectDate(context)),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Reading Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Buku',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: List.generate(categories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(categories[index]),
                        selected: _selectedCategoryIndex == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                          Provider.of<BookProvider>(context, listen: false).filterBooksByCategory(categories[index]);
                        },
                        selectedColor: Colors.blue[700],
                        labelStyle: TextStyle(
                          color: _selectedCategoryIndex == index ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Lanjutkan Membaca', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: isTablet ? 300 : 250,
              child: Consumer<BookProvider>(builder: (context, bookProvider, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookProvider.continueReadingBooks.length,
                  itemBuilder: (context, index) {
                    return _buildContinueReadingCard(bookProvider.continueReadingBooks[index], screenWidth);
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Trending', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Consumer<BookProvider>(builder: (context, bookProvider, child) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: bookProvider.trendingBooks.length,
                itemBuilder: (context, index) {
                  return _buildTrendingBookCard(bookProvider.trendingBooks[index]);
                },
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Genre'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmarks), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GenrePage()));
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LibraryPage()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
      ),
    );
  }

  Widget _buildContinueReadingCard(Book book, double screenWidth) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BukuDetailPage(book: book)));
      },
      child: Container(
        width: screenWidth * 0.45,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                book.coverImage,
                width: double.infinity,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 8,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
              child: FractionallySizedBox(
                widthFactor: book.progress ?? 0,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(color: Colors.blue[700], borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            SizedBox(height: 7),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(book.author, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingBookCard(Book book) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BukuDetailPage(book: book)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                book.coverImage,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(book.author, style: TextStyle(fontSize: 10, color: Colors.grey[700])),
            ),
          ],
        ),
      ),
    );
  }
}
