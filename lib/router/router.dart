

import 'package:flutter/material.dart';
import 'package:freebix/ui/screens/home.dart';
import 'package:freebix/ui/screens/login.dart';
import 'package:freebix/ui/screens/not_found.dart';
import 'package:freebix/ui/screens/register.dart';
import 'package:freebix/ui/widgets/bvn.dart';
import 'package:freebix/ui/widgets/otp.dart';
import 'package:freebix/ui/widgets/passport.dart';
import 'package:freebix/utils/uiData.dart';



class Router {


    static Route<dynamic> generateRoute(settings) {
      switch (settings.name) {
        case UIData.homeRoute:
          return MaterialPageRoute(builder: (_) => Home());
          break;
        case UIData.loginRoute:
          return MaterialPageRoute(builder: (_) => Login());
          break;
        case UIData.registerRoute:
          return MaterialPageRoute(builder: (_) => Register());
          break;
        case UIData.bvnRoute:
          return MaterialPageRoute(builder: (_) => BVN());
          break;
        case UIData.passportRoute:
          return MaterialPageRoute(builder: (_) => Passport(email: settings.arguments));
          break;
        case UIData.otpRoute:
          return MaterialPageRoute(builder: (_) => OTP());
          break;
        default: return  MaterialPageRoute(
            builder: (context) => new NotFoundPage());
      }

    }

    static Route<dynamic>  unknownRoute (settings) {
      return  MaterialPageRoute(
        builder: (context) => new NotFoundPage());
    }

}




