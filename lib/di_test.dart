import 'package:flutter/widgets.dart';
import 'package:rental_hub/core/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  print("DI setup successfully without runtime errors.");
}
