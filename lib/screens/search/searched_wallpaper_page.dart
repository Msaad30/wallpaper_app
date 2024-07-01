import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app_widgets/wallpaper_bg_widgets.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/screens/detail/detailWallpaperPage.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/utils/util_helper.dart';

class SearchedWallpaper extends StatefulWidget {
  String query;
  String color;
  SearchedWallpaper({required this.query, this.color = ""});

  @override
  State<SearchedWallpaper> createState() => _SearchedWallpaperState();
}

class _SearchedWallpaperState extends State<SearchedWallpaper> {

  ScrollController? scrollController;
  num totalWallPaperCount = 0;
  int totalNoPages = 1;
  int pageCount = 1;
  List<PhotosModel> allWallpapers = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() {
      if(scrollController!.position.pixels == scrollController!.position.maxScrollExtent){
        print("page no $pageCount");
        totalNoPages = totalWallPaperCount~/15+1;
        if(totalNoPages > pageCount){
          pageCount++;
          BlocProvider
              .of<SearchCubit>(context)
              .getSearchWallpaper(query: "${widget.query}", color: widget.color, page: pageCount);
        } else {
          print("you have reached last page of wallpaper");
        }
      }
    });
    BlocProvider
        .of<SearchCubit>(context)
        .getSearchWallpaper(query: "${widget.query}", color: widget.color);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: BlocListener<SearchCubit, SearchState>(
        listener: (BuildContext context, SearchState state) {
          if(state is SearchLoadingState){
            pageSnackbar(
                context: context,
                title: pageCount != 1 ? "Next page is loading.." : "Loading..");
          }
          else if(state is SearchLoadedState){
            totalWallPaperCount = state.totalWallpaper!;
            allWallpapers.addAll(state.listPhotos);
            setState(() {

            });
          }
          else if(state is SearchErrorState){
            pageSnackbar(context: context, title: "${state.errorMsg}");
          }
        },
        child: ListView(
          controller: scrollController,
          children: [
            SizedBox(
              height: 34,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.query,
                style: mTextStyle25(mFontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "${totalWallPaperCount} wallpaper available",
                style: mTextStyle14(),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Container(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2/3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5
                  ),
                  itemCount: allWallpapers.length,
                  itemBuilder: (BuildContext context, int index) {
                    var eachPhotos = allWallpapers[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: index == allWallpapers.length - 1 ? 11 : 0),
                      child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (_) => DetailWallpaperPage(
                                    imgModel: eachPhotos.src!)
                            ));
                          },
                          child: WallpaperBgWidgets(imgUrl: eachPhotos.src!.portrait!)
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
