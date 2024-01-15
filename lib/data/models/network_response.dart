class NetworkResponse{
  final int statusCode;
  final bool isSuccess;
  final Map<String ,dynamic>? body;// ? this is uses for , tis not uses every time, thats whay this is uses,

  NetworkResponse(this.isSuccess,this.statusCode, this.body, );
}