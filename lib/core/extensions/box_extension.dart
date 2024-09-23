import 'package:task/core/config/config.dart';
import 'package:task/core/constants/box_value.dart';

extension BoxExtension on BuildContext {
  BoxValues get box => BoxValues(this);
}
