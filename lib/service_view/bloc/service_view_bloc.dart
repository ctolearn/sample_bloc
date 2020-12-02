import 'dart:async';

import 'package:sample_bloc/apiresponse/ApiResponse.dart';
import 'package:sample_bloc/service_view/bloc/service_abstract.dart';
import 'package:sample_bloc/repository/webrepository.dart';
import 'package:xml/xml.dart';
import 'package:sample_bloc/model/service.dart';
class ServiceView_Bloc implements post_view_abstract{
  //pde ren = new WebRepository
   WebRepository webRepository = WebRepository();
   StreamController streamController = StreamController<ApiResponse>();
   //si stream ang nakikinig sa streamcontroller kung meron bagong nag sink na data
   Stream<ApiResponse> get postListStream => streamController.stream;
   //si sink ang nag add ng event  sa streamcontroller para mag trigger si stream via add
   StreamSink<ApiResponse> get postListSink => streamController.sink;
   //generated galing sa abstract

  @override
  void closeStream() async{
    // TODO: implement closeStream
    streamController.close();
  }
   //generated galing sa abstract nilagyn lang ng async para sa fetch ng data
   @override
  void getAllPost() async{
     // TODO: implement getAllPost
     var response = await webRepository.getData();
     postListSink.add(ApiResponse.loading("loading.."));
     if (response == null) {
       //time out or socket error
       postListSink.add(ApiResponse.error("Net error"));
     }else{
       //ginamit lang to dahil xml ang fetch na data
       final document = XmlDocument.parse(response);
        List<Service> serv = document.findAllElements('service').map<Service>((e) => Service.fromXmlElement(e)).toList();
       postListSink.add(ApiResponse.completed(serv));
     }
  }



}

