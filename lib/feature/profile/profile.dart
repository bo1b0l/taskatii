import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasaktii/core/service/local_storage.dart';
import 'package:tasaktii/core/utils/colors.dart';
import 'package:tasaktii/core/utils/text_style.dart';
import 'package:tasaktii/core/utils/widgets/custom_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? path;
  String name = "";
  @override
  void initState() {
    super.initState();
    path = AppLocalStorage.getcachedata(AppLocalStorage.kimage);
    name = AppLocalStorage.getcachedata(AppLocalStorage.kname) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    bool mode =
        AppLocalStorage.getcachedata(AppLocalStorage.kisdarkmode) ?? false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
             setState(() {
                AppLocalStorage.cacheData(AppLocalStorage.kname, name);
              AppLocalStorage.cacheData(AppLocalStorage.kimage, path);
             });
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: AppColors.primary,
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  AppLocalStorage.cacheData(AppLocalStorage.kisdarkmode, !mode);
                });
              },
              color: AppColors.primary,
              icon: mode
                  ? const Icon(
                      Icons.light_mode,
                    )
                  : const Icon(
                      Icons.dark_mode,
                    ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 120,
                      backgroundImage: (path != null)
                          ? FileImage(File(path ?? ""))
                          : const AssetImage("assets/panda.jpg"),
                    ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          CustomButton(
                                            text: "camera",
                                            onPressed: () {
                                              pickImage(true);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          const Gap(10),
                                          CustomButton(
                                            text: "Gallery",
                                            onPressed: () {
                                              pickImage(false);
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Icon(
                                Icons.camera_alt,
                                color: AppColors.primary,
                              )),
                        ))
                  ],
                ),
                const Gap(20),
                const Divider(),
                const Gap(20),
                Row(
                  children: [
                    Text(
                      name,
                      style: AppTextStyle.getTtileTextStyle(
                        context,
                      ),
                    ),
                    const Spacer(),
                    IconButton.outlined(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (value) {
                                          name = value;
                                        },
                                      ),
                                      const Gap(10),
                                      CustomButton(
                                          text: "Update Your Name",
                                          onPressed: () {
                                            setState(() {
                                              AppLocalStorage.cacheData(
                                                  AppLocalStorage.kname, name);
                                            });
                                            Navigator.pop(context);
                                          })
                                    ],
                                  ),
                                ),
                              );
                            }).then(
                          (value) {
                            setState(() {});
                          },
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                    )
                  ],
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
        AppLocalStorage.cacheData(AppLocalStorage.kimage, path);
      }
    });
  }
}
