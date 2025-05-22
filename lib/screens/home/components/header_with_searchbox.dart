import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0C9869);

class HeaderWithSearchbox extends StatelessWidget {
  const HeaderWithSearchbox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20 * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 36 + 20,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Halo, Yusvan Tri Atmojo !',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/images/uyun.jpg"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
