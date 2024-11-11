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

  var animationLink = 'assets/animations/animated_login_character.riv';
  SMITrigger? failTrigger, successTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? lookNum;
  StateMachineController? stateMachineController;
  Artboard? artboard;
  @override
  void initState() {
    rootBundle.load(animationLink).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(art, "Login Machine");

      if (stateMachineController != null) {
        art.addController(stateMachineController!);
        for (var element in stateMachineController!.inputs) {
          if (element.name == "isChecking") {
            isChecking = element as SMIBool;
          } else if (element.name == "isHandsUp") {
            isHandsUp = element as SMIBool;
          } else if (element.name == "trigSuccess") {
            successTrigger = element as SMITrigger;
          } else if (element.name == "trigFail") {
            failTrigger = element as SMITrigger;
          } else if (element.name == "numLook") {
            lookNum = element as SMINumber;
          }
        }
      }
      setState(() => artboard = art);
    });
    super.initState();
  }

  void lookAround() {
    isChecking?.change(true);
    isHandsUp?.change(false);
    lookNum?.change(0);
  }

  void moveEyes(value) {
    lookNum?.change(value.length.toDouble());
  }

  void handsUpOnEyes() {
    isHandsUp?.change(!isHandsUp!.value);
    isChecking?.change(false);
    setState(() {});
  }

  void loginClick() async {
    isChecking?.change(false);
    isHandsUp?.change(false);
    final user = await UserServices()
        .login(username: emailController.text, password: passController.text);
    if (user is User && user.token != null) {
      successTrigger?.fire();
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
    } else {
      failTrigger?.fire();
    }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //artboard
            if (artboard != null)
              SizedBox(
                width: width,
                height: height * 0.3,
                child: Rive(artboard: artboard!),
              ),
            const SizedBox(
              height: 120,
            ),
            Container(
              width: 400,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                onTap: lookAround,
                onChanged: (value) => moveEyes(value),
                controller: emailController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  labelText: "Ingresa tu username",
                  hintText: 'Username',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                onTap: handsUpOnEyes,
                controller: passController,
                obscureText: isHandsUp?.value ?? false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: "Ingresa tu password",
                  hintText: 'Password',
                  suffixIcon: isHandsUp?.value ?? false
                      ? const Icon(Icons.no_encryption_gmailerrorred)
                      : const Icon(Icons.remove_red_eye),
                  labelStyle: const TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 252, 145, 246),
                  borderRadius: BorderRadius.circular(20)),
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
          ],
        ),
      ),
    );
  }
}
