import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here4u/navigator.dart';
import 'package:here4u/services/sharedpreferences.dart';
import 'package:here4u/ui/register/register_screen.dart';
import 'package:here4u/ui/widgets/mywidgets.dart';
import 'package:here4u/ui/widgets/textinputfield.dart';
import 'package:here4u/ui/widgets/textinputfieldwithicon.dart';

class SignIn extends StatefulWidget {
  static const id = 'sign_in';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? email_data, password_data, uid_data; //variables for holding shared pref data
  late String usernameData; // this variable to store data returned from getUserInfo Api
  late String userPhoneData; // this variable to store data returned from getUserInfo Api
  late String userGenderData; // this variable to store data returned from getUserInfo Api
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool validatePhone = false;
  bool validateEmail = false;
  bool _isHidden = false;
  bool emailValid = false;

  SharedPref sharedPref = new SharedPref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance; // add firebase auth
  MyWidgets myWidgets = new MyWidgets();

  String? userID;
  String? userEmail;

  var collection = FirebaseFirestore.instance.collection("users"); // to get the state of users
  //------------------------------Functions-------------------------------------
  //-> Loading User Data if he is already signed in to the program
  void loadUserDataLogin() async {
    email_data = await sharedPref.LoadData("email");
    password_data = await sharedPref.LoadData('password');
    uid_data = await sharedPref.LoadData("uid");

    if (email_data != null || password_data != null || uid_data != null) {
      setState(() {
        _emailController.text = email_data!;
        _passwordcontroller.text = password_data!;
      });
    }
  }

  // get user data from firebase
  void getUserFromFirebase() {
    final User? user = firebaseAuth.currentUser;
    if (user != null) {
      setState(() {
        userID = user.uid;
        userEmail = user.email;
        //  print("name of user is: $userEmail");
      });
    }
  }

//******************************************************************************
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDataLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: columnElements(),
    );
  } // end builder

//---------------------------------Widget Tree----------------------------------
  Widget columnElements() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            imageBackground(),
            sign_in_Container(),
          ],
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
  //-> Widget of background
  Widget imageBackground() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/ui/home/slide_9.jpeg'), fit: BoxFit.contain),
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
  //-> Button for sign in
  Widget Login() {
    return Container(
      padding: EdgeInsets.only(right: 55.0, left: 55.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: Colors.red,
        child: Text(
          "تسجيل الدخول",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(
            color: Colors.red,
          ),
        ),
        onPressed: signInFunction,
      ),
    );
  }

  //----------------------------------------------------------------------------
  //-> Flatted Button for forget password
  Widget forgetPassword() {
    return Container(
      width: MediaQuery.of(context).size.width, // take all space available
      child: FlatButton(
        onPressed: () {
          //     Navigator.pushNamed(context, ForgetPassword.id);
        },
        child: Text("نسيت كلمة المرور؟"),
      ),
    );
  }

  //----------------------------------------------------------------------------
  //-> I am new User Sign up
  Widget Signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text("مستخدم جديد"),
        ),
        Container(
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, RegisterPage.id);
            },
            child: Text(
              'التسجيل',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  //----------------------------------------------------------------------------
  //-> Container for having all elements with sign in and username
  Widget sign_in_Container() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Color(0xFFf2f2f2),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 5.0,
            ),
            Text(
              "تسجيل الدخول",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
            ),
            SizedBox(
              height: 2.0,
            ),
            TextInputField(
              hint_text: "عنوان البريد الإلكتروني",
              //label_text: "username",
              controller_text: _emailController,
              show_password: false,
              error_msg: validateEmail ? "يرجى تعبئة الحقل" : "",
              FunctionToDo: () {},
            ),
            SizedBox(
              height: 3.0,
            ),
            // it must be another textinputfield
            TextInputFieldWithIcon(
              hint_text: "كلمة المرور",
              // label_text: "password",
              controller_text: _passwordcontroller,
              icon_widget: _isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              show_password: _isHidden,
              error_msg: validateEmail ? "يرجى تعبئة الحقل" : "",
              // error_msg:
              //     _passwordcontroller.text.isEmpty ? "يرجى تعبئة الحقل" : "",
              FunctionToDo: () {
                setState(() {
                  _isHidden = !_isHidden;
                });
              },
            ),
            SizedBox(
              height: 1.0,
            ),
            // forgetPassword(),
            SizedBox(
              height: 1.0,
            ),
            Login(),
            SizedBox(
              height: 1.0,
            ),
            Signup(),
          ],
        ),
      ],
    );
  }

//------------------------------------------------------------------------------
//-----------------------------------Functions----------------------------------
  void signInFunction() async {
    setState(() {
      _emailController.text.isEmpty ? validateEmail = true : validateEmail = false;

      _passwordcontroller.text.isEmpty ? validateEmail = true : validateEmail = false;
    });

    if (validateEmail || validateEmail) {
      return;
    }
    // to check that user has entered a valid email address
    emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);
    if (emailValid != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("البريد الإلكتروني غير صالح"),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // show a snackbar message

    myWidgets.showProcessingDialog(" جاري تسجيل الدخول ... ", context);

    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text.toLowerCase().trim(),
          password: _passwordcontroller.text.toLowerCase().trim());
      final user = userCredential.user;
      // print(user?.uid);
      if (user?.uid != null) {
        Navigator.of(context).pop();
        //-> save to shared preferences
        sharedPref.setData("uid", user!.uid.toString());
        sharedPref.setData('email', _emailController.text);
        sharedPref.setData('password', _passwordcontroller.text);
        Navigator.of(context).pushNamed(Navigations.id);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        myWidgets.displaySnackMessage(" لا يوجد مستخدم بهذا الاسم", context);
      } else if (e.code == 'wrong-password') {
        myWidgets.displaySnackMessage("كلمة السر خاطئة", context);
      }

      Navigator.of(context).pop();
    }
  }
//------------------------------------------------------------------------------
} // end class
//done
