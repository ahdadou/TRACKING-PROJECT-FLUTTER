import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key key, this.icon, this.title, this.press, this.color})
      : super(key: key);

  final String icon;
  final String title;
  final Function press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        onPressed: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 40,
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ));
  }
}
