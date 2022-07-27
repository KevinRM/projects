import 'package:evogalaxy/components/custom_divider.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';

class FaqComp extends StatelessWidget {
  const FaqComp({Key? key, required this.languageState}) : super(key: key);
  final LanguageState languageState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            languageState.getText(TextKeys.faqTitle),
            style: const TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
        const CustomDivider(),
        const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(languageState.getText(TextKeys.faqDescription)),
          const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
          // ExpansionPanelList.radio(
          //   children: [
          //     ExpansionPanelClass(
          //         id: 1, // Increment id
          //         header: const ListTile(
          //           title: Text("Question 1"),
          //         ),
          //         body: const Text("Answer")),
          //   ].map<ExpansionPanelRadio>((ExpansionPanelClass e) {
          //     return ExpansionPanelRadio(
          //       canTapOnHeader: true,
          //       value: e.id,
          //       backgroundColor: Constants.paletteSelected["medium"],
          //       headerBuilder: ((context, isExpanded) {
          //         return e.header;
          //       }),
          //       body: Column(
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           Padding(
          //             padding:
          //                 const EdgeInsets.all(Constants.appDefaultPadding),
          //             child: e.body,
          //           ),
          //         ],
          //       ),
          //     );
          //   }).toList(),
          // )
        ])
      ],
    );
  }
}
