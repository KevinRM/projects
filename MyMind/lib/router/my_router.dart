import 'package:flutter/material.dart';
import 'package:my_mind/api/interfaces/base_element.dart';
import 'package:my_mind/pages/app/app_page.dart';
import 'package:my_mind/pages/app/notes_editor/notes_editor_page.dart';
import 'package:my_mind/pages/error_network/error_network.dart';
import 'package:my_mind/pages/home/home_page.dart';
import 'package:my_mind/pages/sign_in/sign_in_page.dart';

import '../pages/error/error_page.dart';
import '../pages/sign_up/sign_up_page.dart';
import '../pages/splash/splash_page.dart';
import 'transition_page_animation.dart';

class Pages {
  static const String home = "/";
  static const String splash = home + "loading";
  static const String signin = home + "signin";
  static const String signup = home + "signup";
  static const String app = home + "app";
  static const String noteEditor = app + "/editor";
  static const String errorNetwork = home + "errornetwork";
  static const String errorPage = home + "404";
}

class MyRouterPath {
  final String pagePath;
  final Page page;
  bool unique = false;
  dynamic parameter;

  MyRouterPath.home()
      : pagePath = Pages.home,
        page = TransitionPageAnimation(
            child: const HomePage(),
            keyParam: UniqueKey(),
            nameParam: Pages.home),
        unique = true;
  MyRouterPath.splash()
      : pagePath = Pages.splash,
        page = TransitionPageAnimation(
            child: const SplashPage(),
            keyParam: UniqueKey(),
            nameParam: Pages.splash);
  MyRouterPath.signin()
      : pagePath = Pages.signin,
        page = TransitionPageAnimation(
            child: const SignInPage(),
            keyParam: UniqueKey(),
            nameParam: Pages.signin),
        unique = true;
  MyRouterPath.signup()
      : pagePath = Pages.signup,
        page = TransitionPageAnimation(
            child: const SignUpPage(),
            keyParam: UniqueKey(),
            nameParam: Pages.signup),
        unique = true;
  MyRouterPath.app()
      : pagePath = Pages.app,
        page = TransitionPageAnimation(
            child: const AppPage(),
            keyParam: UniqueKey(),
            nameParam: Pages.app),
        unique = true;
  MyRouterPath.noteEditor(ElementType elementType, {String? elementId})
      : pagePath = Pages.noteEditor +
            "/" +
            elementType.name +
            (elementId != null ? "/" + elementId : ""),
        page = TransitionPageAnimation(
            child: NotesEditorPage(
              elementType: elementType,
              elementId: elementId,
            ),
            keyParam: UniqueKey(),
            nameParam: Pages.noteEditor +
                "/" +
                elementType.name +
                (elementId != null ? "/" + elementId : "")),
        unique = true;
  MyRouterPath.errorNetwork()
      : pagePath = Pages.errorNetwork,
        page = TransitionPageAnimation(
            child: const ErrorNetworkPage(),
            keyParam: UniqueKey(),
            nameParam: Pages.errorNetwork);
  MyRouterPath.errorPage()
      : pagePath = Pages.errorPage,
        page = TransitionPageAnimation(
            child: const ErrorPage(),
            keyParam: UniqueKey(),
            nameParam: Pages.errorPage);

  // Para parsear las rutas entrantes (RouteInformation) y convertirlo en una tipo definido por el usuario
  static MyRouterPath parseUrl(String url) {
    final uri = Uri.parse(url);

    print("Path: " + uri.path);

    if (uri.pathSegments.isEmpty) {
      // Handle '/'
      return MyRouterPath.home();
    } else {
      // Handle '/page
      if (uri.pathSegments.length == 1) {
        String segment = "/" + uri.pathSegments.elementAt(0);
        switch (segment) {
          case Pages.splash:
            return MyRouterPath.splash();
          case Pages.signin:
            return MyRouterPath.signin();
          case Pages.signup:
            return MyRouterPath.signup();
          case Pages.app:
            return MyRouterPath.app();
          case Pages.errorNetwork:
            return MyRouterPath.errorNetwork();
        }
      }
      // Handle '/page/page2/page3'
      if (uri.pathSegments.length >= 3) {
        String segment1 = "/" + uri.pathSegments.elementAt(0);
        switch (segment1) {
          case Pages.app:
            String segment2 = segment1 + "/" + uri.pathSegments.elementAt(1);
            switch (segment2) {
              case Pages.noteEditor:
                String segment3 =
                    segment2 + "/" + uri.pathSegments.elementAt(2);
                ElementType elementType = ElementType.values.firstWhere(
                    (el) =>
                        el.name.toString() ==
                        uri.pathSegments.elementAt(2).toString(),
                    orElse: () => ElementType.noType);

                // Si no existe tipo indicado -> ERROR
                if (elementType == ElementType.noType) {
                  return MyRouterPath.errorPage();
                }
                return MyRouterPath.noteEditor(elementType);
              // TODO: Implement receive note ID from URL
            }
        }
        // if (uri.pathSegments.length > 1) {
        //   segment = segment + "/" + uri.pathSegments.elementAt(1);
        //   print("Path");
        //   print(uri.pathSegments.length);
        //   print(uri.path);
        //   switch (segment) {
        //     case Pages.noteEditor:
        //       // Tiene que traer como minimo el tipo de elemento
        //       if (uri.pathSegments.length > 2) {
        //         // Debe traer /tipo o /tipo/id
        //         ElementType elementType = ElementType.values.firstWhere(
        //             (el) =>
        //                 el.toString() ==
        //                 uri.pathSegments.elementAt(2).toString(),
        //             orElse: () => ElementType.noType);
        //         // Si no existe tipo indicado ERROR
        //         if (elementType == ElementType.noType) {
        //           pathToReturn = MyRouterPath.errorPage();
        //           break;
        //         }

        //         segment = segment + "/" + uri.pathSegments.elementAt(2);

        //         // Vemos si trae ID
        //         if (uri.pathSegments.length > 3) {
        //           segment = segment + "/" + uri.pathSegments.elementAt(3);
        //           pathToReturn = MyRouterPath.noteEditor(elementType,
        //               elementId: uri.pathSegments.elementAt(3));
        //         } else {
        //           pathToReturn = MyRouterPath.noteEditor(elementType);
        //         }
        //       } else {
        //         pathToReturn = MyRouterPath.errorPage();
        //       }
        //       break;
        //     default:
        //       pathToReturn = MyRouterPath.errorPage();
        //       break;
        //   }
        // }
      }
      return MyRouterPath.errorPage();
    }
  }
}
