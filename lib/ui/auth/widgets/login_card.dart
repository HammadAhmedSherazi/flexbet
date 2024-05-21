import 'package:flexx_bet/helpers/size.dart';
import 'package:flexx_bet/ui/components/custom_image_view.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  final String text;
  final Color color;
  final String imagePath;
  final TextStyle textStyle;

  const LoginCard(
      {super.key,
      required this.text,
      required this.color,
      required this.imagePath,
        required this.textStyle

      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 325,
      padding: const EdgeInsets.fromLTRB(30, 15, 10, 15),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center, children: [
        CustomImageView(
          imagePath: imagePath,
          height: getVerticalSize(50),
        ),
        SizedBox(
          width: getHorizontalSize(10),
        ),
        Text(
          text,
          style: textStyle,
        )
      ]),
    );
  }
}
