import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app_widgets/wallpaper_bg_widgets.dart';
import 'package:wallpaper_app/constansts/app_constansts.dart';
import 'package:wallpaper_app/data/remote/api_helper.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/detail/detailWallpaperPage.dart';
import 'package:wallpaper_app/screens/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/searched_wallpaper_page.dart';
import 'package:wallpaper_app/utils/util_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeCubit>(context).getTrandingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // 1
          SizedBox(
            height: mHeight * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              style: mTextStyle16(mFontWeight: FontWeight.bold),
              controller: searchController,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    if(searchController.text.isNotEmpty){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (_) => BlocProvider(
                              create: (_) => SearchCubit(
                                  wallPaperRepository: WallPaperRepository(
                                      apiHelper: ApiHelper()
                                  )
                              ),
                            child: SearchedWallpaper(query: searchController.text,),
                          )
                      ));
                    }
                  },
                    child: Icon(
                      Icons.search_sharp,
                      color: AppColors.searchTextColor,
                    )
                ),
                hintText: "Find Wallpaper..",
                hintStyle: mTextStyle12(mColor: AppColors.searchTextColor),
                filled: true,
                fillColor: AppColors.secondaryLightColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0
                  )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0
                    )
                ),
              ),
            ),
          ),

          ///2
          SizedBox(
            height: mHeight * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Best of months", style: mTextStyle16(mFontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: mHeight * 0.01,
          ),
          SizedBox(
            height: mHeight * 0.3,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (BuildContext context, state) {
                if(state is HomeLoadingState){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is HomeLoadedState){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listPhotos.length,
                      itemBuilder: (context, index) {
                        var eachPhoto = state.listPhotos[index];
                        return Padding(
                          padding: EdgeInsets.only(left: 10, right: index == state.listPhotos.length - 1 ? 10 : 0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (_) => DetailWallpaperPage(imgModel: eachPhoto.src!)
                              ));
                            },
                              child: WallpaperBgWidgets(imgUrl: eachPhoto.src!.portrait!)
                          ),
                        );
                      },
                    ),
                  );
                }
                else if(state is HomeErrorState){
                  return Center(
                    child: Text(state.errorMsg),
                  );
                }
                return Container();
              },
            ),
          ),

          ///3
          SizedBox(
            height: mHeight * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Color tone", style: mTextStyle16(mFontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: mHeight * 0.01,
          ),
          SizedBox(
            height: mHeight * 0.06,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.mColors.length,
                itemBuilder: (context, index)
                {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10,
                        right: index == AppConstants.mColors.length - 1 ? 10 : 0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) =>
                            BlocProvider(
                              create: (context) => SearchCubit(
                                  wallPaperRepository: WallPaperRepository(
                                      apiHelper: ApiHelper())),
                              child: SearchedWallpaper(
                                query: searchController.text.isNotEmpty ? searchController.text : "nature",
                                color: AppConstants.mColors[index]["code"],
                              ),
                            ))
                        );
                      },
                      child: getColorToneWidget(AppConstants.mColors[index]["color"],

                      )
                    ),
                  );
                },
              ),
            ),
          ),

          ///3
          SizedBox(
            height: mHeight * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Categories", style: mTextStyle16(mFontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: mHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
                childAspectRatio: 9/4

              ),
              itemCount: AppConstants.mCatagories.length,
              itemBuilder: (context, index)
              {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) =>
                        BlocProvider(
                        create: (context) => SearchCubit(
                            wallPaperRepository: WallPaperRepository(
                                apiHelper: ApiHelper())),
                        child: SearchedWallpaper(
                          query: AppConstants.mCatagories[index]["title"],
                        ),
                      ))
                    );
                  },
                  child: getCategoryWidget(
                      title: AppConstants.mCatagories[index]["title"],
                      imageUrl: AppConstants.mCatagories[index]["imageUrl"],
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget getColorToneWidget(Color mColor){
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: mColor,
        borderRadius: BorderRadius.circular(11),
      ),
    );
  }

  Widget getCategoryWidget({required String imageUrl, required String title}){
    return Container(
      width: 200,
      height: 100,
      child: Center(
          child: Text(title, style: mTextStyle14(mColor: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover
        )
      ),
    );
  }
}
