
import 'package:flutter/material.dart';
import 'package:homework_post/models/post_model.dart';
import 'package:homework_post/models/post_res_model.dart';
import 'package:homework_post/services/log_service.dart';

import '../services/http_service.dart';

class UpdateViewModel extends ChangeNotifier{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  updatePost(Post post,BuildContext context) async{
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    Post newPost=post;
    newPost.title=title;
    newPost.body=body;

    var response = await Network.PUT(
        Network.API_POST_UPDATE + newPost.id.toString(),
        Network.paramsUpdate(newPost));
    LogService.d(response!);
    PostRes postRes=Network.parsePostRes(response);
    backToFinish(context);
  }
  backToFinish(BuildContext context){
    Navigator.of(context).pop(true);
  }

}