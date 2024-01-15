import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Column(
            children: [
              UserProfileAppBar(),
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                    itemBuilder: (context,index){
                    return Container();
                    }, separatorBuilder: (BuildContext context,int index){
                  return const Divider(height: 8,);
                }),
              )

              
            ],
          ),
        ),
      ),
    );
  }
}
