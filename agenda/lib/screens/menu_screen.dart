import 'package:agenda/screens/categoria_contacto.dart';
import 'package:agenda/screens/contact_screen.dart';
import 'package:agenda/screens/sobre_nosotros.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_jPtVKDK27wf9MGaMbEDOoYGu86pz9w-rKw&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ82O2EpcZ7SgkSptrDKeQM-AEwKf_sBGcJg&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS93ySLR-bYRjTTE_drwgP5upOoQk3bqyx9ZQ&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjoJ5H2TvSMMZm1kmDrM2SokvFfmgfZkxHRg&usqp=CAU',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Addme'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(145, 200, 228, 1.0),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IntrinsicWidth(
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  // Acciones al seleccionar un elemento del menú desplegable
                  switch (value) {
                    case 'categoria':
                      // Navegar al nuevo screen al presionar el botón flotante
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriaContact(
                                  title: 'Categoria de Contactos',
                                )),
                      );
                      break;
                    case 'lista':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactoScreen()),
                      );
                      break;
                    case 'sobre_nosotros':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUs()),
                      );
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'categoria',
                    child: Container(
                      color: Colors.blue, // Fondo azul del elemento del menú
                      padding: const EdgeInsets.all(8),
                      child: const ListTile(
                        title: Text(
                          'Categoría de contactos',
                          style: TextStyle(color: Colors.white), // Texto blanco
                        ),
                        leading: Icon(Icons.category, color: Colors.white),
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'lista',
                    child: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(8),
                      child: const ListTile(
                        title: Text(
                          'Lista de Contactos',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Icon(Icons.list, color: Colors.white),
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'sobre_nosotros',
                    child: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(8),
                      child: const ListTile(
                        title: Text(
                          'Sobre nosotros',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Icon(Icons.info, color: Colors.white),
                      ),
                    ),
                  ),
                ],
                child: Container(
                  color: Colors
                      .blue, // Color de fondo azul del botón de activación
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: const Icon(Icons.menu,
                      color: Colors.white), // Icono de menú blanco
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: imageUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Texto creativo
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '¡Explora el mundo de tus contactos!\nDescubre nuevas conexiones y experiencias.',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // DataTable de recordatorios
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Recordatorios',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  DataTable(
                    columns: const [
                      DataColumn(
                          label: Text('Fecha',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Recordatorio',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('12/12/2023')),
                        DataCell(Text('Reunión de trabajo')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('12/12/2023')),
                        DataCell(Text('Llamada con cliente')),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
