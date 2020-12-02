import 'package:flutter/material.dart';
import 'package:sample_bloc/model/service.dart';
class PostView_List extends StatelessWidget {
  List<Service> services;
  PostView_List(this.services);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height ,
        child: ListView.separated(
          itemCount: services.length,
          itemBuilder: (c,index){
            return Row(children:[
              Expanded(child:Text(services[index].getName())),

            ]);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ));
  }
}
