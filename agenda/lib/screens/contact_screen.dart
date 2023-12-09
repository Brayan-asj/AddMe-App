import 'dart:async';
import 'dart:typed_data' as td;
import 'package:agenda/screens/categoria_contacto.dart';
import 'package:agenda/screens/chat_screen.dart';
import 'package:agenda/screens/contact_register.dart';
import 'package:agenda/screens/galeria_screen.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactoScreen extends StatefulWidget {
  const ContactoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ContactoScreen> {
  List<Contact> _contacts = const [];
  String? _text;

  bool _isLoading = false;

  List<ContactField> _fields = ContactField.values.toList();

  final _ctrl = ScrollController();

  Future<void> loadContacts() async {
    try {
      await Permission.contacts.request();
      _isLoading = true;
      if (mounted) setState(() {});
      final sw = Stopwatch()..start();
      _contacts = await FastContacts.getAllContacts(fields: _fields);
      sw.stop();
    } on PlatformException catch (e) {
      _text = 'Failed to get contacts:\n${e.details}';
    } finally {
      _isLoading = false;
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar al nuevo screen al presionar el botón flotante
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Contactos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            tooltip: 'Categoría de Contactos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const CategoriaContact(title: 'Categoria Contacto')),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: loadContacts,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.refresh),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Cargar Contactos'),
              ],
            ),
          ),
          ExpansionTile(
            title: Row(
              children: [
                const Text('Mostrar:'),
                const SizedBox(width: 8),
                const Spacer(),
                TextButton(
                  child: Row(
                    children: [
                      if (_fields.length == ContactField.values.length) ...[
                        const Icon(Icons.check),
                        const SizedBox(width: 8),
                      ],
                      const Text('All'),
                    ],
                  ),
                  onPressed: () => setState(() {
                    _fields = ContactField.values.toList();
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(_text ?? 'Pulsa en "Cargar Contactos" para ver',
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Expanded(
            child: Scrollbar(
              controller: _ctrl,
              interactive: true,
              thickness: 24,
              child: ListView.builder(
                controller: _ctrl,
                itemCount: _contacts.length,
                itemExtent: _ContactItem.height,
                itemBuilder: (_, index) =>
                    _ContactItem(contact: _contacts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  static const height = 86.0;

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final phones = contact.phones.map((e) => e.number).join(', ');
    final emails = contact.emails.map((e) => e.address).join(', ');
    final name = contact.structuredName;
    final nameStr = name != null
        ? [
            if (name.namePrefix.isNotEmpty) name.namePrefix,
            if (name.givenName.isNotEmpty) name.givenName,
            if (name.middleName.isNotEmpty) name.middleName,
            if (name.familyName.isNotEmpty) name.familyName,
            if (name.nameSuffix.isNotEmpty) name.nameSuffix,
          ].join(', ')
        : '';
    final organization = contact.organization;
    final organizationStr = organization != null
        ? [
            if (organization.company.isNotEmpty) organization.company,
            if (organization.department.isNotEmpty) organization.department,
            if (organization.jobDescription.isNotEmpty)
              organization.jobDescription,
          ].join(', ')
        : '';

    return SizedBox(
      height: height,
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => _ContactDetailsPage(
              contactId: contact.id,
            ),
          ),
        ),
        leading: _ContactImage(contact: contact),
        title: Text(
          contact.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (phones.isNotEmpty)
              Text(
                phones,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (emails.isNotEmpty)
              Text(
                emails,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (nameStr.isNotEmpty)
              Text(
                nameStr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (organizationStr.isNotEmpty)
              Text(
                organizationStr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

class _ContactImage extends StatefulWidget {
  const _ContactImage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  __ContactImageState createState() => __ContactImageState();
}

class __ContactImageState extends State<_ContactImage> {
  late Future<td.Uint8List?> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = FastContacts.getContactImage(widget.contact.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<td.Uint8List?>(
      future: _imageFuture,
      builder: (context, snapshot) => SizedBox(
        width: 56,
        height: 56,
        child: snapshot.hasData
            ? Image.memory(snapshot.data!, gaplessPlayback: true)
            : const Icon(Icons.account_box_rounded),
      ),
    );
  }
}

class _ContactDetailsPage extends StatefulWidget {
  const _ContactDetailsPage({
    Key? key,
    required this.contactId,
  }) : super(key: key);

  final String contactId;

  @override
  State<_ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<_ContactDetailsPage> {
  late Future<Contact?> _contactFuture;

  @override
  void initState() {
    super.initState();
    _contactFuture = FastContacts.getContact(widget.contactId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Contacto: ${widget.contactId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            tooltip: 'Abrir Chat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const GalleryScreen(title: 'Nuestra Galeria')),
              );
            },
            icon: const Icon(Icons.image),
            tooltip: 'Abrir Galeria',
          )
        ],
      ),
      body: FutureBuilder<Contact?>(
        future: _contactFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final error = snapshot.error;
          if (error != null) {
            return Center(child: Text('Error: $error'));
          }

          final contact = snapshot.data;
          if (contact == null) {
            return const Center(child: Text('Contacto no encontrado'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ContactImage(contact: contact),
                  const SizedBox(height: 16),
                  _buildSection('Nombre', contact.displayName),
                  _buildSection('Teléfonos',
                      _formatList(contact.phones, (e) => e.number)),
                  _buildSection('Correos Electrónicos',
                      _formatList(contact.emails, (e) => e.address)),
                  _buildSection('Nombre Estructurado',
                      _formatStructuredName(contact.structuredName)),
                  _buildSection('Organización',
                      _formatOrganization(contact.organization)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Llamar'),
        icon: const Icon(Icons.call),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content.isNotEmpty ? content : 'No disponible',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _formatList<T>(List<T> list, String Function(T) formatter) {
    return list.map(formatter).join(', ');
  }

  String _formatStructuredName(StructuredName? name) {
    if (name == null) return '';
    return [
      if (name.namePrefix.isNotEmpty) name.namePrefix,
      if (name.givenName.isNotEmpty) name.givenName,
      if (name.middleName.isNotEmpty) name.middleName,
      if (name.familyName.isNotEmpty) name.familyName,
      if (name.nameSuffix.isNotEmpty) name.nameSuffix,
    ].join(', ');
  }

  String _formatOrganization(Organization? organization) {
    if (organization == null) return '';
    return [
      if (organization.company.isNotEmpty) organization.company,
      if (organization.department.isNotEmpty) organization.department,
      if (organization.jobDescription.isNotEmpty) organization.jobDescription,
    ].join(', ');
  }
}
