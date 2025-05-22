import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      padding: EdgeInsets.all(10),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: Color(0xFFF9F8FD),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 22,
            color: Color(0xFF0C9869).withAlpha((0.22 * 255).round()),
          ),
          BoxShadow(
            offset: Offset(-15, -15),
            blurRadius: 20,
            color: Colors.white,
          ),
        ],
      ),
      child: SvgPicture.asset(icon),
    );
  }
}
