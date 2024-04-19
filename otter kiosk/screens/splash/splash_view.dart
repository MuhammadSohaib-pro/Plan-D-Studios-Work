import '../../libraries.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  final SplashViewModel viewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.primaryColor,
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SvgPicture.asset(
              'assets/svg/logo.svg',
              height: 150,
              width: 150,
            ),
          )),
    );
  }
}
