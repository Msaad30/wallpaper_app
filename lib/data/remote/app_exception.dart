class AppException implements Exception{
  String title;
  String msg;

  AppException({required this.title, required this.msg});

  String toErrorMsg(){
    return "$title : $msg";
  }

}

class FetchDataException extends AppException{
  FetchDataException({required String ErrorMsg}) : super(title: "Network Error",msg:"Please check your network" );
}
class BadRequestException extends AppException{
  BadRequestException({required String ErrorMsg}) : super(title: "Bad request",msg:"bad request need to check" );
}
class UnAuthorisedException extends AppException{
  UnAuthorisedException({required String ErrorMsg}) : super(title: "Un Authorised",msg:"You don't have permission" );
}
class InvalidInputException extends AppException{
  InvalidInputException({required String ErrorMsg}) : super(title: "Invalid Input",msg:"Please check your input" );
}