import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasaktii/core/functions/navigation.dart';
import 'package:tasaktii/core/models/task_model.dart';
import 'package:tasaktii/core/service/local_storage.dart';
import 'package:tasaktii/core/utils/colors.dart';
import 'package:tasaktii/core/utils/text_style.dart';
import 'package:tasaktii/core/utils/widgets/custom_button.dart';
import 'package:tasaktii/feature/home/page/home_view.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  int? colorIndex;
  String taskDate = DateFormat.yMd().format(DateTime.now());
  String startTime = DateFormat("hh:mm a").format(DateTime.now());
  String endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(hours: 1)));

  var titleController = TextEditingController();
  var noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "add Task",
            style: AppTextStyle.getTtileTextStyle(context,
                color: AppColors.primary, fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Title",
                style: AppTextStyle.getTtileTextStyle(context),
              ),
              const Gap(15),
              TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Ex: go to school",
                      hintStyle: AppTextStyle.getbodymTextStyle(context))),
              const Gap(15),
              Text(
                "Note",
                style: AppTextStyle.getTtileTextStyle(context),
              ),
              const Gap(15),
              TextFormField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: "Ex: go to school",
                    hintStyle: AppTextStyle.getbodymTextStyle(context)),
              ),
              const Gap(15),
              Text(
                "Date",
                style: AppTextStyle.getTtileTextStyle(context),
              ),
              const Gap(15),
              TextFormField(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030))
                      .then((value) {
                    setState(() {
                      if (value != null) {
                        taskDate = DateFormat.yMd().format(value);
                      }
                    });
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: taskDate,
                  hintStyle: AppTextStyle.getbodymTextStyle(context),
                  suffix: const Icon(Icons.date_range),
                ),
              ),
              const Gap(15),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Start time",
                      style: AppTextStyle.getTtileTextStyle(context),
                    ),
                  ),
                  const Gap(15),
                  Expanded(
                    child: Text(
                      "End time",
                      style: AppTextStyle.getTtileTextStyle(context),
                    ),
                  ),
                ],
              ),
              const Gap(15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          setState(() {
                            if (value != null) {
                              startTime = value.format(context);
                            }
                          });
                        });
                      },
                      decoration: InputDecoration(
                        hintText: startTime,
                        hintStyle: AppTextStyle.getbodymTextStyle(context),
                        suffix: const Icon(Icons.date_range),
                      ),
                    ),
                  ),
                  const Gap(15),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          setState(() {
                            if (value != null) {
                              endTime = value.format(context);
                            }
                          });
                        });
                      },
                      decoration: InputDecoration(
                        hintText: endTime,
                        hintStyle: AppTextStyle.getbodymTextStyle(context),
                        suffix: const Icon(
                          Icons.date_range,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Gap(15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Color",
                          style: AppTextStyle.getTtileTextStyle(context),
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: List.generate(3, (int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          colorIndex = index;
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor: index == 0
                                            ? AppColors.primary
                                            : index == 1
                                                ? AppColors.orange
                                                : AppColors.red,
                                        child: colorIndex == index
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      text: "Create Task",
                      onPressed: () {
                        String id =
                            "${titleController.text}--${DateTime.now()}";
                        AppLocalStorage.cacheTaskData(
                            id,
                            TaskModel(
                                id: id,
                                title: titleController.text,
                                description: noteController.text,
                                datetime: taskDate,
                                startTime: startTime,
                                endTime: endTime,
                                color: colorIndex!,
                                isComplete: false));
                        log(AppLocalStorage.getcacheTaskdata(id)
                                ?.title
                                .toString() ??
                            "");
                        pushReplacement(context, const HomeView());
                      },
                      height: 50,
                      width: 70,
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}
