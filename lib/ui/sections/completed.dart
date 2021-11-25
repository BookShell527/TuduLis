import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:tudulis/ui/components/task_list.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';

class CompletedSection extends StatefulWidget {
  const CompletedSection({Key? key}) : super(key: key);

  @override
  _CompletedSectionState createState() => _CompletedSectionState();
}

class _CompletedSectionState extends State<CompletedSection> {
  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Text(
                "Completed",
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
          const AddTask(isCompleted: true),
          const SizedBox(height: 5.0),
          TaskList(taskList: _taskService.getCompleted),
        ],
      ),
    );
  }
}
