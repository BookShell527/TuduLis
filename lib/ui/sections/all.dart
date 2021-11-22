import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/models/task.dart';

class AllSection extends StatefulWidget {
  const AllSection({Key? key}) : super(key: key);

  @override
  State<AllSection> createState() => _AllSectionState();
}

class _AllSectionState extends State<AllSection> {
  final TaskService _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _taskService.listenable,
          builder: (context, Box<Task> taskBox, _) {
            return ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: taskBox.length,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  key: Key(i.toString()),
                  child: ListTile(
                    leading: Checkbox(
                      onChanged: (val) {},
                      value: taskBox.getAt(i)!.isCompleted,
                    ),
                    title: Text(taskBox.getAt(i)!.title),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                print(oldIndex);
                print(newIndex);
              },
              header: Row(
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
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                    splashRadius: 25.0,
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 5.0),
        const AddTask(),
      ],
    );
  }
}
