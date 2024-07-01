import 'package:flutter/material.dart';

class WallpaperBgWidgets extends StatelessWidget {
  String imgUrl;
  double mHeight;
  double mWidgth;
  WallpaperBgWidgets({super.key, required this.imgUrl, this.mHeight = 250, this.mWidgth = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mHeight,
      width: mWidgth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        image: DecorationImage(
            image: NetworkImage(imgUrl),
          fit: BoxFit.fill
        )
      ),
    );
  }
}