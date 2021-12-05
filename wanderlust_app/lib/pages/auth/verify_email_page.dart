import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/custom_theme.dart';
import 'package:wanderlust_app/services/auth_service.dart';

// ref lab 7, exercise 6

class VerifyEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FormWidget());
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final AuthService fbAuthService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
                color: CustomTheme.lightTheme.backgroundColor,
                padding: const EdgeInsets.only(
                    top: 15, left: 30, right: 30.0, bottom: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30, top: 40),
                          child: Text(
                            "Verify Your Email",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff262c24),
                                    padding: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user != null && !user.emailVerified) {
                                    await user.sendEmailVerification();
                                  }
                                },
                                child: const Text("Send Email")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: CustomTheme
                                        .lightTheme.colorScheme.primary,
                                    padding: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user != null && user.emailVerified) {
                                    Navigator.pushNamed(
                                        context, '/account_verified');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Email is not verified')));
                                  }
                                },
                                child: const Text("Continue")),
                          ),
                        ),
                      ]),
                )),
          )
        ],
      ),
    );
  }
}
