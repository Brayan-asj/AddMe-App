// import 'package:agenda/screens/contact_screen.dart';
import 'package:agenda/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  clearText() {
    usernameController.clear();
    passwordController.clear();
  }

  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('.:: Addme ::.'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(145, 200, 228, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 100,
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/b/b7/Google_Contacts_logo.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                hintText: 'Ingresa tu nombre de usuario',
                icon: Icon(Icons.person),
                suffixIcon: Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: obs,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Ingresa tu contraseña',
                icon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obs == true ? obs = false : obs = true;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 51, 130, 214)),
              ),
              onPressed: () {
                if (usernameController.text == 'utd' &&
                    passwordController.text == '1234') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuScreen()),
                  );
                  clearText();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Inténtalo de nuevo',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: const Text(
                        'Usuario o contraseña incorrectos.',
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 100, 236, 141)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              child:
                  const Text('Entrar', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
