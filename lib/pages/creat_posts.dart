import 'package:flutter/material.dart';
import 'package:homework_post/viewmodels/creat_viewmodel.dart';
import 'package:homework_post/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';



class CreatPage extends StatefulWidget {
  const CreatPage({super.key});

  @override
  State<CreatPage> createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  CreatViewModel viewModel = CreatViewModel();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context)=>viewModel,
      child:Consumer<CreatViewModel>(
        builder: (context,model,index)=>Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("Creat Post"),
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
                        viewModel.creatPost(context);
                      },
                      child: Text("Creat"),
                    )
                ),
              ],
            ),
          ),
        )
      ) ,
    );
  }
}