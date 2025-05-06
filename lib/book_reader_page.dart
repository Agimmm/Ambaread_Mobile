import 'package:flutter/material.dart';

class BookReaderPage extends StatelessWidget {
  final String bookTitle;
  final String chapterTitle;
  final String chapterSubtitle;

  const BookReaderPage({
    super.key,
    required this.bookTitle,
    required this.chapterTitle,
    required this.chapterSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            
            // Chapter title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    chapterTitle,
                    style: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    chapterSubtitle,
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Content text
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _getChapterContent(),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getChapterContent() {
    // Long sample text content for the chapter
    return '''
PAGI itu, waktu aku masih kecil, aku duduk di bangku panjang di depan sebuah kelas. Sebatang pohon filicium tua yang riang meneduhiku. Ayahku duduk di sampingku, memeluk pundakku dengan kedua lengannya dan tersenyum mengangguk-angguk pada setiap orangtua dan anak-anaknya yang duduk berderet-deret di bangku panjang lain di depan kami. Hari itu adalah hari yang amat penting: hari pertama masuk SD. Di ujung bangku-bangku panjang tadi ada sebuah pintu terbuka. Kosen pintu itu miring karena seluruh bangunan sekolah sudah doyong seolah akan roboh. Di mulut pintu berdiri dua orang guru seperti para penyambut tamu dalam perhelatan.

Mereka adalah seorang bapak tua berwajah sabar, Bapak K.A. Harfan Efendy Noor, sang kepala sekolah dan seorang wanita muda berjilbab, Ibu N.A. Muslimah Hafsari, atau Bu Mus. Seperti ayahku, mereka berdua juga tersenyum. Namun, senyum Bu Mus adalah senyum getir yang dipaksakan karena tampak jelas beliau sedang cemas. Wajahnya tegang dan gerak-geriknya gelisah. Ia berulang kali menghitung jumlah anak-anak yang duduk di bangku panjang. Ia beberapa kali membuka sebuah map lusuh berwarna hijau muda.

Di dalamnya ada selembar kertas dengan keterangan panjang bertuliskan tangan. Aku tahu kertas apa itu. Itu adalah salinan surat keputusan akhir yang menyegel nasib sekolah kami. Sekolah kami adalah sebuah sekolah desa yang amat tua yang berada di salah satu tempat yang terpencil di Indonesia. Belakangan, baru aku ketahui, bahwa sekolah kami tak pernah didaftar ke dalam database sekolah di rayon Pulau Belitong. Karena tak terdata, maka sekolah kami tak mendapatkan bantuan dan tak berhak mendapatkan kunjungan pengawas.

Dari segi apa pun sekolah kami tak layak disebut sekolah. Kami bahkan tak punya seragam. Para siswa mengenakan baju olahraga yang terlihat sangat kusam. Baju olahraga ini sudah tak lagi memiliki identitas warna. Beberapa siswa mengenakan sandal dan yang lain telanjang kaki. Kami juga tak punya sepatu, tas sekolah, buku, dan alat tulis yang layak. Jika beruntung, kami mendapatkan bantuan buku-buku bekas dari pemerintah. 

Kampung kami terletak di pingggir laut. Setiap hari aku melihat anak-anak sebayaku, dengan wajah berseri, melompat dari perahu di pagi hari, berlarian di atas dermaga, beriringan menuju sekolah, berpakaian rapi, berdasi dengan topi baret, menggenggam kotak-kotak pensil yang berkilat-kilat, dan menenteng tas-tas sekolah yang berwarna-warni. Aku selalu membayangkan diriku berada di tengah-tengah mereka.

Aku ingin seperti mereka, mengenakan seragam, menggenggam buku, memiliki kotak pensil, dan pulang pergi ke sekolah naik sepeda. Sangat berbeda dengan keadaan kami yang hidup pas-pasan. Sebagian besar orang tua kami bekerja sebagai nelayan, buruh tambang, atau petani karet. Pekerjaan yang hasilnya sangat tidak menentu. Kami bahkan tak bisa membeli beras karena harganya mahal. Kami lebih sering makan ubi jalar, kadang-kadang ubi kayu.

Kadang di malam hari, aku dan saudara-saudaraku tidur dengan perut kosong karena tak ada yang bisa dimakan. Jika itu terjadi, ibu akan menyeduh teh manis dan menyuruh kami meminumnya. Teh manis hangat sedikit mengenyangkan dan mengatasi rasa lapar. Kehidupan yang sangat berat dan penuh perjuangan.

Tapi pagi ini aku sangat bahagia. Aku akan mulai sekolah. Walaupun bukan di sekolah yang bagus seperti PN, setidaknya aku akan bisa belajar membaca, menulis, dan berhitung. Seperti pesan ayahku sebelum berangkat tadi, "Yang penting kamu bisa membaca, kalau sudah bisa membaca, kamu bisa mencari pengetahuan sendiri."

Bu Mus masih tampak sangat cemas. "Sembilan, masih kurang satu... kita masih kurang satu...," desahnya. Ia berkata kepada Pak Harfan. Wajah Pak Harfan juga tampak cemas. Kecemasan mereka menular kepada ayahku dan orangtua lainnya. Jika jumlah siswa tidak mencapai sepuluh, sekolah ini akan ditutup. Kami akan dipaksa masuk ke sekolah Muhammadiyah di kecamatan yang sangat jauh.

Orangtua kami tak akan sanggup membiayai transportasi. Jika itu terjadi, kemungkinan besar kami akan berhenti sekolah. Kulihat Bu Mus berkali-kali melihat jam tangannya dengan gelisah. Aku khawatir ia akan pingsan karena tegang.

Tiba-tiba dari belokan gang sekolah itu muncul seorang anak laki-laki berumur kira-kira sebelas tahun, berambut merah, naik sepeda butut yang terlalu besar untuknya. Ia mengayuh sepeda dengan sangat cepat, terseok-seok, dan hampir menabrak tiang bendera di halaman sekolah. Ia meloncat turun dari sepedanya, melemparkan sepeda itu sembarangan, dan seperti prajurit yang terlambat pada upacara bendera, ia terbirit-birit menghampiri kami dengan tas plastik hitam bergambarkan seekor kuda yang meringkik, terjepit di ketiaknya.

"Nama saya Lintang, Pak! Saya ingin sekolah di sini!" ucapnya dengan napas yang masih terengah-engah. Itu adalah kalimat pertama yang diucapkan anak ajaib yang akan mengubah selamanya sekolah kami, dan akan mengubah hidupku secara luar biasa.

"Syukurlah, cukup sepuluh orang. Kita bisa mendaftarkan sekolah ini," ucap Bu Mus dengan wajah sangat lega. Mata indahnya berbinar-binar. Pak Harfan yang bijaksana pun tersenyum bahagia.

Hari itu adalah hari yang bersejarah bagi pendidikan di kampung kami. Kami akan bersekolah! Kami akan belajar membaca, menulis, dan berhitung! Kami akan menjadi orang pintar! Kami akan punya masa depan yang cerah!

Setelah menyampaikan beberapa kata sambutan, Pak Harfan mempersilakan kami memasuki ruang kelas. Kami pun berbaris dan memasuki ruang kelas dengan tertib. Di dalam kelas, kami duduk berpasangan di bangku panjang yang berderit ketika diduduki. Aku berpasangan dengan Lintang yang tampaknya masih terengah-engah setelah perjalanan jauhnya ke sekolah.

Lalu Bu Mus masuk ke dalam kelas. Ia membawa segelas air putih dan meminumnya dengan tangan gemetar. Ia kemudian membuka map berwarna hijau dan mulai memanggil nama kami satu per satu untuk mengisi absensi.

"Lintang Samudra Basara bin Syahbani Maulana," panggilnya.

"Hadir, Bu!" jawab Lintang dengan suara lantang.

Begitu seterusnya sampai kesepuluh nama dipanggil. Setelah itu, Bu Mus mulai memperkenalkan diri dan menceritakan peraturan sekolah. Sekolah kami masuk pagi sampai siang. Kami diperbolehkan membawa bekal makanan. Kami harus selalu mandi dan berpakaian bersih ke sekolah, walaupun tidak punya seragam.

Lalu ia bercerita tentang Nabi Musa yang membelah Laut Merah, tentang kuda terbang Nabi Muhammad, dan tentang pentingnya menuntut ilmu sampai ke negeri China. Bu Mus sangat pandai bercerita. Mata kami semua terpaku padanya. Ia pintar sekali memilih kata-kata sehingga dongeng menjadi hidup. Setelah selesai bercerita, ia mengajarkan kami bernyanyi. Lagu pertama yang diajarkannya adalah "Pelangi-pelangi".

Aku sangat menyukai sekolah. Walaupun bangunannya sudah miring, papan tulisnya retak, dan atapnya bocor di sana-sini, tapi inilah tempat yang akan mengubah hidupku. Di tempat inilah aku akan belajar membaca. Dan nantinya, aku akan membaca sebanyak-banyaknya buku.

Ketika waktu pulang tiba, Bu Mus menutup kelas dengan membacakan doa. Kami pun pulang dengan perasaan gembira. Sepanjang perjalanan pulang, ayahku terus-menerus menanyakan pengalaman pertamaku di sekolah. Aku menceritakan semuanya dengan antusias. Tentang Bu Mus yang cantik dan baik hati, tentang Pak Harfan yang bijaksana, dan tentang Lintang yang hampir terlambat.

"Ayah, aku sangat senang bersekolah!" ucapku dengan semangat.

Ayahku tersenyum dan mengelus kepalaku dengan penuh kasih sayang. Hari pertamaku di sekolah telah memberikan harapan baru dalam hidupku yang penuh kesederhanaan ini.
''';
  }
}