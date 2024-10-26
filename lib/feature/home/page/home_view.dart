import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tasaktii/core/models/task_model.dart';
import 'package:tasaktii/core/service/local_storage.dart';
import 'package:tasaktii/core/utils/colors.dart';
import 'package:tasaktii/core/utils/text_style.dart';
import 'package:tasaktii/feature/home/widgets/task_item_widget.dart';
import 'package:tasaktii/feature/home/widgets/home_header_widget.dart';
import 'package:tasaktii/feature/home/widgets/today_header_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  String selectedDate = DateFormat.yMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const HomeHeaderWidget(),
              const Gap(15),
              const TodayWidget(),
              const Gap(15),
              DatePicker(
                height: 100,
                width: 70,
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primary,
                selectedTextColor: Colors.white,
                dayTextStyle: AppTextStyle.getbodymTextStyle(context),
                dateTextStyle: AppTextStyle.getbodymTextStyle(context),
                monthTextStyle: AppTextStyle.getbodymTextStyle(context),
                onDateChange: (date) {
                  setState(() {
                    selectedDate = DateFormat.yMd().format(date);
                  });
                },
              ),
              const Gap(15),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: AppLocalStorage.taskbox.listenable(),
                    builder: (context, taskbox, child) {
                      List<TaskModel> tasks = [];
                      for (var key in taskbox.keys) {
                        if (selectedDate ==
                            AppLocalStorage.getcacheTaskdata(key)?.datetime) {
                          tasks.add(AppLocalStorage.getcacheTaskdata(key)!);
                        }
                      }
                      return tasks.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/emptyTask.json'),
                                  Text(
                                    'No Tasks Found',
                                    style: AppTextStyle.getbodymTextStyle(
                                        context,
                                        color: AppColors.primary),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                    key: UniqueKey(),
                                    background: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: AppColors.green),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_sharp,
                                              color: AppColors.white,
                                            ),
                                            Text(
                                              "Complete",
                                              style: AppTextStyle
                                                  .getTtileTextStyle(context,
                                                      color: AppColors.white),
                                            ),
                                          ],
                                        )),
                                    secondaryBackground: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.red,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: AppColors.white,
                                          ),
                                          Text(
                                            "Delete",
                                            style:
                                                AppTextStyle.getTtileTextStyle(
                                                    context,
                                                    color: AppColors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        taskbox.delete(tasks[index].id);
                                      } else {
                                        taskbox.put(
                                            tasks[index].id,
                                            TaskModel(
                                                id: tasks[index].id,
                                                title: tasks[index].title,
                                                description:
                                                    tasks[index].description,
                                                datetime: tasks[index].datetime,
                                                startTime:
                                                    tasks[index].startTime,
                                                endTime: tasks[index].endTime,
                                                color: 3,
                                                isComplete: true));
                                      }
                                    },
                                    child: Task_Item_Widget(
                                      model: tasks[index],
                                    ));
                              },
                            );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
