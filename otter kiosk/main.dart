import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kiosk/helper/Languages/languages.dart';
import 'package:path_provider/path_provider.dart';
import 'Model Class/local_storage_model.dart';
import 'libraries.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) {
      return ErrorWidget(details.exception);
    }
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      color: ThemeColors.primaryColor,
      alignment: Alignment.center,
      child: Text(
        'Error!\n${details.exception}',
        style: const TextStyle(color: ThemeColors.white),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      ),
    );
  };
  await GetStorage.init();

  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  GlobalVariables.camera = await availableCameras();
  // Get the application documents directory (where Hive will store data)
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(HiveModelAdapter());
  Hive.registerAdapter(AccidentInsuranceAdapter());
  Hive.registerAdapter(SingleLinequestionAdapter());
  Hive.registerAdapter(MultipleLinequestionAdapter());
  Hive.registerAdapter(SinglechoicequestionAdapter());
  Hive.registerAdapter(MultiplecheckboxAdapter());
  Hive.registerAdapter(ProtectiveAdapter());
  Hive.registerAdapter(WetsuitAdapter());
  //open the box
  await Hive.openBox<HiveModel>('Mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Otter Kiosk',

          translations: Languages(),
          locale: Locale('en', 'US'),
          fallbackLocale: Locale('en', 'US'),

          theme: ThemeData(
            primarySwatch: Palette.palette1,
            scaffoldBackgroundColor: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Roboto',
                  bodyColor: ThemeColors.primaryColor,
                  displayColor: ThemeColors.primaryColor,
                ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: ThemeColors.primaryColor,
              ),
              titleTextStyle: TextStyle(
                color: ThemeColors.grey1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          home: SplashView(),

          // home: HomeUnlockView(),
        );
      },
    );
  }
}
