import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/add_task.dart';
import 'package:tudulis/ui/components/sort_button.dart';
import 'package:tudulis/ui/components/task_list.dart';

class AllSection extends StatefulWidget {
  const AllSection({Key? key}) : super(key: key);

  @override
  _AllSectionState createState() => _AllSectionState();
}

class _AllSectionState extends State<AllSection> {
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
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _localizations.allSect,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SortButton(
              changeSort: (String val) {
                _settingsService.setSectionSort("all", val);
              },
              sort: _settingsService.getSectionSort("all"),
            ),
          ],
        ),
        const AddTask(),
        const SizedBox(height: 5.0),
        TaskList(
          taskList: _taskService.getAll,
          sort: _settingsService.getSectionSort("all"),
        ),
      ],
    );
  }
}
