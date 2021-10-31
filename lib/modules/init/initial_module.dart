import 'package:fluttercommerce/di/di.dart';
import 'package:fluttercommerce/modules/app/repo/auth_repository.dart';
import 'package:fluttercommerce/modules/app/repo/firestore_repository.dart';
import 'package:fluttercommerce/modules/module.dart';

import 'bloc/check_status_bloc.dart';
import 'bloc/splash_bloc.dart';

class InitialModule extends Module {
  @override
  void registerDependencies() {
    final authRepo = DI.container<AuthRepository>();
    final firebaseRepo = DI.container<FirestoreRepository>();
    DI.container
      ..registerFactory(() => SplashBloc())
      ..registerFactory(() => CheckStatusBloc(authRepo,firebaseRepo));
  }
}