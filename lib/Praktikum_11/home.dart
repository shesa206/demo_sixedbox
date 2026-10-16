import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tasbihcontroler.dart';

class Home extends StatelessWidget {
  Home({super.key});

  // Inisialisasi controller GetX (disesuaikan dengan TasbihController)
  final TasbihController controller = Get.put(TasbihController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 210, 145),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Angka hitungan (otomatis diperbarui oleh Obx)
              Obx(
                    () => Text(
                  '${controller.counter.value.round()}',
                  style: const TextStyle(
                    fontSize: 250,
                  ),
                ),
              ),
              // Progress bar (otomatis diperbarui oleh Obx)
              Obx(
                    () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: LinearProgressIndicator(
                    value: controller.progress.value / 100,
                    backgroundColor: Colors.white54,
                    color: Colors.amberAccent.shade400,
                    minHeight: 15,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 75),
              // Tombol tasbih
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: InkWell(
                  onTap: controller.incrementCounter,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.all(30),
                    child: const Icon(
                      Icons.fingerprint,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Tombol reset
      floatingActionButton: FloatingActionButton(
        onPressed: controller.resetCounter,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.refresh_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}