import 'package:flutter/material.dart';
// Import file utama untuk menggunakan class Book
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts package
import 'book_reader_page.dart';
import 'models/book_model.dart';

class BukuDetailPage extends StatefulWidget {
  final Book book;

  const BukuDetailPage({super.key, required this.book});

  @override
  State<BukuDetailPage> createState() => _BukuDetailPageState();
}

class _BukuDetailPageState extends State<BukuDetailPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  
  @override
  void initState() {
    super.initState();
    _initTts();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  // Initialize TTS settings
  Future<void> _initTts() async {
    // Set up completion callback
    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    
    // Set up error handler
    flutterTts.setErrorHandler((error) {
      setState(() {
        isSpeaking = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
    
    // Default configuration
    await flutterTts.setLanguage("id-ID"); // Indonesian language
    await flutterTts.setSpeechRate(0.5); // Slightly slower speech rate
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    if (isSpeaking) {
      await flutterTts.stop();
      setState(() {
        isSpeaking = false;
      });
    } else {
      setState(() {
        isSpeaking = true;
      });
      
      // Get synopsis or default text
      final String textToSpeak = text.isNotEmpty ? text : 
          'Cerita terjadi di Desa Gantung, Belitung Timur. Dimulai ketika sekolah Muhammadiyah terancam akan dibubarkan oleh Depdikbud Sumsel jika tidak mencapai siswa baru sebanyak 10 anak.';
      
      // Speak the text
      await flutterTts.speak(textToSpeak);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get synopsis text
    final String synopsis = 'Cerita terjadi di Desa Gantung, Belitung Timur. Dimulai ketika sekolah Muhammadiyah terancam akan dibubarkan oleh Depdikbud Sumsel jika tidak mencapai siswa baru sebanyak 10 anak. Ketika itu baru 9 anak yang menghadiri upacara pembukaan, akan tetapi tepat ketika Pak Harfan, sang kepala sekolah, hendak berpidato menutup sekolah, Harun dan Lintang datang untuk mendaftarkan diri di sekolah kecil itu.\n\n'
              'Dari sanalah dimulai cerita mereka. Mulai dari penempatan tempat duduk, pertemuan mereka dengan Pak Harfan, petualangan mereka yang luar biasa di mana A Kiong yang malah cengar-cengir ketika ditanyakan namanya oleh guru.';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Buku dan Penulis
            Text(
              widget.book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'by ${widget.book.author}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),

            // Cover Buku
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.book.coverImage,
                  width: 200,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Rating dan Genre
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 24),
                SizedBox(width: 4),
                Text(
                  '${widget.book.rating ?? 4.8}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 16),
                Text(
                  widget.book.genre ?? 'Novel',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Jumlah Halaman
            Text(
              '999 Pages',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),

            // Synopsis
            Text(
              'Synopsis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              synopsis,
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),

            // Tombol TTS dan "Baca Sekarang" dalam satu Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol Text-to-Speech dengan Speaker Icon
                ElevatedButton.icon(
                  onPressed: () => _speak(synopsis),
                  icon: Icon(
                    isSpeaking ? Icons.stop : Icons.volume_up,
                    color: Colors.white,
                  ),
                  label: Text(
                    isSpeaking ? 'Stop' : 'Dengarkan',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    backgroundColor: Colors.red[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Tombol "Baca Sekarang"
                // Inside the BukuDetailPage class, update the "Baca Sekarang" button's onPressed method:

                // Replace the ElevatedButton for "Baca Sekarang" with this:
                ElevatedButton(
                  onPressed: () {
                       // Navigate to the BookReaderPage
                        Navigator.push(
                        context,
                      MaterialPageRoute(
                        builder: (context) => BookReaderPage(
                         bookTitle: widget.book.title, 
                      chapterTitle: 'Bab 1',
          chapterSubtitle: 'Sepuluh Murid Baru',
        ),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    backgroundColor: Colors.blue[700],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: Text(
    'Baca Sekarang',
    style: TextStyle(fontSize: 18, color: Colors.white),
  ),
),
              ],
            ),
          ],
        ),
      ),
    );
  }
}