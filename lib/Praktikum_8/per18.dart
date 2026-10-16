import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================= Model ScreenArguments =================
class ScreenArguments {
  final String title;
  final String subtitle;
  final String description;

  ScreenArguments(this.title, this.subtitle, this.description);
}

// ================= Main App =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        Tujuan.routeName: (context) => const Tujuan(),
      },
    );
  }
}

// ================= Halaman Home =================
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ini halaman Home',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: () {
                final args = ScreenArguments(
                  'Judul Game',
                  'Genre: Action',
                  'Ini adalah deskripsi singkat dari game.',
                );
                Navigator.pushNamed(
                  context,
                  Tujuan.routeName,
                  arguments: args,
                );
              },
              child: const Text('Ke Halaman Tujuan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= Halaman Tujuan =================
class Tujuan extends StatelessWidget {
  const Tujuan({super.key});

  static const routeName = '/tujuan';

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Tujuan')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                args.title,
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                args.subtitle,
                style: const TextStyle(
                    fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              Text(args.description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali ke Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}