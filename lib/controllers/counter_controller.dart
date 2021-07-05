import 'package:get/get.dart';

class CounterController extends GetxController {
  int _count = 0;
  RxInt rxCount = 0.obs;
  int flutterCount = 3;

  int get count => _count;

  void rxIncrement() => rxCount++;
}
