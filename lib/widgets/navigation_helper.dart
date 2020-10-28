import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationHelper extends StatelessWidget {
  final String leading;
  final String action;
  final Function onTap;

  NavigationHelper({
    Key key,
    @required this.leading,
    @required this.action,
    this.onTap,
  }) : super(key: key);

  final leadingStyle = GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  final actionStyle = GoogleFonts.lato(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: leading + '  ',
              style: leadingStyle,
            ),
            TextSpan(
              text: action,
              style: actionStyle,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
