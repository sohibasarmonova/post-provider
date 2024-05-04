
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homework_post/pages/creat_posts.dart';
import 'package:homework_post/services/http_service.dart';

import '../models/post_model.dart';
import '../pages/update_post_page.dart';
import '../services/log_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = true;
  List<Post> posts = [];

  loadPosts() async {

      isLoading = true;
      notifyListeners();

    var response = await Network.GET(Network.API_POST_LIST, Network.paramsEmpty());
    LogService.d(response!);
    List<Post> postList = Network.parsePostList(response!);


      posts = postList;
      isLoading = false;
      notifyListeners();
  }

  deletePost(Post post) async {

      isLoading = true;
      notifyListeners();
    var response = await Network.DEL(Network.API_POST_DELETE + post.id.toString(), Network.paramsEmpty());
    LogService.d(response!);
    loadPosts();
  }

  Future callCreatePage(BuildContext context) async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CreatPage();
    }));

    if (result) {
      loadPosts();
    }
  }

  Future callUpdatePage(Post post,BuildContext context) async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UpdatePage(post: post);
    }));

    if (result) {
      loadPosts();
    }
  }
  Future<void> handleRefresh() async {
    loadPosts();
  }

}