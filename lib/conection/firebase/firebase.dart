import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseInit {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BuildContext context;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  FirebaseInit(this.context);

  Future<String?> getUserRole() async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) {
        throw Exception('UID del usuario no encontrado');
      }

      DatabaseReference adminRef = _dbRef.child('Admins').child(uid);
      DataSnapshot adminSnapshot = await adminRef.get();

      if (adminSnapshot.exists) {
        return 'Administrador';
      } else {
        throw Exception('Usuario no registrado como Administrador');
      }
    } catch (e) {
      print('Error al verificar el rol del usuario: $e');
      return 'Error al verificar el rol';
    }
  }

  Future<bool> verifyInRealtimeDatabase(String uid) async {
    DatabaseReference ref = _dbRef.child('Admins');
    DatabaseEvent snapshot = await ref.child(uid).once();

    if (snapshot.snapshot.value != null) {
      return true;
    } else {
      print('Datos del usuario no encontrados en Realtime Database');
      return false;
    }
  }

  void loginUser(
      String email, String password, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = userCredential.user!.uid;
        bool isAdmin = await verifyInRealtimeDatabase(uid);

        if (isAdmin) {
          Navigator.pushNamed(context, '/homeAdmin');
        } else {
          print('Error: el usuario no está registrado como Admin');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Error: el usuario no está registrado como Admin')),
          );
        }
      } on FirebaseAuthException catch (e) {
        print('Error al iniciar sesión: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: ${e.message}')),
        );
      }
    }
  }

  void logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión: $e')),
      );
    }
  }

  Future<Map<String, String>> fetchAdminData() async {
    try {
      String? uid = _auth.currentUser?.uid;

      if (uid == null) {
        throw Exception('El UID del usuario es nulo');
      }

      DatabaseEvent snapshot =
          await _dbRef.child('Admins').child(uid).child('datos').once();

      if (snapshot.snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);

        return {
          'adminName': data['adminName'] ?? 'Nombre no disponible',
          'adminRole': data['adminRole'] ?? 'Rol no disponible',
          'email': data['email'] ?? 'Email no disponible',
          'companyName':
              data['companyName'] ?? 'Nombre de la empresa no disponible',
          'phoneNumber':
              data['phoneNumber'] ?? 'Número de teléfono no disponible',
        };
      } else {
        throw Exception('Datos del administrador no encontrados');
      }
    } catch (e) {
      print('Error al obtener los datos del administrador: $e');
      return {
        'adminName': 'Nombre no disponible',
        'adminRole': 'Rol no disponible',
        'email': 'Email no disponible',
        'companyName': 'Nombre de la empresa no disponible',
        'phoneNumber': 'Número de teléfono no disponible',
      };
    }
  }

  void loadAdminData(
    ValueNotifier<String?> adminName,
    ValueNotifier<String?> adminRole,
    ValueNotifier<String?> email,
    ValueNotifier<String?> companyName,
    ValueNotifier<String?> phoneNumber,
  ) async {
    try {
      Map<String, String> adminData = await fetchAdminData();
      adminName.value = adminData['adminName'];
      adminRole.value = adminData['adminRole'];
      email.value = adminData['email'];
      companyName.value = adminData['companyName'];
      phoneNumber.value = adminData['phoneNumber'];
    } catch (e) {
      print("Error al cargar los datos del administrador: $e");
    }
  }

  Future<void> registerUserAdmin(
    String email,
    String password,
    String companyName,
    String adminName,
    String phoneNumber,
    GlobalKey<FormState> formKey,
  ) async {
    if (!formKey.currentState!.validate()) return;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;

        await _dbRef.child('Admins').child(uid).child('datos').set({
          'email': email,
          'companyName': companyName,
          'adminName': adminName,
          'phoneNumber': phoneNumber,
        });

        Navigator.of(context).pushReplacementNamed('/login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Se ha registrado correctamente')),
        );
      }
    } catch (e) {
      print('Error al registrar el usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar el usuario: $e')),
      );
    }
  }
}
