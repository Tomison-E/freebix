import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:freebix/core/services/authentication.dart';
import 'package:freebix/utils/colors.dart';
import 'package:freebix/utils/theme.dart';
import 'package:freebix/core/repositories/user.dart';
import 'package:freebix/utils/uiData.dart';


final $user = FutureProvider.autoDispose.family;
final userPages =
$user<QuerySnapshot, String>(
      (ref, email) async {
    final repository = ref.read(userRepositoryProvider);
    final user = await repository.getUser(email);
    // Once a page was downloaded, preserve its state to avoid re-downloading it again.
    //ref.maintainState = true;
    return user;
  },
);


final user =
Provider.autoDispose<AsyncValue<User>>((ref) {
  final email = ref.read(fireBaseAuthProvider).currentUser.email;
  return ref.watch(userPages(email)).whenData((value){
    User userData;
    value.docs.forEach((doc) {
      userData = User.fromJson(doc.data());
    });
    return userData;
  }
  );
});

final docID = Provider.autoDispose<AsyncValue<String>>((ref) {
  final email = ref.read(fireBaseAuthProvider).currentUser.email;
  return ref.watch(userPages(email)).whenData((value){
    String id;
    value.docs.forEach((doc) {
      id = doc.id;
    });
    return id;
  }
  );
}
);


class Profile extends ConsumerWidget{

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(user).when(
        loading: () =>
            Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
        error: (err, stack) {
          return Center(
              child: Text('Error Loading Data'),
            );
        },
        data: (user) {
            return Container(
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _userBar(user.firstName,user.lastName,user.username,user.email),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(border: Border.all(
                              color: Colours.regText),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text("KYC LV ${user.level}", style: Style.regText),
                          alignment: Alignment.center,
                        ),
                        FlatButton(
                            onPressed: () {},
                            child: Text("Upgrade to level ${user.stage}", style: TextStyle(
                                color: Color.fromRGBO(108, 210, 207, 1.0),
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic)))
                      ], mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    const SizedBox(height: 50),
         Row(
           children: [
             Text("Verification", style: TextStyle(
                 color: Colours.navBarText,
                 fontSize: 18,
                 fontWeight: FontWeight.bold)),
             RaisedButton(onPressed: () {
                verification(context, getRoute(user.stage));
             },
               child: Text(user.level>0 ? "Continue Verification":"Begin Verification", style: TextStyle(
                   fontWeight: FontWeight.w500, fontSize: 16.0)),
               color: Color.fromRGBO(108, 210, 207, 1.0),
               highlightColor: Colors.white,
               hoverColor: Colors.black,
               textColor: Colors.white,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(5)),
               padding: EdgeInsets.only(left: 10.0, right: 10.0),)
           ], mainAxisAlignment: MainAxisAlignment.spaceBetween,
         ),

                    const SizedBox(height: 20),
                    Text("Complete steps below to get verified",
                        style: Style.regText),
                    const SizedBox(height: 30),
                    _verificationBar(
                        Icons.account_balance_rounded, 1, "BVN Verification",user.stage),
                    const SizedBox(height: 20),
                    _verificationBar(
                        Icons.contact_mail, 2, "Passport Verification",user.stage),
                    const SizedBox(height: 20),
                    _verificationBar(Icons.link, 3, "Link Bank account",user.stage),

                  ], crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            );
        }
    );
  }

  Widget _userBar (String fName, String lName, String username, String email) => SizedBox(
    child:Row(
    children: [
      Icon(Icons.account_circle_rounded, color: Colours.outlineBorder,size: 100),
      const SizedBox(width:10),
      Column(
        children: [
          Text("$fName $lName", style:Style.regText,textAlign: TextAlign.left),
          const SizedBox(height:10),
          Text(username, style:Style.regText),
          const SizedBox(height:10),
          Text(email, style:Style.regText),
        ],crossAxisAlignment: CrossAxisAlignment.start,
      ),

      ],crossAxisAlignment: CrossAxisAlignment.start,
    ),
    height: 100,
  );

  Widget _verificationBar(IconData icon, int level, String label, int activeLevel){
    return Container(
      decoration: BoxDecoration(color:  activeLevel > level ?Colors.grey[50]:Colors.grey[100],borderRadius: BorderRadius.circular(5)),
      height: 200,
      child: Stack(
      children:[
       Column(
        children: [
          Expanded(
            child: Center(child:Icon(icon,color: activeLevel > level ?Colors.grey[500]:Colours.regText,size:100))
          ),
          Text("Level $level", style:Style.regText),
          const SizedBox(height:5),
          Text("$label", style:Style.regText),
          const SizedBox(height:10),
        ],
      ),
        activeLevel > level ? Align(child:Padding(child:Icon(Icons.verified,color: Color.fromRGBO(108, 210, 207, 1.0),size:20),padding: EdgeInsets.all(20)),alignment: Alignment.topRight):Text(" ")
      ]),
    );
  }


String getRoute(int val){
    switch(val){
      case 1 : return UIData.bvnRoute;
      case 2 : return UIData.passportRoute;
      case 3 : return UIData.otpRoute;
    };
    return UIData.unknown;
}


  
  void verification(BuildContext context,String route) async{
    Navigator.pushNamed(context, route);
 } 

}