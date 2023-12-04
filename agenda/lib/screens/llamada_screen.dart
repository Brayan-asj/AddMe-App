import 'package:flutter/material.dart';

class LlamadaScreen extends StatelessWidget {
  const LlamadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hacer Llamada",
          style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: const Color.fromRGBO(
            145, 200, 228, 1.0), // Cambiar el color del AppBar
        centerTitle: true,
      ),
      backgroundColor:
          Colors.black, // Establecer el color de fondo de la pantalla
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 100,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.red, // Cambiar a fondo rojo
                    side: const BorderSide(
                        width: 2.0,
                        color: Colors.black), // Grosor y color del contorno
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5), // Aumentar el espacio horizontal
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5), // Radio de la esquina del botón
                    ),
                  ),
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40, // Aumentar el espacio entre los botones
                ),
                TextButton(
                  onPressed: () {
                    // Lógica para el segundo botón
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color.fromARGB(
                        255, 59, 241, 18), // Color del texto
                    side: const BorderSide(
                        width: 2.0,
                        color: Colors.black), // Grosor y color del contorno
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5), // Aumentar el espacio horizontal
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5), // Radio de la esquina del botón
                    ),
                  ),
                  child: const Text(
                    'Llamar',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
