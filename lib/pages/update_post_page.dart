import 'package:flutter/material.dart';
import 'package:homework_post/viewmodels/update_viewmodel.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';


class UpdatePage extends StatefulWidget {
 final Post post;
  const UpdatePage({super.key,required this.post});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
UpdateViewModel viewModel=UpdateViewModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.titleController.text=widget.post.title!;
    viewModel.bodyController.text=widget.post.body!;
  }


  @override
  Widget build(BuildContext context) {
    // keyvord ekran hohlagan joyini bossa yo'qolad
    return ChangeNotifierProvider(create: (context)=>viewModel,
      child: Consumer<UpdateViewModel>(
        builder: (context,model,index)=> GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text("Update Post"),
            ),
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    child: TextField(
                      controller: viewModel.titleController,
                      decoration: InputDecoration(
                          hintText: "Title"
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: viewModel.bodyController,
                      decoration: InputDecoration(
                          hintText: "Body"
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          viewModel.updatePost( widget.post,context);
                        },
                        child: Text("Update"),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
