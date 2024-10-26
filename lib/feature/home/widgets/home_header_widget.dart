import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasaktii/core/functions/navigation.dart';
import 'package:tasaktii/core/service/local_storage.dart';
import 'package:tasaktii/core/utils/colors.dart';
import 'package:tasaktii/core/utils/text_style.dart';
import 'package:tasaktii/feature/profile/profile.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
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
              Text(
                  "Hello ${AppLocalStorage.getcachedata(AppLocalStorage.kname)} ",
                  style: AppTextStyle.getTtileTextStyle(context,
                      color: AppColors.primary)),
              Text("Have A nice Day .",
                  style: AppTextStyle.getbodymTextStyle(
                    context,
                  ))
            ],
          ),
        ),
        InkWell(
          onTap: () {
            push(context, const Profile());
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            backgroundImage: AppLocalStorage.getcachedata(
                        AppLocalStorage.kimage) !=
                    null
                ? FileImage(
                    File(AppLocalStorage.getcachedata(AppLocalStorage.kimage)))
                : const AssetImage('assets/user.png'),
          ),
        )
      ],
    );
  }
}
