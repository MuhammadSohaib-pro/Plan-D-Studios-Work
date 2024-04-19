import '../../../libraries.dart';

class ThankyouforSigning extends StatelessWidget {
  const ThankyouforSigning({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
              body: Center(
                child: Column(
                  children: [
                    SizedBox(height: Get.context!.isLandscape ? 0 : 25.h),
                    Image.network(
                      GlobalVariables.organization.photoUrl!,
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Thank you for signing document.',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 24),
                    CustomElevatedBtn(
                      child: Text('SIGN NEW DOCUMENT'),
                      width: 60,
                      backgroundColor: ThemeColors.fullLightPrimary,
                      onPressed: () {
                        Get.offAll(() => HomeUnlockView());
                      },
                    )
                  ],
                ),
              ),
            ));
  }
}
