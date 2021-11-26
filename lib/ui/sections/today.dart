import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tudulis/shared/format_date.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';
import 'package:provider/provider.dart';
import 'package:tudulis/services/task_service.dart';
import 'package:tudulis/ui/components/sort_button.dart';
import 'package:tudulis/ui/components/task_list.dart';

class TodaySection extends StatefulWidget {
  const TodaySection({Key? key}) : super(key: key);

  @override
  State<TodaySection> createState() => _TodaySectionState();
}

class _TodaySectionState extends State<TodaySection> {
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
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: _localizations.todaySection,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: "  " + formatDate(context, DateTime.now())),
                ],
              ),
            ),
            const Spacer(),
            SortButton(changeSort: changeSort, isTodaySection: true),
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
        TaskList(taskList: _taskService.getToday, sort: sort),
      ],
    );
  }
}
