import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';
import 'package:pingo_assignment_app/src/common/widgets/button.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';

@RoutePage()
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: ThemeHelper.whiteTextFieldDecoration
                        .copyWith(hintText: "Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: ThemeHelper.whiteTextFieldDecoration
                        .copyWith(hintText: "Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: ThemeHelper.whiteTextFieldDecoration
                        .copyWith(hintText: "Password"),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const CustomPrimaryButton(text: "Sign Up"),
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
    );
  }
}
