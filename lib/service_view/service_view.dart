import 'package:flutter/material.dart';
import 'bloc/service_view_bloc.dart';
import 'package:sample_bloc/model/status.dart';
import 'package:sample_bloc/model/service.dart';
import 'package:sample_bloc/service_view/service_view_list.dart';
import 'file:///D:/SampleBloc/sample_bloc/lib/loading_view/loading_view.dart';
import 'package:sample_bloc/service_add/service_add.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  ServiceView_Bloc serviceView_Bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serviceView_Bloc = ServiceView_Bloc();
    serviceView_Bloc.getAllPost();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceView_Bloc.closeStream();
  }
  Widget errorWidget(String message){
    return Container(
        margin: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height ,
        child:
        Column(children: [
          SizedBox(height: 34,),
          Text(message),
          Center(child:MaterialButton(
            height: 50,

            textColor: Colors.white,
            child: Padding(padding:EdgeInsets.all(10),child: Text("Reload")),
            onPressed: () {
              serviceView_Bloc.getAllPost();
            },
          ))

        ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
      onPressed: () async{
        // para pag ka balik niya mag load yung data
        var result = await Navigator.push(context, MaterialPageRoute(builder:(context)=>Service_Add()));
        if(result!=null){
          serviceView_Bloc.getAllPost();
        }

      },
      label: Text('Add'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.blue,
    ),
      body:SafeArea(child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height ,
          child:StreamBuilder(
          stream: serviceView_Bloc.postListStream,
          builder: (c,snap){
            Widget children;
            if(snap.hasError) {
              children = errorWidget("error ..");
            }else{
              if(snap.hasData){
                //snap.data kasi yung apiresponse naten na list of data is data ang variable name
                //snap.data.status kasi yung apiresponse ay status ang variable name
                switch(snap.data.status){
                  case Status.LOADING:
                    children = Loading_View(snap.data.message);
                    break;
                  case Status.ERROR:
                    children = errorWidget(snap.data.message);
                    break;
                  case Status.COMPLETED:
                    children = PostView_List(snap.data.data);
                    break;
                }
              }else{
                children = Loading_View("loading ..");
              }
            }
            return children;
          },
        )

      ),
    ));
  }
}
