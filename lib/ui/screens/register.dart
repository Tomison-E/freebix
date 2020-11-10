import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebix/core/repositories/registration.dart';
import 'package:freebix/utils/theme.dart';
import 'package:freebix/utils/uiData.dart';
import 'package:freebix/utils/validators.dart';
import 'package:freebix/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password/password.dart';

class Register extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(automaticallyImplyLeading: false,
      title: Row(children: [
        const SizedBox(width: 10),
        CircleAvatar(child:Icon(Icons.flash_on,color:Colors.white),radius: 20,backgroundColor: Colors.blue),
        const SizedBox(width: 15),
        Text("HACKATHON",style: TextStyle(color: Colours.navBarText,fontSize: 25,fontWeight: FontWeight.bold))
      ],),
      elevation: 0.0,backgroundColor: Colors.transparent,centerTitle: false,),
      body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
         children: [
          const Text("Create your hackathon account",style: Style.regText),
          const SizedBox(height: 50),
           RegisterForm(),
          const SizedBox(height: 30),
         ],
            crossAxisAlignment: CrossAxisAlignment.start
        ),
      )
      ),
    );
  }

}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formWasEdited = false;
  Validators validate;
  TextEditingController txt;
  String username, email, password, name;


  @override
  void initState() {
    validate = Validators(_formWasEdited);
    txt = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    txt.dispose();
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
        final names = name.split(" ");
        //final _password = hash(password);
        final user = Registration(username, firstName: names[0], lastName: names[1] ?? names[0], email: email, password: password);
          final test = await context.read(registrationRepositoryProvider).register(user);
          test.maybeWhen(
            success: (bool data) {
              Navigator.pop(context);
              _autoValidate = AutovalidateMode.disabled;
              _reset(form);
              print("success");
               Navigator.pushNamed(context, UIData.loginRoute);
            },
            error: (String errorMsg) {
              Navigator.pop(context);
              showInSnackBar(errorMsg);
            },
            orElse: () {
              Navigator.pop(context);
              showInSnackBar('Registeration Unsuccessful');
            },
          );
      }
    }


  void _reset(FormState form) {
    form.reset();
    txt.text = "";
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
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

          const  Text("Email Address", style: Style.regText),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                focusColor: Color.fromRGBO(76, 232, 149, 1.0),
                enabledBorder: Style.outlineInputBorder,
                focusedBorder: Style.outlineInputBorder,
                border: Style.outlineInputBorder,
                hintText: "Email Address",
                hintStyle: Style.hintText
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            onSaved: (String email) => this.email = email,
            validator: (String email) => validate.validateEmail(email),
          ),
          const SizedBox(height: 30),
          const  Text("Name", style: Style.regText),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                focusColor: Color.fromRGBO(76, 232, 149, 1.0),
                enabledBorder: Style.outlineInputBorder,
                focusedBorder: Style.outlineInputBorder,
                border: Style.outlineInputBorder,
                hintText: "Name",
                hintStyle: Style.hintText
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            onSaved: (String name) => this.name = name,
            validator: (String name) => validate.validateName(name),
          ),
          const SizedBox(height: 30),
          const  Text("Username", style: Style.regText),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                focusColor: Color.fromRGBO(76, 232, 149, 1.0),
                enabledBorder: Style.outlineInputBorder,
                focusedBorder: Style.outlineInputBorder,
                border: Style.outlineInputBorder,
                hintText: "Username",
                hintStyle: Style.hintText
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            onSaved: (String name) => this.username = name,
            validator: (String name) => validate.validateName(name),
          ),
          const SizedBox(height: 30),
          const  Text("Password", style: Style.regText),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                focusColor: Color.fromRGBO(76, 232, 149, 1.0),
                enabledBorder: Style.outlineInputBorder,
                focusedBorder: Style.outlineInputBorder,
                border: Style.outlineInputBorder,
                hintText: "Password",
                hintStyle: Style.hintText,
                helperText: "use 8 or more characters \nwith a mix of letters, numbers & symbols",
                helperStyle: Style.helperText
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            obscureText: true,
            onSaved: (String password) => this.password = password,
            validator: (String password) => validate.validatePassword(password),
            controller: txt,
          ),
          const SizedBox(height: 30),
          const  Text("Confirm Password", style: Style.regText),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
                focusColor: Color.fromRGBO(76, 232, 149, 1.0),
                enabledBorder: Style.outlineInputBorder,
                focusedBorder: Style.outlineInputBorder,
                border: Style.outlineInputBorder,
                hintText: "Confirm Password",
                hintStyle: Style.hintText
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            obscureText: true,
            validator: (String password) => txt.text == password
                ? null
                : "Password doesn't match",
          ),
          const SizedBox(height: 30),
           FlatButton(
            onPressed: ()=> Navigator.pushNamed(context, UIData.loginRoute), child: const Text("Sign in instead?", style: TextStyle(
              color: Color.fromRGBO(87, 165, 244, 1.0), fontSize: 15.0))),
          const SizedBox(height: 40.0),
              SizedBox(
                height: 50,
                width:double.infinity,
                child:  RaisedButton(onPressed: () => _handleSubmitted(),
                  child: Text("Sign up", style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16.0)),
                  color: Color.fromRGBO(87, 165, 244, 1.0),
                  highlightColor: Colors.white,
                  hoverColor: Colors.black,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.only(left: 60.0, right: 60.0),)
              ),

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
          title: Text("Creating Account"),
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