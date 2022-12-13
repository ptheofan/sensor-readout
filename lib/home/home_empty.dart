import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmpty extends ConsumerWidget {
  const HomeEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Text(
            'No sensors have been configured.'.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}