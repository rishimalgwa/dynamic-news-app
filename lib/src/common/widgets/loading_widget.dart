import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/common/helpers/size.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeHelper s = SizeHelper(context);
    return Center(
      child: SizedBox(
        height: s.hHelper(2.5),
        width: s.hHelper(2.5),
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(ThemeHelper.darkPrimaryColor),
        ),
      ),
    );
  }
}
