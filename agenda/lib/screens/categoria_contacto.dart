import 'package:flutter/material.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

class CategoriaContact extends StatefulWidget {
  const CategoriaContact({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoriaContact> {
  final data = {
    "Categoria Familia": [
      "Lizbeth Inzunza",
      "Abraham De La Hoya",
      "Brayan Solórzano",
      "Israel Sánchez",
    ],
    "Categoria Amigos": [
      "Dagoberto Fiscal",
      "Isaac Reyes",
    ],
    "Categoria Trabajo": [
      "Fernanda Bonilla",
      "Luis Avalos",
      "María Guadalupe Morales",
      "Luis Valdes",
      "Fernando Rayas",
    ],
    "Categoria Conocidos": [
      "Diego Alvarez",
      "Edith Alvarado",
      "Abril Villarreal",
      "Daniel Mendoza",
      "Andrea Rios",
      "Alani Rios",
      "Fernando Alvarado",
      "Cesar Reyes",
      "Nashly Lujan",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ScrollableListTabScroller(
        itemCount: data.length,
        tabBuilder: (BuildContext context, int index, bool active) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            data.keys.elementAt(index),
            style: !active
                ? null
                : const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
        itemBuilder: (BuildContext context, int index) => Column(
          children: [
            Text(
              data.keys.elementAt(index),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            ...data.values
                .elementAt(index)
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        alignment: Alignment.center,
                        child: Text(index.toString()),
                      ),
                      title: Text(value),
                    ),
                  ),
                )
                .values
          ],
        ),
      ),
    );
  }
}
