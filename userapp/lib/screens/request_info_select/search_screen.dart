import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SearchScreen extends StatefulWidget {
//   final List<String> list = ['부산', '포항'];

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               showSearch(context: context, delegate: Search(widget.list));
//             },
//             icon: Icon(Icons.search),
//           )
//         ],
//         centerTitle: true,
//         title: Text('Search Bar'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.list.length,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(
//             widget.list[index],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["부산", "포항"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
            // 이전 화면으로 보내기

            Get.offAndToNamed('/PlaceSelectScreen',
                arguments: '${selectedResult}');
          },
        );
      },
    );
  }
}
