import 'package:devsociety/Services/ThemeServcie.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => ThemeClass());
}
