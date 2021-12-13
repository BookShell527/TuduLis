import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/models/task.dart';
import 'package:tudulis/services/settings_service.dart';
import 'package:tudulis/ui/components/add_task.dart';
import 'package:tudulis/ui/components/sort_button.dart';
import 'package:tudulis/ui/components/task_list.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.section,
    required this.title,
    required this.taskList,
    this.withDate = false,
    this.withSortButton = true,
  }) : super(key: key);

  final String section;
  final String title;
  final List<Task> taskList;
  final bool withDate;
  final bool withSortButton;

  @override
  Widget build(BuildContext context) {
    final SettingsService _settingsService =
        Provider.of<SettingsService>(context);
    final AppLocalizations _localizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (withDate)
                    TextSpan(
                      text: "  " +
                          DateFormat(
                            "EEEE, d MMMM y",
                            _localizations.localeName,
                          ).format(
                            DateTime.now(),
                          ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            if (withSortButton)
              SortButton(
                changeSort: (String val) {
                  _settingsService.setSectionSort(section, val);
                },
                sort: _settingsService.getSectionSort(section),
              ),
          ],
        ),
        const AddTask(),
        const SizedBox(height: 5.0),
        TaskList(
          taskList: taskList,
          sort: _settingsService.getSectionSort(section),
        ),
      ],
    );
  }
}
