import 'package:intl/intl.dart';

String formatTimeStamp(DateTime convertTheFormat) {
  return DateFormat('h:mm a').format(
    convertTheFormat,
  );
}
