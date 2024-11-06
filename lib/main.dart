// import 'package:codeedexproject/provider/login_state.dart';
// import 'package:codeedexproject/view/homescreen.dart';
// import 'package:codeedexproject/view/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize Hive and open a box for session management
//   await Hive.initFlutter();
//   await Hive.openBox('session');
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => LoginProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Flutter App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (context) => LoginScreen(),
//           '/home': (context) => home(),
//         },
//       ),
//     );
//   }
// }
//
//
import 'package:codeedexproject/view/homescreen.dart';
import 'package:codeedexproject/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'model/login_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open a box for session management
  await Hive.initFlutter();
  await Hive.openBox('session');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop Products App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
