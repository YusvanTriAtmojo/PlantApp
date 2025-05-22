import 'package:flutter/material.dart';

class TitleAndPrice extends StatelessWidget {
  const TitleAndPrice({
    super.key,
    required this.title,
    required this.country,
    required this.price,
  });

  final String title, country;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Color(0xFF3C4046), fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: country,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF0C9869),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "\$$price",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Color(0xFF0C9869)),
          )
        ],
      ),
    );
  }
}
