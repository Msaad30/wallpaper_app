import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/data/remote/api_helper.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/screens/home/home_screen.dart';
import 'package:wallpaper_app/utils/util_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(
                wallPaperRepository: WallPaperRepository(
                    apiHelper: ApiHelper()
                )
            ),
          child: HomePage()
          ),
      ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60),
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("assets/images/ic_logo.png", scale: 6,),
                ),
                SizedBox(
                  height: mHeight * 0.02,
                ),
                Text("Wallpaper App", style: mTextStyle16(mFontWeight: FontWeight.bold),),
                SizedBox(
                  height: mHeight * 0.01,
                ),
                Text("Created by M.saad_30", style: mTextStyle12(),),

              ],
        ),
      ),
    );
  }
}
