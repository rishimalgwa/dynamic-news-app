import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';
import 'package:pingo_assignment_app/src/common/utils/email_validator.dart';
import 'package:pingo_assignment_app/src/common/widgets/button.dart';
import 'package:pingo_assignment_app/src/common/widgets/loading_widget.dart';
import 'package:pingo_assignment_app/src/common/widgets/snackbar.dart';
import 'package:pingo_assignment_app/src/core/providers/auth_provider.dart';
import 'package:pingo_assignment_app/src/features/auth/data/user_model.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  final _signupformKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _nameController = TextEditingController(text: "");
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
          key: _signupformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: ThemeHelper.whiteTextFieldDecoration
                          .copyWith(hintText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: ThemeHelper.whiteTextFieldDecoration
                          .copyWith(hintText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Email';
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
                  Provider.of<AuthProvider>(context).status ==
                          Status.Registering
                      ? const LoadingWidget()
                      : CustomPrimaryButton(
                          text: "Sign Up",
                          onPressed: () async {
                            if (_signupformKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();

                              UserModel userModel =
                                  await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .registerWithEmailAndPassword(
                                          _emailController.text,
                                          _passwordController.text,
                                          _nameController.text);

                              if (userModel.uid == "null") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    errorSnackbar("Signup Failed"));
                              } else {
                                context.router.push(const HomeRoute());
                              }
                            }
                          },
                        ),
                  const SizedBox(height: 8),
                  RichText(
                      text: TextSpan(
                          text: "Aready have an account?",
                          style: ThemeHelper.authMediumTextStyle,
                          children: [
                        TextSpan(
                          text: " Login",
                          style: ThemeHelper.authBoldTextStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.router.push(const SigninRoute());
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
