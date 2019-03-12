import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _info = "Informe seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _info = "Informe seus dados";
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

    setState(() {
      if (imc < 18.6) {
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _info = "Peso Ideal (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.9 && imc <= 29.9) {
        _info = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.9 && imc <= 34.9) {
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 34.9 && imc <= 39.9) {
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 40) {
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculador IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reset,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.deepPurple),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (CM)",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe sua altura!";
                  }
                },
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 15, 0.0, 15),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.deepPurple,
                    ),
                  )),
              Text(_info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
