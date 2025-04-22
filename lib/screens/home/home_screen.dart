import 'package:brain_buddy/widgets/feature_card.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:brain_buddy/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        customSearchInput(),
        const SizedBox(height: 20),
        NextSubmitButton(),
        const SizedBox(height: 20),
        FeatureCardGrid(),
      ],
    );
  }
}

