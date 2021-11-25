import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:tudulis/ui/components/task_list.dart';

class AllSection extends StatelessWidget {
  const AllSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    // I put the SingleChlidScrollView here
    // because otherwise, the child will be centered vertically
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
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
          const AddTask(),
          const SizedBox(height: 5.0),
          TaskList(taskList: _taskService.getAllTask),
        ],
      ),
    );
  }
}
