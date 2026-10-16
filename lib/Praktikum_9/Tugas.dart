import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

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
          seedColor: const Color.fromARGB(255, 119, 210, 145),
        ),
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late ValueNotifier<double> _valueNotifier;
  late double counter;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(0.0);
    counter = 0.0;
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  void incrementCounter() {
    setState(() {
      if (counter < 33) {
        counter++;
        _valueNotifier.value = (counter / 33) * 100;
      }
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0.0;
      _valueNotifier.value = (counter / 33) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 210, 145),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Progress Bar dengan teks di dalamnya
              SimpleCircularProgressBar(
                progressColors: [Colors.amberAccent.shade400],
                size: 300,
                progressStrokeWidth: 20,
                backStrokeWidth: 10,
                mergeMode: true,
                maxValue: 100,
                animationDuration: 0,
                valueNotifier: _valueNotifier,
                onGetText: (value) {
                  // Menampilkan angka counter utama di tengah lingkaran
                  return Text(
                    '${counter.round()}',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),

              // Tombol Fingerprint dengan efek Material & InkWell yang benar
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  onTap: incrementCounter,
                  borderRadius: BorderRadius.circular(50),
                  child: const ContainerPadding(
                    child: Icon(
                      Icons.fingerprint,
                      size: 100,
                      color: Color.fromARGB(255, 119, 210, 145),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetCounter,
        child: const Icon(Icons.refresh_outlined),
      ),
    );
  }
}

// Helper kecil untuk padding tombol fingerprint
class ContainerPadding extends StatelessWidget {
  final Widget child;
  const ContainerPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: child,
    );
  }
}