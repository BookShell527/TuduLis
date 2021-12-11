import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/components/add_task.dart';
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
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Text(
              _localizations.completedSection,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
          ],
        ),
        const AddTask(isCompleted: true),
        const SizedBox(height: 5.0),
        TaskList(taskList: _taskService.getCompleted, sort: "Created"),
      ],
    );
  }
}
