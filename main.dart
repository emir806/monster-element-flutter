import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monster Element',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Color(0xFF0D0D1A),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1A1A2E),
          elevation: 0,
        ),
      ),
      home: HalamanUtama(),
    );
  }
}

// data monster disimpan di sini
List<Map<String, dynamic>> daftarMonster = [
  {
    'nama': 'Ignirath',
    'gambar': 'assets/images/fire.png',
    'deskripsi': 'Ignirath adalah monster api yang hidup di dalam gunung berapi. Ia bisa menyemburkan api dari mulutnya dan tubuhnya selalu membara. Sangat berbahaya kalau didekati.',
    'element': 'Api',
    'power': 'Fireball',
    'habitat': 'Gunung Berapi',
    'level': 85,
  },
  {
    'nama': 'Aquarex',
    'gambar': 'assets/images/water.png',
    'deskripsi': 'Aquarex tinggal di dasar laut yang paling dalam. Monster ini bisa mengendalikan arus laut dan membuat badai besar. Sisiknya sangat keras dan tahan terhadap semua serangan.',
    'element': 'Air',
    'power': 'Tidal Wave',
    'habitat': 'Laut Dalam',
    'level': 78,
  },
  {
    'nama': 'Frostmaw',
    'gambar': 'assets/images/ice.png',
    'deskripsi': 'Frostmaw berasal dari pegunungan es di kutub utara. Napasnya bisa membekukan apapun dalam sekejap. Monster ini sangat lambat tapi serangannya sangat mematikan.',
    'element': 'Es',
    'power': 'Blizzard Breath',
    'habitat': 'Pegunungan Kutub',
    'level': 72,
  },
  {
    'nama': 'Thunderix',
    'gambar': 'assets/images/thunder.png',
    'deskripsi': 'Thunderix adalah monster petir yang bergerak dengan kecepatan kilat. Ia muncul saat badai petir dan bisa menghancurkan apapun dengan sambaran listriknya yang sangat kuat.',
    'element': 'Petir',
    'power': 'Thunder Strike',
    'habitat': 'Awan Badai',
    'level': 90,
  },
  {
    'nama': 'Rockzilla',
    'gambar': 'assets/images/stone.png',
    'deskripsi': 'Rockzilla adalah monster batu raksasa yang tubuhnya terbuat dari granit. Ia sangat lambat bergerak tapi pertahanannya hampir tidak bisa ditembus. Suka tidur selama ratusan tahun.',
    'element': 'Batu',
    'power': 'Stone Crush',
    'habitat': 'Gua Bawah Tanah',
    'level': 65,
  },
  {
    'nama': 'Shadowveil',
    'gambar': 'assets/images/shadow.png',
    'deskripsi': 'Shadowveil adalah monster bayangan yang bisa menghilang di kegelapan. Tidak ada yang tahu bentuk aslinya karena selalu tersembunyi dalam bayangan. Monster paling misterius dari semua.',
    'element': 'Bayangan',
    'power': 'Dark Void',
    'habitat': 'Hutan Gelap',
    'level': 95,
  },
];

class HalamanUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '⚔️ Monster Element',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.purpleAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // tulisan kecil di bawah appbar
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Color(0xFF1A1A2E),
            child: Text(
              'Pilih monster untuk lihat detailnya!',
              style: TextStyle(color: Colors.grey, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: daftarMonster.length,
              itemBuilder: (context, index) {
                var monster = daftarMonster[index];
                return KartuMonster(monster: monster);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KartuMonster extends StatelessWidget {
  final Map<String, dynamic> monster;

  KartuMonster({required this.monster});

  // warna border berdasarkan elemen
  Color _getWarnaBorder(String element) {
    if (element == 'Api') return Colors.orange;
    if (element == 'Air') return Colors.blue;
    if (element == 'Es') return Colors.lightBlue;
    if (element == 'Petir') return Colors.yellow;
    if (element == 'Batu') return Colors.brown;
    if (element == 'Bayangan') return Colors.purple;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Color warnaBorder = _getWarnaBorder(monster['element']);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HalamanDetail(monster: monster),
          ),
        );
      },
      child: Card(
        color: Color(0xFF1E1E30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: warnaBorder, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: warnaBorder.withOpacity(0.15),
              ),
              child: ClipOval(
                child: Image.asset(
                  monster['gambar'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // kalau gambar ga ada, tampilkan icon
                    return Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: warnaBorder,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              monster['nama'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: warnaBorder.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                monster['element'],
                style: TextStyle(
                  fontSize: 12,
                  color: warnaBorder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanDetail extends StatelessWidget {
  final Map<String, dynamic> monster;

  HalamanDetail({required this.monster});

  Color _getWarnaElemen(String element) {
    if (element == 'Api') return Colors.orange;
    if (element == 'Air') return Colors.blue;
    if (element == 'Es') return Colors.lightBlue;
    if (element == 'Petir') return Colors.yellow;
    if (element == 'Batu') return Colors.brown;
    if (element == 'Bayangan') return Colors.purple;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Color warnaElemen = _getWarnaElemen(monster['element']);
    int level = monster['level'];
    double progressLevel = level / 100;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          monster['nama'],
          style: TextStyle(color: warnaElemen, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: warnaElemen),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // bagian atas - gambar monster
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A1A2E),
                    warnaElemen.withOpacity(0.2),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: warnaElemen.withOpacity(0.15),
                      border: Border.all(color: warnaElemen, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: warnaElemen.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        monster['gambar'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.catching_pokemon,
                            size: 80,
                            color: warnaElemen,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    monster['nama'],
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: warnaElemen.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: warnaElemen, width: 1),
                    ),
                    child: Text(
                      '⚡ Elemen: ${monster['element']}',
                      style: TextStyle(
                        color: warnaElemen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // bagian bawah - info detail
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // deskripsi
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E30),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📜 Deskripsi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warnaElemen,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          monster['deskripsi'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade300,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // atribut-atribut
                  Text(
                    '🛡️ Atribut Monster',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),

                  // baris atribut
                  Row(
                    children: [
                      Expanded(
                        child: _AtributBox(
                          judul: 'Power',
                          isi: monster['power'],
                          ikon: Icons.flash_on,
                          warna: warnaElemen,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _AtributBox(
                          judul: 'Habitat',
                          isi: monster['habitat'],
                          ikon: Icons.place,
                          warna: warnaElemen,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // level dengan progress bar
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E30),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: warnaElemen.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '⭐ Level Monster',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$level / 100',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warnaElemen,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progressLevel,
                            minHeight: 14,
                            backgroundColor: Colors.grey.shade800,
                            valueColor: AlwaysStoppedAnimation<Color>(warnaElemen),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          _getLevelText(level),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // tombol kembali
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warnaElemen.withOpacity(0.3),
                        side: BorderSide(color: warnaElemen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '← Kembali ke Daftar',
                        style: TextStyle(color: warnaElemen, fontSize: 15),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLevelText(int level) {
    if (level >= 90) return 'Sangat Kuat - Hampir Tidak Bisa Dikalahkan!';
    if (level >= 75) return 'Kuat - Butuh Strategi yang Bagus';
    if (level >= 60) return 'Sedang - Masih Bisa Dilawan';
    return 'Lemah - Mudah Dikalahkan';
  }
}

// widget kecil untuk atribut
class _AtributBox extends StatelessWidget {
  final String judul;
  final String isi;
  final IconData ikon;
  final Color warna;

  _AtributBox({
    required this.judul,
    required this.isi,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, size: 16, color: warna),
              SizedBox(width: 5),
              Text(
                judul,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            isi,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
