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

  // Navega a la pantalla para agregar una nueva persona
  void _agregarPersona(BuildContext context) async {
    final nuevaPersona = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarPersonaScreen(),
      ),
    );

    if (nuevaPersona != null) {
      setState(() {
        _personas.add(nuevaPersona); // Agrega la nueva persona
      });
    }
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
        onPressed: () => _agregarPersona(context), // Navega al formulario
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

// Nueva pantalla para agregar persona
class AgregarPersonaScreen extends StatelessWidget {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _cuentaController = TextEditingController();

  AgregarPersonaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Persona'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _cuentaController,
              decoration: const InputDecoration(labelText: 'Cuenta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Crear una nueva persona y regresar a la pantalla anterior
                final nuevaPersona = Persona(
                  _nombreController.text,
                  _apellidoController.text,
                  _cuentaController.text,
                );
                Navigator.of(context).pop(nuevaPersona); // Devuelve la nueva persona
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
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

