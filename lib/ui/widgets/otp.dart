import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freebix/utils/colors.dart';
import 'package:freebix/utils/theme.dart';
import 'package:freebix/utils/uiData.dart';
import 'package:freebix/utils/validators.dart';

class OTP extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent,automaticallyImplyLeading: true,iconTheme: IconThemeData(color: Colors.black),),
        body: SingleChildScrollView(
            child:Padding(
                padding: EdgeInsets.all(30),
                child:Column(
                  children: [
                    const SizedBox(height:35),
                    Text("Confirm OTP",style: TextStyle(color: Colours.navBarText,fontSize: 18,fontWeight: FontWeight.bold)),
                    const SizedBox(height:30),
                    OTPForm(),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                )))
    );
  }

}

class OTPForm extends StatefulWidget {
  const OTPForm({Key key}) : super(key: key);

  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formWasEdited = false;
  Validators validate;
  bool loading = false;
  int otp;


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


  Future<void> _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      setState(() {
        loading = true;
      });
      final test = false;
      if(test) {
        Navigator.pop(context);
        _autoValidate = AutovalidateMode.disabled;
        _reset(form);
        Navigator.pushNamed(context, UIData.homeRoute);
      }
      else{
        Navigator.pop(context);
        showInSnackBar('Login Unsuccessful');
      }
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
                hintText: "Enter OTP",
                hintStyle: Style.hintText
            ),
            textInputAction: TextInputAction.done,
            obscureText: true,
            keyboardType: TextInputType.number,
            onSaved: (String number) => this.otp = number as int,
           // validator: (String number) => validate.validateN(number),
          ),
          const SizedBox(height: 40.0),
          SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(onPressed: () => _handleSubmitted(),
                child: loading ? CupertinoActivityIndicator() : Text("Confirm", style: TextStyle(
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

        ], mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }


}