
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_translator_app/provider/translation_provider.dart';
import 'package:language_translator_app/widgets/input_card.dart';
import 'package:language_translator_app/widgets/translation_card.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Language Translator",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/LT_home.webp",
                  height: 200.h,
                  width: 200.w,
                ),
                InputCard(controller: _inputController),
                SizedBox(
                  height: 10.h,
                ),
                TranslationCard(inputController: _inputController),
                SizedBox(
                  height: 20.h,
                ),
               _translationButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _translationButton() {
    return Consumer<TranslationProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                provider.translateText();
              },
              child: Text(
                "Translate",
              )),
        );
      },
    );
  }
}
