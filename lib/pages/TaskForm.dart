import 'package:flutter/material.dart';

void main() => runApp(const TaskForm());

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  List<Map<String, dynamic>> list = [
    {"name": "Lunes", "id": 1},
    {"name": "Martes", "id": 2},
    {"name": "Miercoles", "id": 3},
    {"name": "Jueves", "id": 4},
    {"name": "Viernes", "id": 5},
    {"name": "Sabado", "id": 6},
    {"name": "Domingo", "id": 7}
  ];

  int currentId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar nueva tarea'),
        ),
        body: Form(
          child: ListView(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Nombre de la tarea",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Descripcion de la tarea (Opcional)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton<int>(
                value: currentId,
                icon: Icon(Icons.arrow_downward), // Icono desplegable
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    color: Colors.white), // Estilo del texto seleccionado
                underline: Container(
                  height: 2,
                  color: Colors.white, // Color de la línea debajo del menú desplegable
                ),
                onChanged: (int? newId) {
                  // Actualiza el ID seleccionado
                  setState(() {
                    currentId = newId!;
                  });
                },
                items: list
                    .map<DropdownMenuItem<int>>((Map<String, dynamic> item) {
                  return DropdownMenuItem<int>(
                    value: item["id"] as int,
                    child: Text(item["name"]
                        .toString()), // Muestra el nombre en el menú desplegable
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text("Crear tarea"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () => {},
              ),
            ],
          ),
        ));
  }
}
