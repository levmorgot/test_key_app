import 'package:flutter/material.dart';
import 'package:key_test_project/common/app_colors.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColors.progressIndicator,
    );
  }
}
