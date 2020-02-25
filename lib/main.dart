import 'package:edukasi_pot/core/services/services.dart';
import 'package:edukasi_pot/core/viewmodels/auth_model.dart';
import 'package:edukasi_pot/lifecycle_manager.dart';
import 'package:edukasi_pot/locator.dart';
import 'package:edukasi_pot/provider_setup.dart';
import 'package:edukasi_pot/ui/router.dart' as router;
import 'package:edukasi_pot/ui/shared/theme.dart';
import 'package:edukasi_pot/ui/views/views.dart';
import 'package:edukasi_pot/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);

  await setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: LifecycleManager(
        child: BaseView<AuthModel>(
          builder: (context, model, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Edukasi POT',
            home: model.isAuth
                ? FutureBuilder(
                    future: model.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : model.subjectInSession != null
                              ? SubjectDetailView(
                                  subject: model.subjectInSession)
                              : SubjectListView();
                    },
                  )
                : LoginView(),
            onGenerateRoute: router.generateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
            theme: themeData,
          ),
        ),
      ),
    );
  }
}
