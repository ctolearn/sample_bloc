import 'package:xml/xml.dart';
class Service{
  /*
    pag may underscore sa unahan ang variable is private at pag alaws public
      _name = private variable , name = public variable
   */
  String _name;
  String _price;
  Service(name,price){
    this._name =name;
    this._price =price;

  }
  String getName(){
    return this._name;
  }
  Service.fromXmlElement(XmlElement element){
    _name = element.findAllElements("name").single.text;
    _price =element.findAllElements("price").single.text;
  }
}

