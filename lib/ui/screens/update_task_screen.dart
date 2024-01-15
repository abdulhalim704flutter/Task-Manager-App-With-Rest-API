import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateTaskScreen extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskScreen({super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {

  late TextEditingController _titleController ;
  late TextEditingController _descriptionController;
  bool _updateTaskInProgress = false;
  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.title);
    super.initState();

  }
  Future<void> updateTask() async {
    _updateTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestbody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, requestbody);
    _updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _titleController.clear();
      _descriptionController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Task Update Successfully')));
      }
      widget.onUpdate();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: const Text('Task update field')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Update task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close)),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _updateTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () {
                      updateTask();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}