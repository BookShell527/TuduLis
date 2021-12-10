import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/ui/components/add_task.dart';
import 'package:tudulis/ui/components/sort_button.dart';
import 'package:tudulis/ui/components/task_list.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';

class PlannedSection extends StatefulWidget {
  const PlannedSection({Key? key}) : super(key: key);

  @override
  State<PlannedSection> createState() => _PlannedSectionState();
}

class _PlannedSectionState extends State<PlannedSection> {
  String sort = "Created";
  void changeSort(String newSort) => setState(() => sort = newSort);

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
              _localizations.plannedSection,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SortButton(changeSort: changeSort),
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
        TaskList(taskList: _taskService.getPlanned, sort: sort),
      ],
    );
  }
}
