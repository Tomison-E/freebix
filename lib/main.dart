import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freebix/utils/uiData.dart';
import 'package:freebix/router/router.dart' as Controller ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( ProviderScope(
    child: MyApp(),
  ));
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
              title: 'Flutter Hackathon',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home:Container(color: Colors.white, child: Center(child:Text("Error Initializing Firebase"))) );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ProviderScope(
            child: MyApp(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
            title: 'Flutter Hackathon',
            theme: ThemeData(
            primarySwatch: Colors.blue,
        ),
        home:Container(color: Colors.white, child: Text("Initializing Firebase")) );
      },
    );
  }
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hackathon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Controller.Router.generateRoute,
      onUnknownRoute: Controller.Router.unknownRoute,
      initialRoute: UIData.loginRoute,
    );
  }
}
