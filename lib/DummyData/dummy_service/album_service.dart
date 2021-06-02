import '../../helper/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AlbumService{


  Future <http.Response> getAllAlbum() async{
    return await http.get(
        Uri.http(ROOT_URL, UN_ENCODED_PATH)
    );
  }


}