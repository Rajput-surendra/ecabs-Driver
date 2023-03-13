import 'package:flutter/material.dart';
import 'package:qcabs_driver/Routes/page_routes.dart';
import 'BankDetails/UI/bank_details_page.dart';
import 'Login/UI/login_page.dart';
import 'Registration/UI/registration_page.dart';
import 'Verification/UI/verification_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginRoutes {
  static const String loginRoot = 'login/';
  static const String registration = 'login/registration';
  static const String verification = 'login/verification';
  static const String bankDetails = 'login/bankDetails';
}

class LoginNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState!.canPop();
        if (canPop) {
          navigatorKey.currentState!.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: LoginRoutes.loginRoot,
        onGenerateRoute: (RouteSettings settings) {
          late WidgetBuilder builder;
          switch (settings.name) {
            case LoginRoutes.loginRoot:
              builder = (BuildContext _) => LoginPage();
              break;
            case LoginRoutes.registration:
              String? phoneNumber = settings.arguments as String?;
              // phoneNumber
              builder = (BuildContext _) => RegisterPage("");
              break;
            case LoginRoutes.verification:
              builder = (BuildContext _) => VerificationPage("","");
              break;
            case LoginRoutes.bankDetails:
              builder = (BuildContext _) => BankDetailsPage( /*{
                    Navigator.pushNamed(context, PageRoutes.offlinePage);
                  }*/
              );
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}
