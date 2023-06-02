import 'package:flutter/material.dart';

class Box {
  double width;
  double height;

  Box({required this.width, required this.height});
}

class ContainerResultScreen extends StatelessWidget {
  final List<Box> boxes = <Box>[];
  final double containerWidth = 0.0;
  final double containerHeight = 0.0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Result'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Container Size: $containerWidth x $containerHeight',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            'Box Sizes:',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          for (var box in boxes)
            Text(
              '${box.width} x ${box.height}',
              style: TextStyle(fontSize: 18.0),
            ),
        ],
      ),
    );
  }
}

class BoxSelectionPage extends StatefulWidget {
  @override
  _BoxSelectionPageState createState() => _BoxSelectionPageState();
}

class _BoxSelectionPageState extends State<BoxSelectionPage> {
  List<Box> boxes = [];
  double containerWidth = 0.0;
  double containerHeight = 0.0;

  void _navigateToResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContainerResultScreen(

        ),
      ),
    );
  }

  void _resetBoxes() {
    setState(() {
      boxes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Box Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Container Size',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 120.0,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Width (m)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        containerWidth = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 120.0,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Height (m)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        containerHeight = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Box Sizes',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  boxes.add(Box(width: 0.0, height: 0.0));
                });
              },
              child: Text('Add Box'),
            ),
            SizedBox(height: 8.0),
            for (int index = 0; index < boxes.length; index++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 120.0,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Width (m)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            boxes[index].width = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      width: 120.0,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Height (m)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            boxes[index].height = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
               _navigateToResultPage();
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _resetBoxes();
              },
              child: Text('Reset Boxes'),
            ),
          ],
        ),
      ),
    );
  }
}
