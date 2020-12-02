import 'package:flutter/material.dart';
import 'package:sample_bloc/model/status.dart';
import 'package:sample_bloc/service_add/bloc/service_add_bloc.dart';
import 'service_add_abstract_add.dart';
class Service_Add extends StatefulWidget {
  @override
  _Service_AddState createState() => _Service_AddState();
}

class _Service_AddState extends State<Service_Add> implements ServiceAdd_Abstract_Add{
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ServiceAdd_Bloc serviceAdd_Bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serviceAdd_Bloc = ServiceAdd_Bloc(this);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
      Navigator.pop(context,true);
    },child:Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed:()=>Navigator.pop(context,true),),
          title: Text("",style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
      body:SafeArea(child:Container(
      child:
      Column(
        children: [
          TextField(
              controller:nameController,
              decoration: InputDecoration(
                hintText: "Name",
              )
          ),TextField(
              controller:priceController,
              decoration: InputDecoration(
                hintText: "Price",
              )
          ),
          StreamBuilder(
            stream: serviceAdd_Bloc.serviceStream,
            builder: (c,snap){
              bool isLoading = false;
              if(snap.hasData){
                switch(snap.data.status){
                  case Status.SUBMIT_LOADING:
                    isLoading = true;
                    break;
                  case Status.SUBMIT_PROCESSED:
                    isLoading = false;
                    break;

                }
              }
              return MaterialButton(
                height: 50,
                minWidth: double.infinity,
                color:  isLoading ? Colors.grey : Colors.blue ,
                textColor: Colors.white,
                child: Padding(padding:EdgeInsets.all(10),child: Text("Submit")),
                onPressed: isLoading ? null : () {
                  if(nameController.text.isEmpty){
                      showAlertDialog("message", "title");
                  }else if(priceController.text.isEmpty){
                    showAlertDialog( "message", "title");
                  }else{
                    serviceAdd_Bloc.postData(nameController.text.toString(), priceController.text.toString());
                  }

                },
                splashColor:Colors.blue,
              );
            },)
        ],
      ),))));
  }
  showAlertDialog(String  message,String title) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop(); },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  showMessage(String message, String title) {
    showAlertDialog(message, title);
  }
}
