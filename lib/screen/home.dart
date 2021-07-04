import 'package:beamin_clone/layouts/defalut_layout.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Container(child: Text('hello'),),
    );
  }
}
