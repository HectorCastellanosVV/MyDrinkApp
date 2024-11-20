import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydrink_app/models/user_model.dart';
import 'package:mydrink_app/screens/home_screen.dart';
import 'package:mydrink_app/services/user_services.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void loginClick() async {
    final user = await UserServices()
        .login(username: emailController.text, password: passController.text);
    if (user is User && user.token != null) {
      if (context.mounted) {
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                usuario: user,
              ),
            ));
      }
    } else {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //artboard
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ingresa tu usuario y contraseña para continuar',
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 56, 56, 56)),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Nombre de usuario',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width,
                height: 50,
                child: TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    //labelText: "Ingresa tu username",
                    
                    hintText: 'Username',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Contraseña',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width,
                height: 50,
                child: TextFormField(
                  controller: passController,
                  obscureText: isPasswordVisible,
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    //labelText: "Ingresa tu password",
                    hintText: 'Ingresa tu contraseña aquí',
                    suffixIcon: isPasswordVisible == false
                        ? const Icon(Icons.no_encryption_gmailerrorred)
                        : const Icon(Icons.remove_red_eye),
                    labelStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.40,
              ),
              Center(
                child: Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 148, 207, 255),
                      borderRadius: BorderRadius.circular(8)),
                  child: MaterialButton(
                    onPressed: () => {
                      loginClick(),
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
