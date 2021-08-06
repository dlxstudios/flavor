import 'dart:io';

import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_auth/src/email.dart';
import 'package:flavor_auth/src/google.dart';
import 'package:logger/logger.dart';

var log = Logger();

var defaultApiKey = 'AIzaSyBON2ZTo1Ulnctdx3wIuUbA2u8nLWwQPj4';
var auth = FlavorAuthEmail(googleApiKey: defaultApiKey);

Future<void> main(List<String> args) async {
  if (args == null || args.isEmpty) {
    print('nothing here');
    exit(63);
  }

  switch (args[0]) {
    case 'signup':
      commandSignup(args);
      break;

    case 'signin':
      commandSignin(args);
      break;

    case 'google':
      await commandGoogle(args);
      break;
    default:
  }
}

void commandSignup(List<String> args) {
  var email;
  var pass;
  var passv;

  email = args[2];
  pass = args[4];
  passv = args[6];

  print('$email, $pass, $passv');

  auth.signUp(email, pass, passv);
}

void commandSignin(List<String> args) {
  var email;
  var pass;

  email = args[2];
  pass = args[4];

  print('$email, $pass');

  auth.signInWithPassword(email, pass);
}

// Command Google

String defaultClientId =
    '546747910139-k7ed76efm8e9lrhd7iuu6bfdmveg6m5c.apps.googleusercontent.com';

String defaultClientSecret = 'FhaABYFADcFi3fl5in3mMfUs';

String defaultRedirectUri =
    'https://flavor-dlx.firebaseapp.com/__/auth/handler';
String localRedirectUriFlavor = 'http://localhost:8714';
String localRedirectUri = '[http://localhost]';

Map<String, Map<String, dynamic>> defaultAppJson = {
  'web': {
    'client_id':
        '546747910139-k7ed76efm8e9lrhd7iuu6bfdmveg6m5c.apps.googleusercontent.com',
    'project_id': 'flavor-dlx',
    'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
    'token_uri': 'https://oauth2.googleapis.com/token',
    'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
    'client_secret': 'FhaABYFADcFi3fl5in3mMfUs',
    'redirect_uris': ['http://localhost:8714'],
    'javascript_origins': [
      'http://localhost',
      'http://localhost:5000',
      'https://flavor-dlx.firebaseapp.com'
    ]
  }
};

Future<void> commandGoogle(List<String> args) async {
  var ga = GoogleOAuthApp(
    clientId: defaultAppJson['web']!['client_id'],
    clientSecret: defaultAppJson['web']!['client_secret'].toString(),
    scopes: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email',
      // 'https://www.googleapis.com/auth/youtube'
    ],
    redirectUri: defaultAppJson['web']!['redirect_uris'][0].toString(),
  );
  var googleAuthResponse = await startOAuthServerGoogle(ga);

  // auth user with firebase server
  var user = await FlavorAuthEmail.signInWithIdp(
    providerId: 'google.com',
    googleApiKey: defaultApiKey,
    googleIdToken: googleAuthResponse.accessToken!,
    identityToken: googleAuthResponse.idToken!,
  );

  print('User with email "${user.email}" was logged in...');
  print('idToken " ${user.idToken} " ');
}
