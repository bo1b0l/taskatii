import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasaktii/core/functions/navigation.dart';
import 'package:tasaktii/core/service/local_storage.dart';
import 'package:tasaktii/core/utils/colors.dart';
import 'package:tasaktii/core/utils/text_style.dart';
import 'package:tasaktii/core/utils/widgets/custom_button.dart';
import 'package:tasaktii/feature/home/page/home_view.dart';

class Uplode extends StatefulWidget {
  const Uplode({super.key});

  @override
  State<Uplode> createState() => _UplodeState();
}

class _UplodeState extends State<Uplode> {
  String? path;
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (path != null && name.isNotEmpty) {
                setState(() {
                  AppLocalStorage.cacheData(AppLocalStorage.kimage, path);
                  AppLocalStorage.cacheData(AppLocalStorage.kname, name);
                  AppLocalStorage.cacheData(AppLocalStorage.kisuplode, true);
                  pushReplacement(context, const HomeView());
                });
              } else if (name.isNotEmpty && path == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Please Uplode Picture"),
                  backgroundColor: AppColors.red,
                ));
              } else if (name.isEmpty && path != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Please Enter Name "),
                  backgroundColor: AppColors.red,
                ));
              } else if (name.isEmpty && path == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Please Do Something"),
                  backgroundColor: AppColors.red,
                ));
              }
            },
            child: Text(
              "Done",
              style: AppTextStyle.getSmallTextStyle(
                context,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 120,
                  backgroundImage: (path != null)
                      ? FileImage(File(path ?? ""))
                      : const AssetImage("assets/user.png"),
                ),
                const Gap(20),
                CustomButton(
                  text: "Uplode From Camera",
                  onPressed: () {
                    pickImage(true);
                  },
                ),
                const Gap(20),
                CustomButton(
                  text: "Uplode From Gallery",
                  onPressed: () {
                    pickImage(false);
                  },
                ),
                const Gap(20),
                const Divider(),
                const Gap(20),
                TextFormField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Your Name",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage(bool iscamera) {
    ImagePicker()
        .pickImage(
            source: (iscamera) ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        setState(() {
          path = value.path;
        });
      }
    });
  }
}
