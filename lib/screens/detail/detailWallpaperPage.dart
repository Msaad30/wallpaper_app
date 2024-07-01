import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/utils/util_helper.dart';

class DetailWallpaperPage extends StatefulWidget {
  SrcModel imgModel;
  DetailWallpaperPage({required this.imgModel});

  @override
  State<DetailWallpaperPage> createState() => _DetailWallpaperPageState();
}

class _DetailWallpaperPageState extends State<DetailWallpaperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
              child: Image.network(widget.imgModel.portrait!, fit: BoxFit.fill,)
          ),
          Positioned(
            bottom: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getActionBtn(onTap: (){
                    }, title: "Info", icon: Icons.info_outline),
                    SizedBox(
                      width: 21,
                    ),
                    getActionBtn(onTap: (){
                      saveWallpaper(context);
                    }, title: "Save", icon: Icons.download),
                    SizedBox(
                      width: 21,
                    ),
                    getActionBtn(onTap: (){
                      applyWallpaper(context);
                    }, title: "Apply", icon: Icons.format_paint, bgColor: Colors.blueAccent),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void infoWallpaper(BuildContext context){

  }

  void saveWallpaper(BuildContext context){
    try{
      GallerySaver.saveImage(widget.imgModel.portrait!).then(
              (value) => msgSnackbar(context: context, title: "Image Save Successfully"));
    }
    catch(e){
      msgSnackbar(context: context, title: "Image not saved Becasuse : $e");
    }
  }

  void applyWallpaper(BuildContext context){
    Wallpaper
        .imageDownloadProgress(widget.imgModel.portrait!)
        .listen((event) {},
      onDone: (){
          Wallpaper.homeScreen(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            options: RequestSizeOptions.RESIZE_FIT,
          ).then((value) => msgSnackbar(context: context, title: "Image successfully set on home page"));
      },
      onError: (e){
          msgSnackbar(context: context, title: "Error : $e");
      },
    );
  }

  Widget getActionBtn({required VoidCallback onTap, required String title, required IconData icon, Color? bgColor}){
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: bgColor != null ? bgColor : Colors.white.withOpacity(0.4),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 28,),
            ),
          ),
        ),
        SizedBox(height: 2,),
        Text(title, style: mTextStyle12(mColor: Colors.white),)
      ],
    );
  }
}
