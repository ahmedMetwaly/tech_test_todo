import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/core/constants/values_manager.dart';
import 'package:todo/core/utils/image_manager.dart';
import 'package:todo/core/utils/media_query_utils.dart';
import 'package:todo/core/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(
       Routes.home  
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(PaddingManager.pMainPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImageManager.splash,
                  width: MediaQueryUtils.getWidthPercentage(context, 0.8),
                  height: MediaQueryUtils.getHeightPercentage(context, 0.4)),
              const SizedBox(height: SizeManager.sSpace),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
