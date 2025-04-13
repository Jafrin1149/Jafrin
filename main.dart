import 'package:flutter/material.dart';

void main() => runApp(UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String fromUnit = 'Meter';
  String toUnit = 'Kilometer';
  String result = '';

  final List<String> units = ['Meter', 'Kilometer', 'Centimeter'];

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0.0;
    double converted = input;

    if (fromUnit == 'Meter' && toUnit == 'Kilometer') {
      converted = input / 1000;
    } else if (fromUnit == 'Kilometer' && toUnit == 'Meter') {
      converted = input * 1000;
    } else if (fromUnit == 'Meter' && toUnit == 'Centimeter') {
      converted = input * 100;
    } else if (fromUnit == 'Centimeter' && toUnit == 'Meter') {
      converted = input / 100;
    } else if (fromUnit == 'Kilometer' && toUnit == 'Centimeter') {
      converted = input * 100000;
    } else if (fromUnit == 'Centimeter' && toUnit == 'Kilometer') {
      converted = input / 100000;
    }

    setState(() {
      result = converted.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: fromUnit,
              isExpanded: true,
              onChanged: (value) => setState(() => fromUnit = value!),
              items:
                  units
                      .map(
                        (unit) =>
                            DropdownMenuItem(value: unit, child: Text(unit)),
                      )
                      .toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: toUnit,
              isExpanded: true,
              onChanged: (value) => setState(() => toUnit = value!),
              items:
                  units
                      .map(
                        (unit) =>
                            DropdownMenuItem(value: unit, child: Text(unit)),
                      )
                      .toList(),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(onPressed: _convert, child: Text('Convert')),
            SizedBox(height: 24),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
