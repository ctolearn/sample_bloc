/*
  interface pag sa ibang programming language
  dito ginagamet abstract class
 */
abstract class post_view_abstract{
    // pang close ng stream
    void closeStream();
    void getAllPost();
    /*void postData(String name,String price);
    @override
    void postData(String name, String price) {
        // TODO: implement postData
        var response = webRepository.postData(name, price);
        if (response == null) {
            //time out or socket error

        }else{
            if(response.toString() == "success"){

            }else{

            }
        }
    }*/
}
