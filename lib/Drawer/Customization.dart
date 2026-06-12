import 'package:flutter/material.dart';



class Customization extends StatefulWidget {
  @override
  _CustomizationState createState() => _CustomizationState();
}

class _CustomizationState extends State<Customization> {
  double _redValue = 0.0;
  double _greenValue = 0.0;
  double _blueValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Color Changer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromRGBO(
                _redValue.toInt(),
                _greenValue.toInt(),
                _blueValue.toInt(),
                1.0,
              ),
              child: Center(
                child: Text(
                  'Change the background color using sliders',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Adjust Red Value'),
                Slider(
                  value: _redValue,
                  min: 0.0,
                  max: 255.0,
                  onChanged: (value) {
                    setState(() {
                      _redValue = value;
                    });
                  },
                  activeColor: Colors.red,
                  inactiveColor: Colors.red.withOpacity(0.3),
                ),
                Text('Adjust Green Value'),
                Slider(
                  value: _greenValue,
                  min: 0.0,
                  max: 255.0,
                  onChanged: (value) {
                    setState(() {
                      _greenValue = value;
                    });
                  },
                  activeColor: Colors.green,
                  inactiveColor: Colors.green.withOpacity(0.3),
                ),
                Text('Adjust Blue Value'),
                Slider(
                  value: _blueValue,
                  min: 0.0,
                  max: 255.0,
                  onChanged: (value) {
                    setState(() {
                      _blueValue = value;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveColor: Colors.blue.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
