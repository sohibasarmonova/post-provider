import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:homework_post/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
HomeViewModel viewModel = HomeViewModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadPosts();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Networking"),
      ),
      body:ChangeNotifierProvider(
        create: (context)=>viewModel,
        child: Consumer<HomeViewModel>(
          builder: (context,model,index)=> Stack(
            children: [
              RefreshIndicator(
                onRefresh: viewModel.handleRefresh,
                child: ListView.builder(
                  itemCount: viewModel.posts.length,
                  itemBuilder: (ctx, index) {
                    return _itemOfPost(viewModel.posts[index]);
                  },
                ),
              ),
              viewModel. isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          viewModel.callCreatePage(context);
        },
      ),
    );
  }

  Widget _itemOfPost(Post post) {
    return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                viewModel.callUpdatePage(post,context);
              },
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                viewModel.deletePost(post);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(post.body!,
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
              Divider(),
            ],
          ),
        ));
  }
}