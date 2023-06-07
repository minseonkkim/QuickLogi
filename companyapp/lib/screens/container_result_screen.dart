import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/calculation_screen.dart';

class Box {
  double width;
  double length;
  TextEditingController widthController;
  TextEditingController lengthController;

  Box(this.width, this.length, this.widthController, this.lengthController);
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

class ContainerResultScreen extends StatefulWidget {
  @override
  ContainerResultScreenState createState() => ContainerResultScreenState();
}

class ContainerResultScreenState extends State<ContainerResultScreen> {
  List<Box> boxes = [Box(0, 0, TextEditingController(), TextEditingController())];
  BoxContainer container = BoxContainer(2.6, 5.89);

  void _addNewBox() {
    setState(() {
      boxes.add(Box(0, 0, TextEditingController(), TextEditingController()));
    });
  }

  void _calculateAndShow(BuildContext context) {
    for (var box in boxes) {
      double width = double.tryParse(box.widthController.text) ?? 0;
      double length = double.tryParse(box.lengthController.text) ?? 0;
      container.addBox(Box(width, length, TextEditingController(), TextEditingController()));
    }
    List<List<Box>> result = container.pack();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CalculationScreen(result: result, container: container)));
  }

  void _resetBoxes() {
    setState(() {
      boxes.clear();
      boxes.add(Box(0, 0, TextEditingController(), TextEditingController()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _resetBoxes, // Add the reset function to the button
            tooltip: 'Reset Boxes', // Tooltip for the button
            child: Icon(Icons.refresh), // Icon for the button
          ),
        ],
      ),
    );
  }
}

class CalculationScreen extends StatefulWidget {
  final List<List<Box>> result;
  final BoxContainer container;

  CalculationScreen({required this.result, required this.container});

  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  List<Rect> placedBoxes = [];

  BoxContainer get container => widget.container;

  @override
  void initState() {
    super.initState();
    _placeBoxes();
  }

  void _placeBoxes() {
    placedBoxes.clear();

    double containerWidth = 260;
    double containerHeight = 589;

    double currentLeft = 0;
    double currentTop = 0;
    double maxRowHeight = 0;

    for (List<Box> row in widget.result) {
      for (Box box in row) {
        double boxWidth = box.width;
        double boxHeight = box.length;

        // Check if the box fits in the current row
        if (currentLeft + boxWidth > containerWidth) {
          // Move to the next row
          currentLeft = 0;
          currentTop += maxRowHeight + 1; // Set the vertical gap between rows to 1
          maxRowHeight = 0;
        }

        // Check if the box fits in the container vertically
        if (currentTop + boxHeight > containerHeight) {
          // Skip placing the box as it doesn't fit in the container
          continue;
        }

        // Place the box
        Rect newBoxRect = Rect.fromLTWH(currentLeft, currentTop, boxWidth, boxHeight);
        placedBoxes.add(newBoxRect);

        // Update current position and max row height
        currentLeft += boxWidth + 1; // Set the horizontal gap between boxes to 1
        maxRowHeight = max(maxRowHeight, boxHeight);
      }
    }
  }

  void _clearPlacedBoxes() {
    setState(() {
      placedBoxes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculation Screen')),
      body: Center(
        child: Container(
          width: 260,
          height: 589,
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                width: 260,
                height: 589,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
              ),
              for (int i = 0; i < widget.result.length; i++)
                for (int j = 0; j < widget.result[i].length; j++)
                  Positioned(
                    left: placedBoxes[i * widget.result[i].length + j].left,
                    top: placedBoxes[i * widget.result[i].length + j].top,
                    child: Container(
                      width: placedBoxes[i * widget.result[i].length + j].width,
                      height: placedBoxes[i * widget.result[i].length + j].height,
                      color: colors[Random().nextInt(colors.length)],
                      child: Center(
                        child: Text(
                          'Box ${i * widget.result[i].length + j + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearPlacedBoxes, // Add the clear function to the button
        tooltip: 'Clear Boxes', // Tooltip for the button
        child: Icon(Icons.clear_all), // Icon for the button
      ),
    );
  }
}