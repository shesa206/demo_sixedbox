import 'package:get/get.dart';

class TasbihController extends GetxController {
  var counter = 0.0.obs; // variabel reaktif untuk hitungan
  var progress = 0.0.obs; // variabel reaktif untuk progress bar (0 - 100)
  final double maxCount = 33;

  void incrementCounter() {
    if (counter.value < maxCount) {
      counter.value++;
      progress.value = (counter.value / maxCount) * 100;
    }
  }

  void resetCounter() {
    counter.value = 0;
    progress.value = 0;
  }
}