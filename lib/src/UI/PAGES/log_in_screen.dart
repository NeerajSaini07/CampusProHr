import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/signInWithGoogleApi.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SIGN_IN_WITH_GOOGLE_CUBIT/sign_in_with_google_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/account_type_screen.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SIGN_IN_CUBIT/log_in_cubit.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = "/signin-page";

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  GoogleSignInAccount? userGoogle;
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _showPassword = true;

  AnimationController? animation;
  Animation<double>? _fadeInFadeOut;

  String? noFromMail;
  String? passFromMail;

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.2, end: 1.0).animate(animation!);
    animation!.addStatusListener((status) {
      if (AnimationStatus.completed == status) {
        animation!.reverse();
      } else if (AnimationStatus.dismissed == status) {
        animation!.forward();
      }
    });
    animation!.forward();
    super.initState();
  }

  googleSignInApiCall({String? email}) async {
    final sendingData = {"Email": email};

    print("sending data for google sign in $sendingData");

    context.read<SignInWithGoogleCubit>().signInWithGoogleCubitCall(sendingData);
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    animation!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider<SignInWithGoogleCubit>(
        create: (_) => SignInWithGoogleCubit(SignInWithGoogleApi()),
        child: MultiBlocListener(
          listeners: [
            BlocListener<SignInWithGoogleCubit, SignInWithGoogleState>(listener: (context, state) {
              if (state is SignInWithGoogleLoadSuccess) {
                noFromMail = state.result[0].number;
                passFromMail = state.result[0].password;
                // UserUtils.saveEmpAndPwdForLogin(noFromMail,passFromMail);
                goToUserType(email: state.result[0].number!, password: state.result[0].password);
              } else if (state is SignInWithGoogleLoadFail) {
                if (state.failReason == "App_Under_Maintenance") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(title: "App Under Maintenance", duration: Duration(seconds: 2)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: "Email Id is not registered in school, Please contact to school.",
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            }),
          ],
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: BlocConsumer<LogInCubit, LogInState>(
                  listener: (context, state) async {
                    if (state is LogInLoadSuccess) {
                      if (state.status) {
                        toast("LoggedIn Successfully!");

                        await UserUtils.cachePhoneNoPass(
                          noPass: "${noFromMail == null ? mobileController.text : noFromMail},"
                              "${passFromMail == null ? passwordController.text : passFromMail}",
                        );

                        Navigator.pushNamedAndRemoveUntil(
                            context, AccountTypeScreen.routeName, (route) => false);
                      }
                    }
                    if (state is LogInLoadFail) {
                      toastFailedNotification(state.failReason);
                    }
                  },
                  builder: (context, state) {
                    final bool showLoader = (state is LogInLoadInProgress) ? true : false;
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                Text(
                                  "Welcome !",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 40,
                                    color: primaryColor,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Text(
                                  'Get the best from our App',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                buildTextField(
                                  controller: mobileController,
                                  validator: FieldValidators.mobileValidator,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  hintText: "Enter Mobile Number",
                                  maxLength: 10,
                                  obscureText: false,
                                  suffixIcon: false,
                                ),
                                SizedBox(height: 20.0),
                                buildTextField(
                                  controller: passwordController,
                                  validator: FieldValidators.passwordValidator,
                                  hintText: "Enter Password",
                                  textInputAction: TextInputAction.go,
                                  obscureText: _showPassword,
                                  suffixIcon: true,
                                ),
                                SizedBox(height: 40.0),
                                if (showLoader)
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 12),
                                        Text(
                                          "Please wait...",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                else
                                  Column(
                                    children: [
                                      buildSignUpBtn(),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                Image.asset(
                                  'assets/images/logo_rugerp.png',
                                  width: 340,
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signInWithGoogle() async {
    userGoogle = await GoogleSignInApi.login();
    print("UserGoogle $userGoogle");
    setState(() {
      userGoogle = userGoogle;
    });
    if (userGoogle == null) {
      ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(title: "Login Failed"));
    } else {
      print("Success");
      print("${userGoogle!.email}");
      googleSignInApiCall(email: userGoogle!.email);
    }
  }

  Widget buildSignUpBtn() {
    return FilledButton(
      onPressed: () => goToUserType(),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(primaryColor),
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0)),
        fixedSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 35)),
        shape: MaterialStatePropertyAll(
          const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
      child: Text(
        "LogIn",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          fontFamily: 'OpenSans',
          color: Colors.white,
        ),
      ),
    );
  }

  goToUserType({String? email, String? password}) {
    if (email == null) {
      if (_formKey.currentState!.validate()) {
        final credentials = {
          "MobileNo": email == null ? mobileController.text : email,
          "Password": password == null ? passwordController.text : password,
        };

        print("Sending credentials data = $credentials");

        context.read<LogInCubit>().logInCubitCall(credentials);
      }
    } else {
      final credentials = {
        "MobileNo": email.toString(),
        "Pass": password.toString(),
      };

      print("Sending credentials data = $credentials");

      context.read<LogInCubit>().logInCubitCall(credentials);
    }
  }

  Container buildTextField({
    bool obscureText = false,
    bool? suffixIcon = false,
    int? maxLength,
    String? hintText,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        onFieldSubmitted: (_) => goToUserType(),
        textInputAction: textInputAction,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        maxLength: maxLength ?? null,
        keyboardType: keyboardType ?? null,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          suffixIcon: suffixIcon!
              ? InkWell(
                  onTap: () {
                    setState(() => _showPassword = !_showPassword);
                  },
                  child: !_showPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                )
              : null,
        ),
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();
}
