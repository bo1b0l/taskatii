// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasaktii/core/models/task_model.dart';
import 'package:tasaktii/core/utils/colors.dart';
import 'package:tasaktii/core/utils/text_style.dart';

class Task_Item_Widget extends StatelessWidget {
  const Task_Item_Widget({super.key, required this.model});
  final TaskModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: model.color == 0
              ? AppColors.primary
              : model.color == 1
                  ? AppColors.orange
                  : model.color == 2
                      ? AppColors.red
                      : AppColors.green,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: AppTextStyle.getTtileTextStyle(context,
                      color: AppColors.white),
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.alarm, color: AppColors.white),
                    const Gap(5),
                    Text(
                      model.startTime + model.endTime,
                      style: AppTextStyle.getSmallTextStyle(context,
                          color: AppColors.white),
                    ),
                  ],
                ),
                const Gap(5),
                Text(
                  model.description,
                  style: AppTextStyle.getbodymTextStyle(context,
                      color: AppColors.white),
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 80,
            color: AppColors.white,
          ),
          const Gap(5),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              " ${model.isComplete ? "COMPLETE" : "T O D O"} ",
              style: AppTextStyle.getTtileTextStyle(context,
                  fontSize: 14, color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }
}
