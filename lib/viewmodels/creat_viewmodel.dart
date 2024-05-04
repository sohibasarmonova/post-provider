
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:homework_post/models/post_model.dart';
import 'package:homework_post/models/post_res_model.dart';
import 'package:homework_post/services/http_service.dart';
import 'package:homework_post/services/log_service.dart';

class CreatViewModel extends ChangeNotifier{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  creatPost(BuildContext context) async{
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(userId: 1,title: title, body: body);

    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    LogService.d(response!);
    PostRes postRes = Network.parsePostRes(response);
    backToFinish(context);
  }

  backToFinish(BuildContext context){
    Navigator.of(context).pop(true);
  }
}