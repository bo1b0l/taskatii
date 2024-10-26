import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasaktii/core/functions/navigation.dart';
import 'package:tasaktii/core/service/local_storage.dart';
import 'package:tasaktii/core/utils/text_style.dart';
import 'package:tasaktii/feature/home/page/home_view.dart';
import 'package:tasaktii/feature/upload/uplode.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          (AppLocalStorage.getcachedata(AppLocalStorage.kisuplode) ?? false)
              ? const HomeView()
              : const Uplode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/logo.json"),
            Text(
              "TASKATII",
              style: AppTextStyle.getTtileTextStyle(
                context,
              ),
            ),
            const Gap(10),
            Text(
              "it's time to be organized",
              style: AppTextStyle.getSmallTextStyle(
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
