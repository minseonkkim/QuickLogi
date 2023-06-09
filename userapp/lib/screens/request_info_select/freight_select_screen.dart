import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:quick_logi/models/FreightInfo.dart';
import 'package:quick_logi/utilities/components.dart';
import 'package:quick_logi/utilities/constants.dart';

int freightIndex = 1;

final List<FreightInfo> freightList = <FreightInfo>[
  FreightInfo(
      item: '일반화물',
      type: 'DRY',
      width: '0',
      length: '0',
      height: '0',
      unit: 'm',
      weight: '0',
      num: '0')
];

class FreightSelectScreen extends StatefulWidget {
  const FreightSelectScreen({super.key});

  @override
  State<FreightSelectScreen> createState() => _FreightSelectScreenState();
}

class _FreightSelectScreenState extends State<FreightSelectScreen> {
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
                itemCount: freightList.length,
                itemBuilder: (context, index) {
                  return FreightInfoForm(
                    name: index,
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    freightIndex++;
                    freightList.add(FreightInfo(
                        item: '일반화물',
                        type: 'DRY',
                        width: '0',
                        length: '0',
                        height: '0',
                        unit: 'm',
                        weight: '0',
                        num: '0'));
                  });
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
        child: ConstrainedBox(
          constraints:
              BoxConstraints.tightFor(width: double.infinity, height: 50),
          child: ElevatedButton(
            onPressed: () {
              if (freightList.length > 1) {
                String res =
                    '${freightList[0].item} (${freightList[0].type}) ${freightList[0].width}${freightList[0].unit} X ${freightList[0].length}${freightList[0].unit} X ${freightList[0].num}${freightList[0].unit} ${freightList[0].num}개';
                for (int i = 1; i < freightList.length; i++) {
                  res +=
                      '\n${freightList[i].item} (${freightList[i].type}) ${freightList[i].width}${freightList[i].unit} X ${freightList[i].length}${freightList[i].unit} X ${freightList[i].num}${freightList[i].unit} ${freightList[i].num}개';
                }
                Get.back(result: res);
              } else {
                Get.back(
                    result:
                        '${freightList[0].item} (${freightList[0].type}) ${freightList[0].width}${freightList[0].unit} X ${freightList[0].length}${freightList[0].unit} X ${freightList[0].num} ${freightList[0].num}개');
              }
            },
            style: ElevatedButton.styleFrom(
              primary: MAINCOLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            //minimumSize: Size(double.infinity, 50)),
            child: Text(
              '입력완료',
              style: TextStyle(
                  fontFamily: 'Pretendard', color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class FreightInfoForm extends StatefulWidget {
  final int name;
  FreightInfoForm({required this.name});
  @override
  State<FreightInfoForm> createState() => _FreightInfoFormState();
}

class _FreightInfoFormState extends State<FreightInfoForm> {
  final _itemList = ['일반화물', '냉동냉장', '화학제품류', '위험물', '공컨테이너', '기타'];
  final _typeList = ['DRY', 'REEFER', 'TANK', '기타'];
  final _lengthUnit = ['m', 'cm', 'mm'];

  @override
  Widget build(BuildContext context) {
    _FreightSelectScreenState? parent =
        context.findAncestorStateOfType<_FreightSelectScreenState>();

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
                  '화물' + (widget.name + 1).toString(),
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
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: GREY1,
              ),
            ),
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
                    value: freightList[widget.name].item,
                    items: _itemList.map((value) {
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
                        freightList[widget.name].item = value;
                      });
                    }),
              ),
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
                    value: freightList[widget.name].type,
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
                        freightList[widget.name].type = value;
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
              width: 70,
              child: TextField(
                  onChanged: (value) {
                    freightList[widget.name].width = value;
                  },
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
                  onChanged: (value) {
                    freightList[widget.name].length = value;
                  },
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
                  onChanged: (value) {
                    freightList[widget.name].height = value;
                  },
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
                    value: freightList[widget.name].unit,
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
                        freightList[widget.name].unit = value;
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
                  onChanged: (value) {
                    freightList[widget.name].weight = value;
                  },
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
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 120,
              child: TextField(
                  onChanged: (value) {
                    freightList[widget.name].num = value;
                  },
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
        )
      ]),
    );
  }
}
