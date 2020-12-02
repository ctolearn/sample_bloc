import 'package:flutter/material.dart';
class Loading_View extends StatelessWidget {
  String message;
  Loading_View(this.message);
  //kung gusto mo lagay message
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height ,
        child:Center(child:CircularProgressIndicator()));
  }
}
