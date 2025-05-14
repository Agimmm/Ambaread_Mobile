import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'buku.dart';
import 'landingpage.dart';
import 'signin_page.dart';
import 'library_page.dart';
import 'profile_page.dart';
import 'genre_page.dart'; // Import the genre page
import 'models/book_model.dart'; // Import book model
import 'models/user_model.dart'; // Import user model
import 'providers/book_provider.dart'; // Import book provider
import 'providers/user_provider.dart'; // Import user provider

void main() {
  runApp(
    // Flutter 38: Multi Provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: AmbaRead(),
    ),
  );
}

class AmbaRead extends StatelessWidget {
  const AmbaRead({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmbaRead',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: WelcomePage(), // Start with SignInPage
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
  int _selectedCategoryIndex = 2; // Fantasy selected by default
  DateTime _selectedDate = DateTime.now(); // Flutter 34: Date Picker

  // Moved to BookProvider
  /* final List<Book> continueReading = [
    Book(
      title: 'Kala Malam Itu',
      author: 'Samantha Shannon',
      coverImage: 'assets/samantha.jpg',
      progress: 0.9,
      audioFile: 'aa.mp3',
    )
  ];

  final List<Book> trendingBooks = [
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
  ]; */

  void _selectDate(BuildContext context) async {
    // Flutter 34: Date Picker implementation
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
      // Also update the provider with selected date for reading goals
      Provider.of<UserProvider>(context, listen: false).updateReadingDate(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Amba',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              'Read',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context), // Flutter 34: Date Picker trigger
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Date Display - Flutter 34: Date Picker result
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
            
            // Search Bar
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

            // Category Chips
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
                          // Update selected category in provider
                          Provider.of<BookProvider>(context, listen: false)
                              .filterBooksByCategory(categories[index]);
                        },
                        selectedColor: Colors.blue[700],
                        labelStyle: TextStyle(
                          color: _selectedCategoryIndex == index 
                            ? Colors.white 
                            : Colors.black,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Continue Reading Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Lanjutkan Membaca',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Flutter 37: Consumer + Provider
            SizedBox(
              height: 250,
              child: Consumer<BookProvider>(
                builder: (context, bookProvider, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bookProvider.continueReadingBooks.length,
                    itemBuilder: (context, index) {
                      return _buildContinueReadingCard(bookProvider.continueReadingBooks[index]);
                    },
                  );
                },
              ),
            ),

            // Trending Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Flutter 37: Consumer + Provider
            Consumer<BookProvider>(
              builder: (context, bookProvider, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: bookProvider.trendingBooks.length,
                  itemBuilder: (context, index) {
                    return _buildTrendingBookCard(bookProvider.trendingBooks[index]);
                  },
                );
              },
            ),
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
        currentIndex: 0, // Home is selected by default
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        onTap: (index) {
          if (index == 0) { 
            // Already on Home page
          } else if (index == 1) { // Genre tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GenrePage()),
            );
          } else if (index == 2) { // Library/Saved tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LibraryPage()),
            );
          } else if (index == 3) { // Profile tab
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildContinueReadingCard(Book book) {
    // Get BookProvider instance
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BukuDetailPage(book: Book(
              title: book.title,
              author: book.author,
              coverImage: book.coverImage,
              progress: book.progress,
              audioFile: book.audioFile,
            )),
          ),
        );
      },
      child: Container(
        width: 170,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                book.coverImage,
                width: 190,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                widthFactor: book.progress ?? 0,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            SizedBox(height: 7),
            Text(
              book.title,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              book.author,
              style: TextStyle(
                color: Colors.grey, 
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                _showProgressUpdateDialog(book);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 32),
              ),
              child: Text(
                'Update Progress',
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showProgressUpdateDialog(Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double currentProgress = book.progress ?? 0.0;
        // Flutter 36: Nested Model + Provider
        final bookProvider = Provider.of<BookProvider>(context, listen: false);
        
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Update Reading Progress'),
              content: Slider(
                value: currentProgress,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${(currentProgress * 100).toStringAsFixed(0)}%',
                onChanged: (double value) {
                  setState(() {
                    currentProgress = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    // Flutter 35: State Management Provider
                    bookProvider.updateBookProgress(book, currentProgress);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTrendingBookCard(Book book) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BukuDetailPage(book: Book(
              title: book.title,
              author: book.author,
              coverImage: book.coverImage,
              rating: book.rating,
              genre: book.genre,
              audioFile: book.audioFile,
            )),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  book.coverImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    book.author,
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        book.genre ?? 'Unknown',
                        style: TextStyle(color: Colors.blue),
                      ),
                      if (book.rating != null)
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(book.rating.toString()),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}