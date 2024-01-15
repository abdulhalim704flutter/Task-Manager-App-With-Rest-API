import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateTaskStatusScreen extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;
  const UpdateTaskStatusScreen({super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskStatusScreen> createState() => _UpdateTaskStatusScreenState();
}

class _UpdateTaskStatusScreenState extends State<UpdateTaskStatusScreen> {
  List<String> taskStatusList = ['New','Progress','Canceled','Completed'];
  late String _selectedTask;
  bool updateTaskInProgress = false;
  final Color blueColor = Colors.blue;
  final Color orangeColor = Colors.orange;
  final Color greenColor = Colors.green;
  final Color redColor = Colors.red;
  @override

  Future<void> updateTask(String taskId,String newStatus) async {
    updateTaskInProgress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.updateTask(taskId,newStatus));
    updateTaskInProgress = false;
    if(mounted){
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onUpdate();
      if(mounted) {
        Navigator.pop(context);
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('update task status hase been field')));
      }
    }
  }

  void initState() {
    // TODO: implement initState
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Update Status'),),
          Expanded(
            child: ListView.builder(
                itemCount: taskStatusList.length,
                itemBuilder: (context, int index){
                  return ListTile(
                    onTap: (){
                      _selectedTask = taskStatusList[index];
                      setState(() {});
                    },
                    title: Text(taskStatusList[index].toUpperCase()),
                    trailing:_selectedTask == taskStatusList[index] ? const Icon(Icons.check) : null,
                  );
                }),
          ),
          Visibility(
            visible: updateTaskInProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(onPressed: (){
                updateTask(widget.task.sId!, _selectedTask);
              }, child: Text('Update')))
        ],
      ),
    );;
  }
}
