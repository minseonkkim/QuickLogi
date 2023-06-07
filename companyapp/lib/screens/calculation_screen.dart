import 'package:flutter/material.dart';
import 'dart:math';

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

  @override
  void initState() {
    super.initState();
    placeBoxes();
  }

  void placeBoxes() {
    setState(() {
      placedBoxes.clear();

      for (List<Box> row in widget.result) {
        for (Box box in row) {
          Rect newBoxRect = calculateNewBoxRect(box);
          placedBoxes.add(newBoxRect);
        }
      }
    });
  }

  Rect calculateNewBoxRect(Box box) {
    double containerWidth = 260;
    double containerHeight = 589;

    double newBoxLeft = 0;
    double newBoxTop = 0;

    Rect newBoxRect = Rect.fromLTWH(newBoxLeft, newBoxTop, box.width, box.length);

    while (placedBoxes.any((placedBox) => newBoxRect.overlaps(placedBox))) {
      newBoxLeft += box.width + 1;
      if (newBoxLeft + box.width > containerWidth) {
        newBoxLeft = 0;
        newBoxTop += placedBoxes.last.bottom - placedBoxes.last.top + 10;
      }
      newBoxRect = Rect.fromLTWH(newBoxLeft, newBoxTop, box.width, box.length);
    }

    return newBoxRect;
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
    );
  }
}