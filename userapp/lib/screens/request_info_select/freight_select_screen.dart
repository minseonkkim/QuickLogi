import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quick_logi/utilities/components.dart';
import 'package:quick_logi/utilities/constants.dart';

int freightIndex = 1;
//final List<int> freightList = [1];
final List<FreightInfoForm> freightList = <FreightInfoForm>[
  FreightInfoForm(
    name: freightIndex,
  )
];

class FreightSelectScreen extends StatefulWidget {
  const FreightSelectScreen({super.key});

  @override
  State<FreightSelectScreen> createState() => _FreightSelectScreenState();
}

class _FreightSelectScreenState extends State<FreightSelectScreen> {
  void removeFreightInfoForm(int name) {
    setState(() {
      freightList.removeWhere((form) => form.name == name);
    });
  }

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
                    name: freightList[index].name,
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
                    freightList.add(FreightInfoForm(name: freightIndex));
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
  final int name;
  FreightInfoForm({required this.name});
  @override
  State<FreightInfoForm> createState() => _FreightInfoFormState();
}

class _FreightInfoFormState extends State<FreightInfoForm> {
  final _itemList = ['일반화물', '냉동냉장', '화학제품류', '위험물', '공컨테이너', '기타'];
  String? _selectedItem = '일반화물';

  final _typeList = ['DRY', 'REEFER', 'TANK', '기타'];
  String? _selectedType = 'DRY';

  final _lengthUnit = ['m', 'cm', 'mm'];
  String? _selectedLengthUnit = 'm';

  List<TextEditingController> controllers = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void _removeController() {
    for (var controller in controllers) {
      controller.dispose();
    }
    controllers.clear(); // 컨트롤러 리스트 초기화
  }

  void removeForm() {
    _FreightSelectScreenState? parent =
        context.findAncestorStateOfType<_FreightSelectScreenState>();

    if (freightList.length > 1) {
      freightList.removeWhere((form) => form.name == widget.name);
      _removeController();
      parent!.setState(() {});
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _FreightSelectScreenState? parent =
        context.findAncestorStateOfType<_FreightSelectScreenState>();

    return Form(
      key: this.formKey,
      child: Container(
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
                    '화물' + widget.name.toString(),
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
                      value: _selectedItem,
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
                          _selectedItem = value;
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
                    controller: controllers[1],
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
                    controller: controllers[2],
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
                    controller: controllers[3],
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
                    controller: controllers[4],
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
                    fontFamily: 'Pretendard',
                    color: Colors.black,
                    fontSize: 18),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 120,
                child: TextField(
                    controller: controllers[0],
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
      ),
    );
  }
}
