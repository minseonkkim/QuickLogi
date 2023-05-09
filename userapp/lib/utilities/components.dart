import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quick_logi/utilities/constants.dart';

class BackTopBar extends StatelessWidget implements PreferredSizeWidget {
  const BackTopBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}

// 다이얼로그(예/아니오)
void showYesOrNoDialog(String title, void Function()? yesAction) {
  Get.defaultDialog(
      backgroundColor: Colors.white,
      radius: 5,
      titlePadding: const EdgeInsets.only(top: 50, bottom: 30),
      titleStyle: const TextStyle(fontSize: 14, fontFamily: "Inter"),
      title: title,
      contentPadding: EdgeInsets.all(0),
      content: Column(
        children: [
          const Divider(
            thickness: 2,
            color: GREY2,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(
            height: 40,
            width: 280,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: yesAction,
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        child: const Text(
                          "예",
                          style: TextStyle(fontSize: 14, fontFamily: "Inter"),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: GREY2,
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        child: const Text(
                          "아니오",
                          style: TextStyle(fontSize: 14, fontFamily: "Inter"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ));
}
