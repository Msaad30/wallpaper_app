import 'package:wallpaper_app/constansts/app_constansts.dart';
import 'package:wallpaper_app/data/remote/api_helper.dart';
import 'package:wallpaper_app/data/remote/urls.dart';

class WallPaperRepository{
  ApiHelper apiHelper;
  WallPaperRepository({required this.apiHelper});

  // Search Wallpaper
  Future<dynamic> getSearchWallpapers(String mQuery, {String mColor = "", int mPage = 1}) async {
    try{
      return await apiHelper.getApi(apiUrl: "${AppUrls.searchUrl}?query=$mQuery&color=$mColor&page=$mPage");
    }
    catch (e){
      rethrow;
    }
  }
  // Tranding Wallpaper
  Future<dynamic> getTrandingWallpapers() async {
    try{
      return await apiHelper.getApi(apiUrl: AppUrls.trendingUrl);
    }
    catch (e){
      rethrow;
    }
  }
}