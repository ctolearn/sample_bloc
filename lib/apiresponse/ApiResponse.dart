import 'package:sample_bloc/model/status.dart';
class ApiResponse<T>{
  Status status;
  T data;
  String message;
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;
  ApiResponse.buttonLoading() : status = Status.SUBMIT_LOADING;
  ApiResponse.buttonProcessed() : status = Status.SUBMIT_PROCESSED;
}