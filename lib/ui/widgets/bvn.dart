import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freebix/core/repositories/user.dart';
import 'package:freebix/core/services/api_result.dart';
import 'package:freebix/ui/screens/profile.dart';
import 'package:freebix/utils/colors.dart';
import 'package:freebix/utils/theme.dart';
import 'package:freebix/utils/uiData.dart';
import 'package:freebix/utils/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BVN extends StatelessWidget{
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
                  Text("BVN VERIFICATION",style: TextStyle(color: Colours.navBarText,fontSize: 18,fontWeight: FontWeight.bold)),
                  const SizedBox(height:30),
                  BVNForm(),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              )))
    );
  }

}

class BVNForm extends StatefulWidget {
  const BVNForm({Key key}) : super(key: key);

  @override
  _BVNFormState createState() => _BVNFormState();
}

class _BVNFormState extends State<BVNForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formWasEdited = false;
  Validators validate;
  bool loading = false;
  int bvn;
  DateTime dob;


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


  bool verify(){
    return dob.year == 1980 && dob.month ==12 && dob.day == 12 ? true : false;
  }

  Future<void> _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    try {
      if (!form.validate()) {
        _autoValidate =
            AutovalidateMode.always; // Start validating on every change.
        showInSnackBar('Please fix the errors in red before submitting.');
      } else {
        form.save();
        setState(() {
          loading = true;
        });
        final test = verify();
        if (test) {
          Navigator.pop(context);
          _autoValidate = AutovalidateMode.disabled;
          _reset(form);
          final update = await upgrade();
          update.maybeWhen(
              success: (bool data) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, UIData.homeRoute, ModalRoute.withName('/')),
              orElse: () => showInSnackBar('BVN Verification failed'));
        }
        else {
          Navigator.pop(context);
          showInSnackBar('BVN Verification Unsuccessful');
        }
      }
    }
    catch(e){
      print(e);
      showInSnackBar('BVN Verification Unsuccessful');
    }
  }

  Future<ApiResult<bool>> upgrade(){
    String doc = context.read(docID).data.value;
    return context.read(userRepositoryProvider).updateLevel(doc, {
    'level' : 1,
    'stage' : 2
    });
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
                hintText: "BVN Number",
                hintStyle: Style.hintText
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            onSaved: (String number) => this.bvn = int.parse(number),
            validator: (String number) => validate.validateBVN(number),
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
              focusColor: Color.fromRGBO(76, 232, 149, 1.0),
              enabledBorder: Style.outlineInputBorder,
              focusedBorder: Style.outlineInputBorder,
              hintText: "Date of Birth",
              hintStyle: Style.hintText,
                helperText: "yyyy-mm-dd",
                helperStyle: Style.helperText
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.datetime,
            onSaved: (String dob) => this.dob = DateTime.parse('$dob 00:00:00.000'),
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