import 'package:ch1/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        extendBody: true,
        bottomNavigationBar: Ch1BottomNavigationBarWithMainAction(
          iconsLength: 4,
          iconsSize: 24,
          iconAt: (index) => [
            Icons.ac_unit,
            Icons.access_alarm,
            Icons.accessible,
            Icons.account_balance,
          ].elementAt(index),
          mainAction: Icons.add,
          onMainActionTapped: () {},
          expansionHeight: 250,
          onTap: (int index) {},
          demoTitle: (index) => Text('$index | ' * 4),
          demoSubtitle: (index) => Text('$index | subtitle ' * 4),
        ),
        body: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
