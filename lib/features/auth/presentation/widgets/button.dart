import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Function onPressed;
  final double borderRadius;
  final String? font;
  final FontWeight? fontWeight;
  final double fontSize;
  final double height;
  final double? letterSpacing;
  final EdgeInsets padding;

  final String arrow;
  final Icon icon;

  const Button({
    Key? key,
    required this.title,
    this.color,
    this.textColor,
    required this.onPressed,
    this.borderColor,
    this.borderRadius = 40,
    this.font,
    this.fontSize = 16,
    this.arrow = "",
    this.icon = const Icon(Icons.arrow_forward_ios_sharp,
        size: 16, color: Colors.blueGrey),
    this.height = 0,
    this.letterSpacing,
    this.fontWeight,
    this.padding = const EdgeInsets.only(left: 8.0, right: 8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height != 0 ? height : 40,
        child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
              backgroundColor: MaterialStateProperty.all<Color>(color!),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(color: borderColor ?? color!),
                ),
              ),
            ),
            onPressed: () => onPressed.call(),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    if (arrow.isNotEmpty && arrow == 'left')
                      WidgetSpan(child: icon),
                    TextSpan(
                        text: title,
                        style: TextStyle(
                            fontFamily: font,
                            color: textColor,
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                            letterSpacing: letterSpacing)),
                    if (arrow.isNotEmpty && arrow == 'right')
                      WidgetSpan(child: icon),
                  ],
                ))));
  }
}
