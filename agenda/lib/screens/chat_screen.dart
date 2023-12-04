import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

List<Element> _elements = <Element>[
  Element(DateTime(2020, 6, 24, 9, 25), 'Hola, ¿cómo estás?'),
  Element(DateTime(2020, 6, 24, 9, 36), 'Bien, ¿qué tal tú?', true),
  Element(DateTime(2020, 6, 24, 9, 39), 'Estoy bien también'),
  Element(DateTime(2020, 6, 25, 14, 12), '¿Quieres ir al Cine?', true),
  Element(DateTime(2020, 6, 25, 14, 19), 'Claro, ¿a qué hora?'),
  Element(DateTime(2020, 6, 25, 14, 20), 'A las 8', true),
  Element(DateTime(2020, 6, 25, 14, 25), 'Okay allá te veo :)'),
  Element(DateTime(2020, 6, 27, 18, 41), 'Hola, ¿podrias ayudarme?'),
  Element(DateTime(2020, 6, 27, 18, 45), '¿Claro, qué necesitas?', true),
  Element(DateTime(2020, 6, 27, 18, 47), '¿Me pasas la tarea?'),
  Element(
    DateTime(2020, 6, 27, 18, 48),
    'No le entiendo a las mates :(',
  ),
  Element(DateTime(2020, 6, 27, 18, 56), 'Claro, te las envié por email', true),
];

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Addme',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sala de Chat'),
          backgroundColor: const Color.fromRGBO(145, 200, 228, 1.0),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 600,
              child: StickyGroupedListView<Element, DateTime>(
                elements: _elements,
                order: StickyGroupedListOrder.DESC,
                reverse: true,
                groupBy: (Element element) => DateTime(
                  element.date.year,
                  element.date.month,
                  element.date.day,
                ),
                floatingHeader: true,
                groupSeparatorBuilder: _getGroupSeparator,
                itemBuilder: _getItem,
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Escribe un nuevo mensaje',

                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 9, 111, 195),
                ), // Color del texto de la etiqueta
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGroupSeparator(Element element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 39, 168, 232),
            border: Border.all(
              color: Colors.blue[300]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.yMMMd().format(element.date),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem(BuildContext ctx, Element element) {
    return Align(
      alignment: element.swapped ? Alignment.centerRight : Alignment.centerLeft,
      child: SizedBox(
        width: 370,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: SizedBox(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: element.swapped
                  ? Text(DateFormat.Hm().format(element.date))
                  : const Icon(Icons.person),
              title: Text(element.name),
              trailing: element.swapped
                  ? const Icon(Icons.person_outline)
                  : Text(DateFormat.Hm().format(element.date)),
            ),
          ),
        ),
      ),
    );
  }
}

class Element implements Comparable {
  DateTime date;
  String name;
  bool swapped = false;

  Element(this.date, this.name, [this.swapped = false]);

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }
}
