import 'package:flutter/material.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';

part 'widgets/support_header.dart';
part 'widgets/support_action_buttons.dart';
part 'widgets/fast_solutions_list.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: FakeSpacing.md,
            vertical: FakeSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SupportHeader(),
              SupportActionButtons(),
              FastSolutionsList(),
            ],
          ),
        ),
      ),
    );
  }
}
