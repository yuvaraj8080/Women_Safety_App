import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../features/Advanced_Safety_Tool/models/ReportIncidentModel.dart';

class TodoApiServices extends GetxController{
  var TodoList = RxList<ReportIncidentModel>();

  void onInit(){
    super.onInit();
    getTodos();
  }

  /// GET DATA FROM THE API
Future<RxList<ReportIncidentModel>> getTodos() async{
    try{
      final response = await http.get(Uri.parse("https://api.restful-api.dev/objects"));
      var data = jsonDecode(response.body.toString());
      if(response.statusCode == 200){
        for(Map<String,dynamic>index in data){
          TodoList.add(ReportIncidentModel.fromSnapshot(index as DocumentSnapshot<Map<String, dynamic>>));
        }
        return TodoList;
      }else{
        return TodoList;
      }
    }catch(e){
      throw "Something went wrong${e.toString()}";
    }
}

/// POST DATA ON API

  Future<void> postTodos(title) async{
    try{
      final response = await http.post(
        Uri.parse("https://api.restful-api.dev/objects"),
        headers:{'Content-Type':'application/json'},
        body:json.encode(
          {"todoTitle":title},
        )
      );
    if(response.statusCode == 201){
      TodoList.clear();
      getTodos();
      print("Done");
    }else{
      print("Failed");
    }
    }catch(e){
      throw "Something went wrong${e.toString()}";
    }
  }


  ///  DELETE API ITEM
  Future<void> deleteTodo(id) async{
    try{
      final response = await http.delete(Uri.parse("https://api.restful-api.dev/objects/$id"),);
      if(response.statusCode == 200){
        print("Done");
        TodoList.clear();
        getTodos();
      }else{
        print("Faild");
      }
    }catch(e){
      throw "${e.toString()}";
    }
  }

}