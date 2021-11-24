import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:tudulis/ui/components/task_tile/task_tile.dart';
import 'package:tudulis/models/task.dart';

class AllSection extends StatefulWidget {
  const AllSection({Key? key}) : super(key: key);

  @override
  State<AllSection> createState() => _AllSectionState();
}

class _AllSectionState extends State<AllSection> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    // if i put the SingleChildScrollView on the home.dart, the column will be placed center
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
          Theme(
            data: Theme.of(context)
                .copyWith(splashFactory: NoSplash.splashFactory),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _taskService.getAllTask.length,
              itemBuilder: (BuildContext context, int i) {
                Task task = _taskService.getAllTask[i];
                return TaskTile(task: task);
              },
            ),
          ),
        ],
      ),
    );
  }
}
