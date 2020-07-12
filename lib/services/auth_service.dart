import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<String> get onAuthStateChange => _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) =>
  user?.uid,);

  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }
  //Email & Password Sign up

  Future<String>creatUserWithEmailAndPassword(String email, String password, String name)async{
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
    //update the user name
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
   await currentUser.user.updateProfile(userUpdateInfo);
   await currentUser.user.reload();
   return currentUser.user.uid;
  }
  //email and password Sign In
  Future<String> signInWithEmailAndPassword(String email, String password)async{
    return(await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
  }

  signOut(){
    return _firebaseAuth.signOut();
  }
}

class NameValidation{
  static String validate(String value){
    if(value.isEmpty){
      return "Name Can't Be Empty";
    }
    if(value.length<2){
      return "Name must be atleast 2 character long";
    }
    if(value.length>20){
      return "Name must be less than 20 character long";
    }
    return null;
  }
}
class EmailValidation{
  static String validate(String value){
    if(value.isEmpty){
      return "Email Can't Be Empty";
    }
    return null;
  }
}
class PasswordValidation{
  static String validate(String value){
    if(value.isEmpty){
      return "Password Can't Be Empty";
    }
    return null;
  }
}