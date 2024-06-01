import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

String numero = "";
String operador = "";
double res_numerico = 0;
String resultado = "";
TextEditingController _controller = TextEditingController(text: "");

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ContainerGrid(),
        ),
      ),
    );
  }
}

class ContainerGrid extends StatefulWidget {
  const ContainerGrid({super.key});

  @override
  _ContainerGridState createState() => _ContainerGridState();
}

class _ContainerGridState extends State<ContainerGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            controller: _controller,
            onChanged: (String src) {},
            autofocus: true,
            maxLength: 8,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calculate),
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              helperText: "Calculadoras Cordova",
              counterText: "Esto es solo una prueba",
              labelText: "Ingresa tu operacion",
              iconColor: Color.fromARGB(255, 133, 134, 61),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: "Arial",
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildColumn([
                buildContainer("1"),
                buildContainer("2"),
                buildContainer("3"),
                buildContainer("C"),
              ]),
              buildColumn([
                buildContainer("4"),
                buildContainer("5"),
                buildContainer("6"),
                buildContainer("0"),
              ]),
              buildColumn([
                buildContainer("7"),
                buildContainer("8"),
                buildContainer("9"),
                buildContainer("="),
              ]),
              buildColumn([
                buildContainer("+"),
                buildContainer("-"),
                buildContainer("x"),
                buildContainer("/"),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildColumn(List<Widget> containers) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: containers,
    );
  }

  Widget buildContainer(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (text == "C") {
            resultado = "";
            numero = "";
            operador = "";
            res_numerico = 0;
          } else if (text == "=") {
            if (operador.isNotEmpty && numero.isNotEmpty) {
              realizarOperacion(double.parse(numero));
              resultado = res_numerico.toString();
              operador = "";
              numero = "";
            }
          } else if (text == "+" || text == "-" || text == "x" || text == "/") {
            if (operador.isNotEmpty && numero.isNotEmpty) {
              realizarOperacion(double.parse(numero));
            } else if (numero.isNotEmpty) {
              res_numerico = double.parse(numero);
            }
            operador = text;
            numero = "";
            resultado += text;
          } else {
            numero += text;
            resultado += text;
          }
          _controller.text = resultado;
        });
      },
      child: Container(
        width: 70,
        height: 70,
        color: Colors.black,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void realizarOperacion(double num) {
    switch (operador) {
      case "+":
        res_numerico += num;
        break;
      case "-":
        res_numerico -= num;
        break;
      case "/":
        res_numerico /= num;
        break;
      case "x":
        res_numerico *= num;
        break;
    }
  }
}
