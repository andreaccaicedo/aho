import 'package:aho1/conection/firebase/firebase.dart';
import 'package:aho1/functions/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController adminNameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return Scaffold(
      body: SizedBox(
        width: responsive.width,
        height: responsive.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: responsive.hp(5)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: responsive.wp(70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: responsive.wp(70),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: companyNameController,
                          decoration: InputDecoration(
                            hintText: "Nombre de la Empresa",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            prefixIcon: Icon(Icons.business),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? dato) {
                            if (dato!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: responsive.wp(70),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Número de Teléfono",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            prefixIcon: Icon(Icons.phone),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? dato) {
                            if (dato!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: responsive.wp(70),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: adminNameController,
                          decoration: InputDecoration(
                            hintText: "Nombre del Administrador",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            prefixIcon: Icon(Icons.person),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? dato) {
                            if (dato!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: responsive.wp(70),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Correo",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            prefixIcon: Icon(Icons.verified_user),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? dato) {
                            if (dato!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: responsive.wp(70),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? dato) {
                            if (dato!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: responsive.wp(70),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: "Confirmar Contraseña",
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (String? dato) {
                            if (dato!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            if (dato != passwordController.text) {
                              return "Las contraseñas no coinciden";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: responsive.wp(73),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // TextButton(
                            //   onPressed: () {
                            //     // Acción para olvidar la contraseña
                            //   },
                            //   child: Text(
                            //     "¿Olvidó su contraseña?",
                            //     style: ThemeData().textTheme.bodySmall,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.merge(BorderSide.none,
                                BorderSide(color: Colors.grey)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          FirebaseInit firebase = FirebaseInit(context);
                          firebase.registerUserAdmin(
                              emailController.text,
                              passwordController.text,
                              companyNameController.text,
                              adminNameController.text,
                              phoneNumberController.text,
                              _formKey);
                        },
                        child: Text(
                          "Registrarse",
                          style: ThemeData().textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
