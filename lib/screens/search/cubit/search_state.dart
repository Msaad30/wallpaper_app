part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}
class SearchLoadingState extends SearchState {}
class SearchLoadedState extends SearchState {
  List<PhotosModel> listPhotos;
  int? totalWallpaper;
  SearchLoadedState({required this.listPhotos, required this.totalWallpaper});
}
class SearchErrorState extends SearchState {
  String errorMsg;
  SearchErrorState({required this.errorMsg});
}
