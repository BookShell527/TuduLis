import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({Key? key, this.toggleOpen}) : super(key: key);

  final void Function()? toggleOpen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.any({MaterialState.pressed}.contains)) {
              return Colors.transparent;
            }
          }),
        ),
        icon: const Icon(Icons.add),
        onPressed: toggleOpen,
        label: const Text("Add task"),
      ),
    );
  }
}
