import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/ui/components/add_task.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/sort_button.dart';
import 'package:tudulis/ui/components/task_list.dart';

class ImportantSection extends StatefulWidget {
  const ImportantSection({Key? key}) : super(key: key);

  @override
  State<ImportantSection> createState() => _ImportantSectionState();
}

class _ImportantSectionState extends State<ImportantSection> {
  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = Provider.of<TaskService>(context);
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
		final SettingsService _settingsService = Provider.of<SettingsService>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Text(
              _localizations.importantSect,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SortButton(
              changeSort: (String val) {
                _settingsService.setSectionSort("important", val);
              },
              sort: _settingsService.getSectionSort("important"),
							isImportantSection: true,
            ),
          ],
        ),
        const AddTask(isImportant: true),
        const SizedBox(height: 5.0),
        TaskList(taskList: _taskService.getImportant, sort: _settingsService.getSectionSort("important"),),
      ],
    );
  }
}
