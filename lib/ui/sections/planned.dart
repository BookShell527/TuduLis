import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/services/settings_service.dart';
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
  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    final SettingsService _settingsService =
        Provider.of<SettingsService>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Text(
              _localizations.plannedSect,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SortButton(
              changeSort: (String val) {
                _settingsService.setSectionSort("planned", val);
              },
              sort: _settingsService.getSectionSort("planned"),
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
        TaskList(
          taskList: _taskService.getPlanned,
          sort: _settingsService.getSectionSort("planned"),
        ),
      ],
    );
  }
}
