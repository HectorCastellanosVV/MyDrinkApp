import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/models/user_model.g.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:mydrink_app/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<User>('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyDrinkApp(),
    );
  }
}

class MyDrinkApp extends StatefulWidget {
  const MyDrinkApp({super.key});

  @override
  State<MyDrinkApp> createState() => _MyDrinkAppState();
}

class _MyDrinkAppState extends State<MyDrinkApp> {
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
