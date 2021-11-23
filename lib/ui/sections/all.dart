import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/ui/components/task_tile.dart';

class AllSection extends StatefulWidget {
  const AllSection({Key? key}) : super(key: key);

  @override
  State<AllSection> createState() => _AllSectionState();
}

class _AllSectionState extends State<AllSection> {
  final TaskService _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _taskService.taskBox.listenable(),
      builder: (BuildContext context, Box<Task> taskBox, _) {
        return ReorderableListView.builder(
          shrinkWrap: true,
          itemCount: taskBox.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int i) {
            Task? task = taskBox.getAt(i);
            return TaskTile(
              key: Key(i.toString()),
              task: task,
              deleteTask: () => _taskService.deleteTask(i),
            );
          },
          onReorder: _taskService.reorderTask,
          header: Column(
            children: <Widget>[
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  const Text(
                    "All",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {},
                    icon: const Icon(Icons.more_vert),
                    splashRadius: 25.0,
                  ),
                ],
              ),
              const AddTask(),
              const SizedBox(height: 5.0),
            ],
          ),
        );
      },
    );
  }
}
