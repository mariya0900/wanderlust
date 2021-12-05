import 'package:flutter/material.dart';
import 'package:wanderlust_app/custom_theme.dart';
import 'package:wanderlust_app/services/auth_service.dart';
import 'package:wanderlust_app/widgets/curve_painter.dart';

// ref lab 7, exercise 6

class CreateAccountPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height - 100),
                painter: CurvePainter(),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      top: 30, left: 30, right: 30.0, bottom: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30, top: 0),
                            child: Text(
                              "Sign Up",
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
                                  contentPadding: const EdgeInsets.all(20),
                                  prefixIcon:
                                      const Icon(Icons.lock_outline_rounded),
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(200),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  )),
                              validator: (value) {
                                Pattern upper = r'^.*[A-Z]+.*$';
                                Pattern lower = r'^.*[a-z]+.*$';
                                Pattern digit = r'^.*[0-9]+.*$';
                                Pattern special = r'^.*[!@#\$&*~]+.*$';
                                Pattern length = r'^.{8,}';

                                if (!RegExp(length.toString())
                                    .hasMatch(value.toString())) {
                                  return 'Password must be atleast 8 characters in length';
                                }
                                if (!RegExp(upper.toString())
                                    .hasMatch(value.toString())) {
                                  return 'Password should contain atleast one upper case';
                                }
                                if (!RegExp(lower.toString())
                                    .hasMatch(value.toString())) {
                                  return 'Password should contain atleast one lower case';
                                }
                                if (!RegExp(digit.toString())
                                    .hasMatch(value.toString())) {
                                  return 'Password should contain atleast one digit';
                                }
                                if (!RegExp(special.toString())
                                    .hasMatch(value.toString())) {
                                  return 'Password should contain atleast one special character';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {},
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
                                  onPressed: () {
                                    // can validate and save be rewritten?
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      fbAuthService
                                          .signUpWithEmail(
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) => {
                                                if (value != 'Account Created')
                                                  {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(value
                                                                .toString())))
                                                  }
                                                else
                                                  {
                                                    Navigator.pushNamed(context,
                                                        '/login_successful')
                                                  }
                                              });
                                      //might need to give login successful the email in order to load the correct information

                                    }
                                  },
                                  child: const Text("Create Account")),
                            ),
                          ),
                        ]),
                  )),
            ]),
          )
        ],
      ),
    );
  }
}
