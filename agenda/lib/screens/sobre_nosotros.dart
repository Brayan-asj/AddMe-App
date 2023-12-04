// ignore: unused_import
import 'dart:math';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            displayDialogAndroid(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Nosotros',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      ),
    );
  }
}

void displayDialogAndroid(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Contactos',
          style: TextStyle(fontSize: 30, height: 2),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromRGBO(145, 200, 228, 1.0),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Aplicacion realizada con el objetivo de tener un mejor control de los contactos guardados en el dispositivo. Desarrolladores:\n\n · Inzunza Pereyra Lizbeth \n · Solorzano Juarez Brayan \n · Sanchez Esquivel Israel ',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromRGBO(246, 244, 235, 1.0),
              side: const BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
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
        ],
      );
    },
  );
}
