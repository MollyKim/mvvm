import 'package:beamin_clone/service/root_service.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  /// 네트워크 서비스
  final RootService services;

  BaseController(
      RootService rootService,
      ) : this.services = rootService;
}
