import 'package:flutter/material.dart';

closeKeyboard(BuildContext context) {
  FocusScopeNode currentFocusNode = FocusScope.of(context);

  if (!currentFocusNode.hasPrimaryFocus) {
    currentFocusNode.unfocus();
  }
}
