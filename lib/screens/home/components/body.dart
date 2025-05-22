import 'package:flutter/material.dart';
import 'package:plant_app/screens/home/components/header_with_searchbox.dart';
import 'featured_plant.dart';
import 'recomend_plant.dart';
import 'title_with_more_btn.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchbox(size: size),
          TitleWithMoreBtn(title: "Recomended", press: () {}),
          RecomendPlant(),
          TitleWithMoreBtn(title: "Featured Plants", press: () {}),
          FeaturedPlant(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}