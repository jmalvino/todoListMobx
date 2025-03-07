import 'package:flutter/material.dart';
import 'package:todo_mobx/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/stores/login_store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore() ,
      child: MaterialApp(
        title: "MobX Tutorial",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

