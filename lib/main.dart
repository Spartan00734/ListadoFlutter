import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Lista de personas modificable
  List<Persona> _personas = [
    Persona('Pepito loko', 'Velázquez', '20196578'),
    Persona('Pedro', 'Iván', '20194989'),
    Persona('Fermin', 'Pascual', '20131414'),
    Persona('Max Steel', 'Ruíz', '20193419'),
    Persona('Diogom', 'Moran', '20184568'),
  ];

  // Método para agregar una persona a la lista
  void _agregarPersona() {
    setState(() {
      _personas.add(Persona('Nuevo', 'Usuario', '00000000'));
    });
  }

  // Método para eliminar una persona con confirmación
  void _eliminarPersona(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar persona'),
          content: Text('¿Estás seguro de eliminar a: ${_personas[index].name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo sin hacer nada
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _personas.removeAt(index); // Elimina la persona
                });
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Borrar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi primera chambaaaa'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarPersona,
        child: const Icon(Icons.people_alt_outlined),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _personas.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${_personas[index].name} ${_personas[index].lastName}'),
            subtitle: Text(_personas[index].cuenta),
            leading: CircleAvatar(
              child: Text(_personas[index].name.substring(0, 1)),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _eliminarPersona(index); // Llama a la función eliminar
              },
            ),
          );
        },
      ),
    );
  }
}

class Persona {
  String name;
  String lastName;
  String cuenta;

  Persona(this.name, this.lastName, this.cuenta);
}
