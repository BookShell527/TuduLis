import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:tudulis/ui/components/task_list.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';

class PlannedSection extends StatelessWidget {
  const PlannedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    return Column(
      children: <Widget>[
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            const Text(
              "Planned",
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
        AddTask(
          dueDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            23,
            59,
          ),
        ),
        const SizedBox(height: 5.0),
        TaskList(taskList: _taskService.getPlannedTask),
      ],
    );
  }
}
