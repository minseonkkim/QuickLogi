import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quick_logi/utilities/components.dart';
import 'package:quick_logi/utilities/constants.dart';

class FreightSelectScreen extends StatefulWidget {
  const FreightSelectScreen({super.key});

  @override
  State<FreightSelectScreen> createState() => _FreightSelectScreenState();
}

class _FreightSelectScreenState extends State<FreightSelectScreen> {
  int _formCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackTopBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '화물 정보',
                    style: TextStyle(
                        fontFamily: 'PretendardBold',
                        color: Colors.black,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '무엇을 보낼까요?',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: GREY2, shape: BoxShape.circle),
                child: Icon(
                  Icons.add_box_rounded,
                  size: 30,
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView(children: [
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _formCount,
                itemBuilder: (context, index) {
                  return FreightInfoForm(
                    index: index + 1,
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _formCount++;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  decoration: BoxDecoration(
                    color: LIGHT,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Text(
                    '+ 품목 추가',
                    style: TextStyle(
                        fontFamily: 'Pretendard', color: GREY1, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              )
            ]),
          ),
        ]),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: MAINCOLOR,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            '입력완료',
            style: TextStyle(
                fontFamily: 'Pretendard', color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class FreightInfoForm extends StatefulWidget {
  final int index;
  FreightInfoForm({required this.index});
  @override
  State<FreightInfoForm> createState() => _FreightInfoFormState();
}

class _FreightInfoFormState extends State<FreightInfoForm> {
  final _typeList = [
    '타입',
    'Pallets',
    'Boxes',
    'Cartons',
    'Crates',
    'Drums',
    'Bags',
    'Bales',
    'Bundles',
    'Cans',
    'Carboys',
    'Carpets',
    'Cases',
    'Coils',
    'Cylinders',
    'Loose',
    'Pails',
    'Reels',
    'Rolls',
    'Tubes',
    'Pipes',
    'Other'
  ];
  String? _selectedType = '타입';

  final _lengthUnit = ['m', 'cm', 'mm'];
  String? _selectedLengthUnit = 'm';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: GREY2,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '화물' + widget.index.toString(),
                  style: TextStyle(
                      fontFamily: 'PretendardBold',
                      color: Colors.black,
                      fontSize: 22),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.edit,
                  color: GREY1,
                )
              ],
            ),
            Icon(
              Icons.delete,
              color: GREY1,
            )
          ],
        ),
        SizedBox(
          height: 13,
        ),
        Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: GREY2,
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: DropdownButton(
                    dropdownColor: GREY2,
                    value: _selectedType,
                    items: _typeList.map((value) {
                      return DropdownMenuItem(
                        child: Text(
                          value,
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    }),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 120,
              child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  decoration: InputDecoration(
                      hintText: '수량',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(3))),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              width: 70,
              child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  decoration: InputDecoration(
                      hintText: '가로',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(3))),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 70,
              child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  decoration: InputDecoration(
                      hintText: '세로',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(3))),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 70,
              child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  decoration: InputDecoration(
                      hintText: '높이',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(3))),
            ),
            SizedBox(
              width: 10,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: GREY2,
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: DropdownButton(
                    dropdownColor: GREY2,
                    value: _selectedLengthUnit,
                    items: _lengthUnit.map((value) {
                      return DropdownMenuItem(
                        child: Text(
                          value,
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLengthUnit = value;
                      });
                    }),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              width: 100,
              child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  decoration: InputDecoration(
                      hintText: '중량',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(3))),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'kg',
              style: TextStyle(
                  fontFamily: 'Pretendard', color: Colors.black, fontSize: 18),
            )
          ],
        )
      ]),
    );
  }
}
