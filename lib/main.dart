import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UnitConverter(),
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.pink),
        ),
      ),
    );
  }
}

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'Meter';
  String _toUnit = 'Foot';
  double _result = 0.0;

  Map<String, double> unitMap = {
    'Meter': 1.0,
    'Foot': 3.28084,
    'Inch': 39.3701,
    'Centimeter': 100.0,
    'Kilometer': 0.001,
    'Yard': 1.09361,
  };

  void _convert() {
    if (_inputController.text.isEmpty) {
      setState(() {
        _result = 0.0;
      });
      return;
    }

    double inputValue = double.parse(_inputController.text);
    double conversionFactor = unitMap[_fromUnit]! / unitMap[_toUnit]!;

    setState(() {
      _result = inputValue * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Convertor Application', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(56.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter a value in $_fromUnit',
                    labelStyle: TextStyle(color: Colors.pink),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _fromUnit,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _fromUnit = newValue;
                      });
                    }
                  },
                  items: unitMap.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.pink,fontSize: 26)),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Convert to:', style: TextStyle(color: Colors.pink,fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _toUnit,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _toUnit = newValue;
                      });
                    }
                  },
                  items: unitMap.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.pink,fontSize: 26)),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  onPressed: _convert,
                  child: Text('Convert'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink),
                    alignment: Alignment.center,
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Result: $_result $_toUnit',
                  style: TextStyle(color: Colors.pink, fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
