part of 'home_cubit.dart';

@immutable
abstract class HomeState {}
class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeLoadedState extends HomeState {
  List<PhotosModel> listPhotos;
  HomeLoadedState({required this.listPhotos});
}
class HomeErrorState extends HomeState {
  String errorMsg;
  HomeErrorState({required this.errorMsg});
}