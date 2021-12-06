import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/custom_theme.dart';
import 'package:wanderlust_app/services/auth_service.dart';
import 'package:wanderlust_app/services/database_service.dart';

// ref lab 7, exercise 6

class MyLoginPage extends StatelessWidget {
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
  final TextEditingController passwordController = TextEditingController();

  final AuthService fbAuthService = AuthService();
  final DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // app logo
                      const Image(
                        image: AssetImage('assets/temp_logo.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30, top: 40),
                        child: Text(
                          "Start Exploring!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w300),
                        ),
                      ),

                      TextFormField(
                          controller: emailController,
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                              hintText: 'Email',
                              contentPadding: EdgeInsets.all(20),
                              prefixIcon: Icon(Icons.email_outlined),
                              filled: true,
                              fillColor: Colors.white.withAlpha(200),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              )),
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern.toString());
                            if (!regex.hasMatch(value.toString())) {
                              return 'Enter a valid email';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {}),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          // write the validator and onSaved
                          controller: passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: EdgeInsets.all(20),
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              filled: true,
                              fillColor: Colors.white.withAlpha(200),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              )),
                          validator: (value) {},
                          onSaved: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextButton(
                          child: const Text("Forgot Password?"),
                          onPressed: () {
                            Navigator.pushNamed(context, '/reset_password');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: CustomTheme
                                      .lightTheme.colorScheme.secondary,
                                  padding: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35))),
                              onPressed: () {
                                // can validate and save be rewritten?
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  fbAuthService
                                      .signInEmailPassword(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) => {
                                            if (value != 'Signed In')
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            value.toString())))
                                              }
                                            else
                                              {
                                                if (FirebaseAuth.instance
                                                    .currentUser!.emailVerified)
                                                  {
                                                    Navigator.pushNamed(context,
                                                        '/account_verified')
                                                  }
                                                else
                                                  {
                                                    Navigator.pushNamed(context,
                                                        '/login_successful')
                                                  }
                                              }
                                          });
                                  //might need to give login successful the email in order to load the correct information

                                }
                              },
                              child: const Text("Login")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('- - - - - - - - - - - - -',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: CustomTheme
                                        .lightTheme.colorScheme.primary,
                                  )),
                              const Text('Or',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black)),
                              Text(
                                '- - - - - - - - - - - - -',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: CustomTheme
                                        .lightTheme.colorScheme.primary),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: CustomTheme
                                      .lightTheme.colorScheme.primary,
                                  padding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35))),
                              onPressed: () {
                                Navigator.pushNamed(context, '/create_account');
                              },
                              child: const Text("Create an Account")),
                        ),
                      ),
                    ]),
              )),
        )
      ],
    );
  }
}
