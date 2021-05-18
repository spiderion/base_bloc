import 'package:flutter/cupertino.dart';

/// use this state when you need to have access to the [BuildContext]
abstract class BaseBlocPrimaryState {
  void call(BuildContext context);
}
