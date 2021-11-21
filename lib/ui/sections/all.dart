import 'package:flutter/material.dart';
import 'package:tudulis/ui/components/add_task/add_task.dart';

class AllSection extends StatelessWidget {
  const AllSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text(
              "All",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
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
        const AddTask(),
      ],
    );
  }
}
