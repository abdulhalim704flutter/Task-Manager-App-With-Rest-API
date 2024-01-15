import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/summary_count_model.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/update_task_screen.dart';
import 'package:task_manager/ui/screens/update_task_status_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/summary_card.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  bool _getCountSummaryInProgress = false;
  bool _getNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();
  void initState() {
    super.initState();
    // after widgets binding/ after ui loading left call this funtion thats whay uses this funtion
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCountSummary();
      getNewTask();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Summary data get field')));
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('get new task data field')));
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Deletion of task hase been field')));
      }
    }
  }
  Future<void> updateTask(String taskId,String newStatus) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTask(taskId,newStatus));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Deletion of task hase been field')));
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            UserProfileAppBar(),
            _getCountSummaryInProgress
                ? const Center()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _summaryCountModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return SummaryCard(
                            number: _summaryCountModel.data![index].sum ?? 0,
                            title: _summaryCountModel.data![index].sId ?? 'New',
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 8,
                          );
                        },
                      ),
                    ),
                  ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTask();
                  getCountSummary();
                },
                child: _getNewTaskInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _taskListModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: _taskListModel.data![index],
                            onDelete: () {
                              deleteTask(_taskListModel.data![index].sId!);
                            },
                            onEdit: () {
                              //showEditBottomSheet(_taskListModel.data![index]);
                              showStatusUpdateBottomSheet(_taskListModel.data![index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 8,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTaskScreen(),
            ),
          );
        },
      ),
    );
  }

  void showEditBottomSheet(TaskData task) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateTaskScreen(
            task: task,
            onUpdate: () {
              getNewTask();
            },
          );
        });
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateTaskStatusScreen(
            task: task,
            onUpdate: (){
              getNewTask();
            },
          );
      }
    );
  }
}
