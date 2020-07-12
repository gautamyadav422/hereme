import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hereme/provider.dart';
import 'package:hereme/services/auth_service.dart';

final primaryColor = const Color(0xff393e47);
final secondaryColor = const Color(0xff64c3c4);

enum AuthFormType { signIn, signUp }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;
  SignUpView({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});
  final formKey = GlobalKey<FormState>();
  String _email, _password, _name,_error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }
  bool validate(){
    final form = formKey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void submit() async {
    if(validate()) {
      try {
        final auth = Provider
            .of(context)
            .auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed In with ID$uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          String uid =
          await auth.creatUserWithEmailAndPassword(_email, _password, _name);
          print("Signed Up with New ID$uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * 0.10,
              ),
              Container(
                height: 100,
                child: Image(
                  image: AssetImage("images/here.webp"),
                  width: 200,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              Column(

                children: <Widget>[
                  SizedBox(
                    height: _height * 0.025,
                  ),
                  showAlert(),
                  buildHeaderAutoSizeText(),
                ],
              ),
              SizedBox(
                height: _height * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget showAlert(){
    if(_error != null){
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: AutoSizeText(_error, maxLines: 3,),),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  setState(() {
                    _error =null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }return SizedBox(height: 0,);
  }
  AutoSizeText buildHeaderAutoSizeText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Create New Account";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 35, color: Colors.white),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];
    if (authFormType == AuthFormType.signUp) {
      textFields.add(TextFormField(
        validator: NameValidation.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildISignUpnputDecoration("Name"),
        onSaved: (value) => _name = value,
      ));
    }
    textFields.add(
      SizedBox(
        height: 20,
      ),
    );
    textFields.add(
      TextFormField(
        validator: EmailValidation.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildISignUpnputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(
      SizedBox(
        height: 20,
      ),
    );
    textFields.add(
      TextFormField(
        validator: PasswordValidation.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildISignUpnputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(
      SizedBox(
        height: 20,
      ),
    );
    return textFields;
  }

  InputDecoration buildISignUpnputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButton, _newFormState, _submitButton;

    if (authFormType == AuthFormType.signIn) {
      _switchButton = "Create New Account";
      _newFormState = "signUp";
      _submitButton = "Sign In";
    } else {
      _switchButton = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButton = "Sign Up";
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          textColor: Colors.white,
          color: secondaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButton,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          onPressed: submit,
        ),
      ),
      FlatButton(
        child: Text(
          _switchButton,
          style: TextStyle(color: secondaryColor),
        ),
        onPressed: () {
          switchFormState((_newFormState));
        },
      )
    ];
  }
}
