import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/task_list.dart';

class TodaySection extends StatelessWidget {
  const TodaySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Today ",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                        text: " " +
                            DateFormat("EEEE, d MMM y").format(DateTime.now()))
                  ],
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
          const SizedBox(height: 5.0),
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
          TaskList(taskList: _taskService.getTodayTask),
        ],
      ),
    );
  }
}
