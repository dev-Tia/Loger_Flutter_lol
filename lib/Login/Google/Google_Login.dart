import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:gaap/Providers/SummerProvider.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class GoogleLogin extends StatefulWidget {
  GoogleLogin({Key key}) : super(key: key);

  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {

  bool _success;

  void initState() {
    super.initState();
    _success = false;
  }

  @override
  Widget build(BuildContext context) {
    print("into GoogleLogin");
    print(_success);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Google Login'),
        backgroundColor: Color.fromARGB(10, 200, 200, 200),
      ),
      body: new Container(
        padding: EdgeInsets.all(20),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              googleSignin(),
              logoutButton(),
            ]),
      ),
    );
  }

  Widget googleSignin() {
    return RaisedButton(
      onPressed: signInWithGoogleOAUTH,
      child: Text(
        'Google Login',
        style: new TextStyle(fontSize: 20),
      ),
    );
  }

  Widget logoutButton() {
    return RaisedButton(
      onPressed: googleLogOut,
      child: new Text(
        'Logout',
        style: new TextStyle(fontSize: 20),
      ),
    );
  }

  void googleLogOut() {
    print("로그아웃");
    _googleSignIn.signOut();
    _auth.signOut();
    final prividerSummonerName = Provider.of<SummerProvider>(context, listen: false);
    prividerSummonerName.inputSummerName(null);
    Navigator.pop(context,'logout');
  }

  void signInWithGoogleOAUTH() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser firebaseUser =
        (await _auth.signInWithCredential(credential)).user;

    assert(firebaseUser.email != null);
    assert(firebaseUser.displayName != null);
    assert(!firebaseUser.isAnonymous);
    assert(await firebaseUser.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);

    print("In Sign signed in " + firebaseUser.displayName);

    setState(() {
      if (firebaseUser != null) {
        _success = true;
        Navigator.pop(context,'login true');
      } else {
        _success = false;
        Navigator.pop(context,'login false');
      }
    });
  }

}
