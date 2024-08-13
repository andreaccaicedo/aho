import 'package:aho1/pages/admin/log/sign_in.dart';
import 'package:aho1/pages/admin/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aho1/conection/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login', // Pantalla de login inicial
      routes: {
        '/login': (context) => const LoginScreen(), // Ruta de login
        '/signIn': (context) => const SignIn(), // Ruta para SignIn
        '/homeAdmin': (context) =>
            const HomeAdminScreen(), // Ruta para la pantalla de administrador
      },
    );
  }
}

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Admin'),
      ),
      body: Center(
        child: Text('Bienvenido, Administrador'),
      ),
    );
  }
}
