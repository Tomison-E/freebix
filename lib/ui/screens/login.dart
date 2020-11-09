import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freebix/core/services/authentication.dart';
import 'package:freebix/utils/colors.dart';
import 'package:freebix/utils/theme.dart';
import 'package:freebix/utils/uiData.dart';
import 'package:freebix/utils/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password/password.dart';
import 'package:freebix/core/repositories/user.dart' as login;

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:  SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.all(30),
     child:Column(
         children: [
           const SizedBox(height:100),
           Row(children: [
             const SizedBox(width: 10),
             CircleAvatar(child:Icon(Icons.flash_on,color:Colors.white),radius: 20,backgroundColor: Colors.blue),
             const SizedBox(width: 15),
             Text("HACKATHON",style: TextStyle(color: Colours.navBarText,fontSize: 25,fontWeight: FontWeight.bold))
           ],mainAxisAlignment: MainAxisAlignment.center),
           const SizedBox(height:35),
           Text("Welcome Back",style: TextStyle(color: Colours.navBarText,fontSize: 18,fontWeight: FontWeight.bold)),
           const SizedBox(height:20),
           Text("Please sign in", style: Style.regText),
           const SizedBox(height:30),
           LoginForm(),
         ],
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
       ))),
   );
  }
  
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formWasEdited = false;
  Validators validate;
  String email, password;


  @override
  void initState() {
    validate = Validators(_formWasEdited);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text(value)
    ));
  }

  String hash(String password){
    final algorithm = PBKDF2();
    final hash = Password.hash(password, algorithm);
    return hash;
  }

  Future<void> _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
        _showDialog(context);
       final test = await context.read(authenticationProvider).signIn(email, hash(password));
        test.maybeWhen(
          success: (bool data) async{
            Navigator.pop(context);
            final user = context.read(fireBaseAuthProvider).currentUser;
            if (!user.emailVerified) {
              await user.sendEmailVerification();
              showInSnackBar("Check email address for veriication link");
              //Navigator.pushNamed(context, UIData.otpRoute);
            }
            else {
              _autoValidate = AutovalidateMode.disabled;
              _reset(form);
              Navigator.pushNamed(context, UIData.homeRoute);};
          },
          error: (String errorMsg) {
            Navigator.pop(context);
            showInSnackBar(errorMsg);
          },
          orElse: () {
          Navigator.pop(context);
          showInSnackBar('Login Unsuccessful');
        },
        );
      }
  }

  void _reset(FormState form) {
    form.reset();
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('This form has errors'),
          content: const Text('Really leave this form?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ], 
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      onWillPop: _warnUserAboutInvalidData,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                focusColor: Color.fromRGBO(76, 232, 149, 1.0),
                enabledBorder: Style.outlineInputBorder,
                focusedBorder: Style.outlineInputBorder,
                hintText: "Email Address",
                hintStyle: Style.hintText
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            onSaved: (String email) => this.email = email,
            validator: (String email) => validate.validateEmail(email),
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
              focusColor: Color.fromRGBO(76, 232, 149, 1.0),
              enabledBorder: Style.outlineInputBorder,
              focusedBorder: Style.outlineInputBorder,
              hintText: "Password",
              hintStyle: Style.hintText,
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            obscureText: true,
            onSaved: (String password) => this.password = password,
            validator: (String password) => validate.validatePassword(password),
          ),
          const SizedBox(height: 40.0),
          SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(onPressed: () => _handleSubmitted(),
                child: Text("Sign in", style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16.0)),
                color: Color.fromRGBO(87, 165, 244, 1.0),
                highlightColor: Colors.white,
                hoverColor: Colors.black,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(left: 60.0, right: 60.0),)
          ),
          const SizedBox(height: 20),
          Divider(),
          const SizedBox(height: 10),
          Row(children: [
            const Text("Forgot Password?", style: TextStyle(
                color: Color.fromRGBO(87, 165, 244, 1.0), fontSize: 15.0)),
            Spacer(),
            const Text("New user?", style: TextStyle(
                color: Colors.black, fontSize: 15.0)),
            FlatButton(
                onPressed: ()=>Navigator.pushNamed(context, UIData.registerRoute), child: Text("Sign up", style: TextStyle(
                color: Color.fromRGBO(87, 165, 244, 1.0), fontSize: 15.0)),padding: EdgeInsets.all(1),)
          ],)

        ], mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: Text("Signing In"),
          content: Column(
              children: [
                SizedBox(height: 20.0),
                CupertinoActivityIndicator()
              ]),
        );
      },
    );
  }

}