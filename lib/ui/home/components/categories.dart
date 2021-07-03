import 'dart:ui';

import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  static final id = 'categories';
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int index = 0;

  List imgList = [
    'assets/home/categories/makeup.png',
    'assets/home/categories/men_accessories.png',
    'assets/home/categories/men_perfume.png',
    'assets/home/categories/other.png',
    'assets/home/categories/woman_accessories.png',
    'assets/home/categories/woman_perfume.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          gridView(context),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  Widget gridView(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1,
        shrinkWrap: true, //to hide error message
        children: <Widget>[
          InkWell(
              child: categoriesImages(
                  'assets/home/categories/makeup.svg', 'Makeup'),
              onTap: () {}),
          InkWell(
              child: categoriesImages(
                  'assets/home/categories/men_accessories.svg',
                  'Men Accessories'),
              onTap: () {}),
          InkWell(
            child: categoriesImages(
                'assets/home/categories/woman_accessories.svg',
                'Woman Accessories'),
            onTap: () => debugPrint(" woman accessories is pressed "),
          ),
          InkWell(
              child: categoriesImages(
                  'assets/home/categories/men_perfume.svg', 'Men Perfume'),
              onTap: () {}),
          InkWell(
              child: categoriesImages(
                  'assets/home/categories/woman_perfume.svg', 'Woman Perfume'),
              onTap: () {}),
          InkWell(
              child:
                  categoriesImages('assets/home/categories/other.svg', 'Other'),
              onTap: () {}),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------

  Widget categoriesImages(String svg_asset, String categorie_name) {
    return Column(
      children: [
        //TODO: check this line
        // Flexible(
        //   flex: 2,
        //   child: Container(
        //     decoration: BoxDecoration(
        //         image: DecorationImage(
        //             image: Svg(svg_asset), fit: BoxFit.contain)),
        //   ),
        // ),
        Flexible(
          flex: 1,
          child: Container(
            child: Text(
              categorie_name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
//-----------------------------------------------------------------------------
}
//TODO: get the api and add the gridview straggered
//TODO: check github branches
// returned to the base branches
//-> add the test branche and trying to make a pull request
