import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quick_logi/utilities/constants.dart';

class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({super.key});

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  String _inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            TextField(
                style: const TextStyle(
                  fontSize: 20,
                ),
                onTap: () {},
                onChanged: (text) {
                  _inputText = text;
                  fetchSearchList(_inputText);
                },
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                cursorColor: MAINCOLOR,
                cursorHeight: 20,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                )),
            Expanded(
              child: FutureBuilder<List<SearchList>>(
                  future: fetchSearchList(_inputText),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.length);
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(7, 20, 7, 20),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(snapshot.data[index].prtKorNm);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

Future<List<SearchList>> fetchSearchList(String word) async {
  try {
    final response = await http.get(Uri.parse(
        "http://www.ygpa.or.kr:9191/openapi/service/infoCode/getCodePrtCodeF?serviceKey=zHwAlmS%2FNtOMU2yovx9ZoD0a3fQMIwrTfuB3K9oj%2FKZhJXmsDVieuAQmcp9r0qPP%2BmoBzyaQq4cD3rWi91%2FndQ%3D%3D&"));
    var respList = jsonDecode(response.body)['items'];
    print(respList);
    List<SearchList> searchList = <SearchList>[];
    for (var item in respList) {
      searchList.add(SearchList(
          ctryCode: item['ctryCode'],
          prtAreaCode: item['prtAreaCode'],
          prtEngNm: item['prtEngNm'],
          prtKorNm: item['prtKorNm']));
    }
    return searchList;
  } catch (e) {
    return [];
  }
}

class SearchList {
  final String ctryCode;
  final String prtAreaCode;
  final String prtEngNm;
  final String prtKorNm;

  SearchList({
    this.ctryCode = "",
    this.prtAreaCode = "",
    this.prtEngNm = "",
    this.prtKorNm = "",
  });
}
