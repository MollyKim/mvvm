import 'package:beamin_clone/controllers/base_controller.dart';
import 'package:beamin_clone/service/root_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Controller extends BaseController {
  Controller({required RootService rootService}) : super(rootService) {}
  var totalFlag = false.obs;
  var necessaryFlag = false.obs;
  var selectFlage = false.obs;

  totalFlagChange() {
    totalFlag.value = !totalFlag.value;
    necessaryFlag.value = totalFlag.value;
    selectFlage.value = totalFlag.value;
    print(' TEST  : ' + totalFlag.value.toString());
  }

  necessaryFlagChange() {
    necessaryFlag.value = !necessaryFlag.value;
  }

  selectFlageChange() {
    selectFlage.value = ! selectFlage.value;
  }
}
