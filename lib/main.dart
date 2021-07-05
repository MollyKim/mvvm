import 'package:beamin_clone/controllers/login_controller.dart';
import 'package:beamin_clone/screen/home.dart';
import 'package:beamin_clone/service/root_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(Root());
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();

    initControllers();
  }

  RootService initServices() {
    RootService rootService = RootService();
    return rootService;
  }

  void initControllers() {
    final services = initServices();
    Get.put(LoginController(rootService: services));
  }

  List<GetPage> renderPages() {
    final services = initServices();

    return [
      GetPage(
        name: '/',
        page: () => Home(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(() {
          Get.put(LoginController(rootService: services));
        }),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BeaminClone',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      getPages: renderPages(),
    );
  }
}
