import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasaktii/core/functions/navigation.dart';
import 'package:tasaktii/core/utils/text_style.dart';
import 'package:tasaktii/core/utils/widgets/custom_button.dart';
import 'package:tasaktii/feature/add_task/add_task.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: AppTextStyle.getTtileTextStyle(
                    context,
                  )),
              Text("Today.",
                  style: AppTextStyle.getTtileTextStyle(
                    context,
                  ))
            ],
          ),
        ),
        CustomButton(
          text: '+ Add Task',
          onPressed: () {
            push(context, const AddTask());
          },
          width: 140,
        ),
      ],
    );
  }
}
