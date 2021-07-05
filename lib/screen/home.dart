import 'package:beamin_clone/controllers/counter_controller.dart';
import 'package:beamin_clone/controllers/login_controller.dart';
import 'package:beamin_clone/layouts/defalut_layout.dart';
import 'package:beamin_clone/themes/theme_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final CounterController _counterController = Get.find();

  bool flag = false;
  var count = 0;

  void incrementCounter() {
    count++;
  }

  Future login() async {
    final resp = await Get.find<LoginController>().loginInfos(
      userid: 'phil',
      userpwd: 'qweqwe123',
      os_div: 'E',
    );
    if (resp!.RESP_CD == 200) {
      flag = true;
    }
    return flag;
  }

  renderCounter() {
    return GetBuilder<CounterController>(
      builder: (c) {
        return Container(
          child: Text('CounterController count : ' +
              _counterController.count.toString()),
        );
      },
    );
  }

  renderRxCounter() {
    return Container(
      child: Text('RxCounter : ' + _counterController.rxCount.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeFactory.of(context).theme;
    return DefaultLayout(
      body: Column(
        children: [
          Container(
            child: Text(
              'hello',
              style: TextStyle(
                  color: theme.greyPrimaryTextColor,
                  fontFamily: 'SpoqaHanSansNeo',
                  fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                flag = await login();
              },
              child: Text('버튼이에요'))
        ],
      ),
    );
  }
}
