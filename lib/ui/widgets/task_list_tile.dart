import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback onDelete , onEdit;
  final TaskData data;
  const TaskListTile({
    super.key,required this.data, required this.onDelete, required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                label: Text(
                  data.status ?? 'New',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              Spacer(),
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade300,
                  )),
              IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
