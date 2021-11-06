import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:gaap/Providers/SummerProvider.dart';

import '../first_time/signUp.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class GoogleLogin2 {
  Future<void> googleLogOut(context) async {
    print("로그아웃");
    _googleSignIn.signOut();
    _auth.signOut();
    final prividerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);
    prividerSummonerName.inputUid(null);
    prividerSummonerName.inputSummerName(null);
    // Navigator.pop(context,'logout');
  }

  Future<void> signInWithGoogleOAUTH(context) async {
    print("signInWithGoogleOAUTH");

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

    print("In Sign signed in " +
        firebaseUser.displayName +
        ' / ' +
        currentUser.uid);

    final prividerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);
    prividerSummonerName.inputUid(currentUser.uid);
  }

  Future<void> currentUser(context) async {
    final prividerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);
    print("currentUser 확인하고있어요!!");

    try {
      final FirebaseUser user = await _auth.currentUser();

      if (user != null) {
        print("user : " + user.toString());

        print('setState userUID');
        prividerSummonerName.inputUid(user.uid);
      } else {
        prividerSummonerName.inputUid(null);
      }
      print("userUID : " + prividerSummonerName.uid);
    } catch (e) {
      print('ERROR ERROR ERROR ERROR ERROR');
      print(e);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUp()),
      );
    }
  }
}
