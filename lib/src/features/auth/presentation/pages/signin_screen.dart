import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';
import 'package:pingo_assignment_app/src/common/utils/email_validator.dart';
import 'package:pingo_assignment_app/src/common/widgets/button.dart';
import 'package:pingo_assignment_app/src/common/widgets/loading_widget.dart';
import 'package:pingo_assignment_app/src/common/widgets/snackbar.dart';
import 'package:pingo_assignment_app/src/core/providers/auth_provider.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _signinformKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "MyNews",
            style: ThemeHelper.appHeadingTextStyle,
          ),
        ),
        leadingWidth: 150,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _signinformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: ThemeHelper.whiteTextFieldDecoration
                          .copyWith(hintText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return validateEmail(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: ThemeHelper.whiteTextFieldDecoration
                          .copyWith(hintText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Provider.of<AuthProvider>(context, listen: false).status ==
                          Status.Authenticating
                      ? const LoadingWidget()
                      : CustomPrimaryButton(
                          text: "Login",
                          onPressed: () async {
                            if (_signinformKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();

                              bool success = await Provider.of<AuthProvider>(
                                      context,
                                      listen: false)
                                  .signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);

                              if (!success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    errorSnackbar("Signin Failed"));
                              } else {
                                context.router.push(const HomeRoute());
                              }
                            }
                          },
                        ),
                  const SizedBox(height: 8),
                  RichText(
                      text: TextSpan(
                          text: "New here?",
                          style: ThemeHelper.authMediumTextStyle,
                          children: [
                        TextSpan(
                          text: " Signup",
                          style: ThemeHelper.authBoldTextStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.router.push(const SignupRoute());
                            },
                        )
                      ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
