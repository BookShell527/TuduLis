import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool _isOpened = false;
  bool isImportant = false;
  bool isChecked = false;

  Color getCheckboxColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) return Colors.blue;
    return Colors.grey;
  }

  Color? getButtonColor(Set<MaterialState> states) {
    if (states.any({MaterialState.pressed}.contains)) return Colors.transparent;
  }

  final InputDecoration _inputDecoration = const InputDecoration(
    isDense: true,
    border: InputBorder.none,
  );

  @override
  Widget build(BuildContext context) {
    return _isOpened
        ? Container(
            padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Checkbox(
                  value: isChecked,
                  fillColor:
                      MaterialStateProperty.resolveWith(getCheckboxColor),
                  onChanged: (val) => setState(() => isChecked = !isChecked),
                  splashRadius: 0.1,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: _inputDecoration.copyWith(
                          hintText: "Title",
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: _inputDecoration.copyWith(
                          hintText: "Note for this task...",
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.alarm,
                              size: 20.0,
                              color: Colors.teal,
                            ),
                            splashRadius: 0.1,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              isImportant ? Icons.star_outline : Icons.star,
                              size: 20.0,
                              color: Colors.blue,
                            ),
                            splashRadius: 0.1,
                            onPressed: () {
                              setState(() => isImportant = !isImportant);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 20.0,
                              color: Colors.pink,
                            ),
                            splashRadius: 0.1,
                            onPressed: () {
                              setState(() => _isOpened = !_isOpened);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith(getButtonColor),
              ),
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => _isOpened = !_isOpened),
              label: const Text("Add task"),
            ),
          );
  }
}
