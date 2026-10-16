import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Card',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sedang memutar'),
          centerTitle: true,
        ),
        body: const Center(
          child: MusicCard(),
        ),
      ),
    );
  }
}

class MusicCard extends StatefulWidget {
  const MusicCard({super.key});

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cover album (ikon lingkaran)
            Container(
              width: 220,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey[600],
                  child: const Icon(
                    Icons.album,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // jarak tetap antara cover dan info lagu
            Row(
              children: [
                // Judul lagu & nama artis
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Di sini ada judul lagu',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4), // jarak tetap antara judul dan artis
                      Text(
                        'Di sini ada nama artis',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1), // jarak proporsional sebelum tombol like
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}