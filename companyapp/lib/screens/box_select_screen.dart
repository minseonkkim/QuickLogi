import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_1/screens/calculation_screen.dart';

class Box {
  double width;
  double length;
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  Box(this.width, this.length);
}

class BoxContainer {
  double width;
  double length;
  List<Box> boxes = [];

  BoxContainer(this.width, this.length);

  void addBox(Box box) {
    this.boxes.add(box);
  }

  List<List<Box>> pack() {
    this.boxes.sort((a, b) => max(b.width, b.length).compareTo(max(a.width, a.length)));
    List<List<Box>> rows = [[]];
    for (Box box in this.boxes) {
      double minLength = double.infinity;
      List<Box>? minRow;
      for (List<Box> row in rows) {
        if (row.fold(0.0, (prev, element) => prev + element.width) + box.width <= this.width) {
          double remainingLength = max(box.length, row.isNotEmpty ? row.map((e) => e.length).reduce(max) : 0) - min(box.length, row.isNotEmpty ? row.map((e) => e.length).reduce(min) : 0);
          if (remainingLength < minLength) {
            minLength = remainingLength;
            minRow = row;
          }
        }
      }
      if (minRow != null) {
        minRow.add(box);
      } else {
        rows.add([box]);
      }
    }
    return rows;
  }
}

class BoxSelectScreen extends StatefulWidget {
  @override
  _BoxSelectScreenState createState() => _BoxSelectScreenState();
}

class _BoxSelectScreenState extends State<BoxSelectScreen> {
  List<Box> boxes = [Box(0, 0)];
  BoxContainer container = BoxContainer(2.6, 5.89);

  void _addNewBox() {
    setState(() {
      boxes.add(Box(0, 0));
    });
  }

  void _calculateAndShow(BuildContext context) {
    for (var box in boxes) {
      double width = double.tryParse(box.widthController.text) ?? 0;
      double length = double.tryParse(box.lengthController.text) ?? 0;
      container.addBox(Box(width, length));
    }
    List<List<Box>> result = container.pack();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CalculationScreen(result: result, container: container)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: ListView.builder(
        itemCount: boxes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('Box ${index + 1}'),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: boxes[index].widthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Width'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: boxes[index].lengthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Length'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _addNewBox,
            tooltip: 'Add New Box',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _calculateAndShow(context),
            tooltip: 'Calculate',
            child: Icon(Icons.calculate),
          ),
        ],
      ),
    );
  }
}