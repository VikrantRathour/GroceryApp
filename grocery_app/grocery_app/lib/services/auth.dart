import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUserModel _userFromFirebaseUser(User user) {
    return user != null ? CustomUserModel(uid: user.uid) : null;
  }

  Stream<CustomUserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }

  Future signIn(AuthCredential credential) async {
    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      try {
        dynamic userModel =
            await DatabaseService(uid: user.uid).userModelObject;

        if (userModel.name == '' || userModel.name == null) {
          await DatabaseService(uid: user.uid)
              .updateUserData('Full Name', 'Address', 'Location');
        }
      } catch (ex) {
        print('error: ${ex.toString()}');
        await DatabaseService(uid: user.uid)
            .updateUserData('Full Name', 'Address', 'Location');
      }

      return _userFromFirebaseUser(user);
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }

  Future signInWithOtp(otp, verificationId) {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      dynamic result = signIn(authCredential);
      return result;
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
