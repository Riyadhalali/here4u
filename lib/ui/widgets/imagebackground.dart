import 'package:flutter/material.dart';

class ImageBackground extends StatefulWidget {
  String imageAsset;
  ImageBackground({required this.imageAsset});
  @override
  _ImageBackgroundState createState() => _ImageBackgroundState();
}

class _ImageBackgroundState extends State<ImageBackground> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(35.0),
          // color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage(widget.imageAsset), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

//----------------------------------------------------------------------------
