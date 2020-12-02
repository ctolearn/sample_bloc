import 'dart:async';

import 'package:sample_bloc/apiresponse/ApiResponse.dart';
import 'package:sample_bloc/service_add/bloc/service_add_abstract.dart';
import 'package:sample_bloc/repository/webrepository.dart';
import 'package:sample_bloc/apiresponse/ApiResponse.dart';
import 'package:xml/xml.dart';
import 'package:sample_bloc/model/service.dart';
import 'package:sample_bloc/service_add/service_add_abstract_add.dart';
class ServiceAdd_Bloc implements service_add_abstract{
  ServiceAdd_Abstract_Add add_abstract_add;
  ServiceAdd_Bloc(this.add_abstract_add);
  //pde ren = new WebRepository
   WebRepository webRepository = WebRepository();
   StreamController streamController = StreamController<ApiResponse>();
   //si stream ang nakikinig sa streamcontroller kung meron bagong nag sink na data
   Stream<ApiResponse> get serviceStream => streamController.stream;
   //si sink ang nag add ng event  sa streamcontroller para mag trigger si stream via add
   StreamSink<ApiResponse> get serviceSink => streamController.sink;
   //generated galing sa abstract

  @override
  void closeStream() async{
    // TODO: implement closeStream
    streamController.close();
  }

  @override
  void postData(String name, String price) {
    serviceSink.add(ApiResponse.buttonLoading());
    // TODO: implement postData
    var response = webRepository.postData(name, price);
    if (response == null) {
      //time out or socket error
      serviceSink.add(ApiResponse.buttonProcessed());
    }else{
      serviceSink.add(ApiResponse.buttonProcessed());
      if(response.toString() == "success"){
        add_abstract_add.showMessage("message success", "title success");
      }else{
        add_abstract_add.showMessage("message failed", "title failed");
      }
    }
  }




}

