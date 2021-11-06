import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLogin extends StatefulWidget {
  @override
  _AppleLoginState createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Example app: Sign in with Apple'),
        // ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: SignInWithAppleButton(
              onPressed: () async {
                final credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                  webAuthenticationOptions: WebAuthenticationOptions(
                    // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
                    clientId:
                        'gg.gaag.gaag',
                    redirectUri: Uri.parse(
                      'https://loger-gaap.firebaseapp.com/__/auth/handler',
                    ),
                  ),
                  // TODO: Remove these if you have no need for them
                  // nonce: 'example-nonce',
                  // state: 'example-state',
                );

                print('credential :  $credential');
                print('credential.authorizationCode :  ${credential.authorizationCode}');

                // This is the endpoint that will convert an authorization code obtained
                // via Sign in with Apple into a session in your system
                final signInWithAppleEndpoint = Uri(
                  scheme: 'https',
                  host: 'loger-gaap.firebaseapp.com',
                  path: '/__/auth/handler',
                  queryParameters: <String, String>{
                    'code': credential.authorizationCode,
                    'firstName': credential.givenName,
                    'lastName': credential.familyName,
                    'useBundleId':
                        Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
                    if (credential.state != null) 'state': credential.state,
                  },
                );
                final session = await http.Client().post(
                  signInWithAppleEndpoint,
                );

                // If we got this far, a session based on the Apple ID credential has been created in your system,
                // and you can now set this as the app's session
                print('session : ${session.body.toString()}');
              },
            ),
          ),
        ),
      ),
    );
  }
}