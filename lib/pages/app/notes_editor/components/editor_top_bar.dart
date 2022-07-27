import 'package:flutter/material.dart';
import 'package:my_mind/router/my_router.dart';
import 'package:my_mind/router/router_page_manager.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../states/language_state.dart';
import '../../../../utilities/utilities.dart';

class EditorTopBar extends StatefulWidget {
  const EditorTopBar({Key? key}) : super(key: key);

  @override
  State<EditorTopBar> createState() => _EditorTopBarState();
}

class _EditorTopBarState extends State<EditorTopBar>
    with SingleTickerProviderStateMixin {
  late LanguageState _languageState;
  double _rotationViewMoreIcon = 0.0;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
  }

  @override
  Widget build(BuildContext context) {
    return buildTitleRow();
  }

  Widget buildTitleRow() {
    return Material(
      color: Constants.paletteSelected["dark"],
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, top: 12.0, right: 12.0, bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                splashRadius: 25,
                onPressed: () =>
                    RouterPageManager.of(context).goToPage(MyRouterPath.app()),
                icon: const Icon(Icons.arrow_back_outlined)),
            const Expanded(
                child: FittedBox(fit: BoxFit.scaleDown, child: Text("Titulo"))),
            // Custom popup menu with animation
            IconButton(
              splashRadius: 25,
              tooltip: _languageState.getText(TextKeys.txtOptions),
              onPressed: () {
                changeRotation();
                final RenderBox button =
                    context.findRenderObject()! as RenderBox;
                final RenderBox overlay = Navigator.of(context)
                    .overlay!
                    .context
                    .findRenderObject()! as RenderBox;
                const Offset offset = Offset(25, 50);
                final RelativeRect position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(offset, ancestor: overlay),
                    button.localToGlobal(
                        button.size.bottomRight(Offset.zero) + offset,
                        ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );
                showMenu(
                        context: context,
                        items: [
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.title_outlined),
                              title: Text(_languageState
                                  .getText(TextKeys.txtChangeTitle)),
                            ),
                            onTap: () => UtilitiesFunctions.showSnackbar(
                                context,
                                _languageState
                                    .getText(TextKeys.txtAvailableSoon)),
                          )
                        ],
                        position: position,
                        shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                  Constants.appDefaultBorderRadius),
                              topRight: Radius.circular(
                                  Constants.appDefaultBorderRadius),
                              bottomLeft: Radius.circular(
                                  Constants.appDefaultBorderRadius),
                              bottomRight: Radius.circular(
                                  Constants.appDefaultBorderRadius),
                            ),
                            side: BorderSide(
                                color: Constants.paletteSelected["medium"]!,
                                width: 1.5)),
                        color: PopupMenuTheme.of(context).color)
                    .then((value) => changeRotation());
              },
              icon: AnimatedRotation(
                turns: _rotationViewMoreIcon,
                duration: const Duration(milliseconds: 100),
                child: const Icon(Icons.more_horiz_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeRotation() {
    setState(() {
      _rotationViewMoreIcon = _rotationViewMoreIcon > 0 ? 0.0 : 0.25;
    });
  }
}
