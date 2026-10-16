import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// ================= Model ScreenArguments =================
class ScreenArguments {
  final String cover;
  final String title;
  final String description;
  final String shortDesc;

  ScreenArguments(this.cover, this.title, this.description, this.shortDesc);
}

// ================= Main App =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0081c9),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        Tujuan.routeName: (context) => const Tujuan(),
      },
    );
  }
}

// ================= Halaman Home =================
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var title, thumbnail, short_description, description;
  var genre, platform, release, cover, gameid, publisher;

  Future getGame(String gameid) async {
    http.Response response = await http.get(
      Uri.parse('https://www.freetogame.com/api/game?id=$gameid'),
    );
    var results = jsonDecode(response.body);

    setState(() {
      this.gameid = gameid;
      title = results['title'];
      thumbnail = results['thumbnail'];
      short_description = results['short_description'];
      description = results['description'];
      genre = results['genre'];
      platform = results['platform'];
      publisher = results['publisher'];
      release = results['release_date'];
      cover = results['screenshots'][0]['image'];
    });
  }

  @override
  void initState() {
    super.initState();
    getGame('475'); // ID Game Forza Motorsport 6: Apex
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081c9),
      body: SafeArea(
        child: Center(
          child: gameid == null
              ? const CircularProgressIndicator(color: Colors.white)
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Tujuan.routeName,
                    arguments: ScreenArguments(
                      cover,
                      title,
                      description,
                      short_description,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(thumbnail),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        title ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Genre: $genre"),
                              Text("Platform: $platform"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Publisher: $publisher"),
                              Text("Release: $release"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= Halaman Tujuan / Detail =================
class Tujuan extends StatelessWidget {
  const Tujuan({super.key});

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    final args =
    ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF94A29),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F8FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          args.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        args.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        args.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0081c9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 15,
                              color: Color(0xFFF4F8FB),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Kembali ke game',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFF4F8FB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}