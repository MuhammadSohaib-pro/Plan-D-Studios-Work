import '../../../libraries.dart';

class CheckIn2View extends StatelessWidget {
  CheckIn2View({super.key});
  final CheckIn2ViewModel viewModel = Get.put(CheckIn2ViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              bulletsImage(),
              SizedBox(height: 20),
              enterNumberTxt(),
              SizedBox(height: 20),
              numberTxtField(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButtons(
                    number: '1',
                    // alphabet: '',
                    onPressed: () {
                      viewModel.numberButton('1');
                    },
                  ),
                  numberButtons(
                    number: '2',
                    // alphabet: 'ABC',
                    onPressed: () {
                      viewModel.numberButton('2');
                    },
                  ),
                  numberButtons(
                    number: '3',
                    // alphabet: 'DEF',
                    onPressed: () {
                      viewModel.numberButton('3');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButtons(
                    number: '4',
                    // alphabet: 'GHI',
                    onPressed: () {
                      viewModel.numberButton('4');
                    },
                  ),
                  numberButtons(
                    number: '5',
                    // alphabet: 'JKL',
                    onPressed: () {
                      viewModel.numberButton('5');
                    },
                  ),
                  numberButtons(
                    number: '6',
                    // alphabet: 'MNO',
                    onPressed: () {
                      viewModel.numberButton('6');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButtons(
                    number: '7',
                    // alphabet: 'PQRS',
                    onPressed: () {
                      viewModel.numberButton('7');
                    },
                  ),
                  numberButtons(
                    number: '8',
                    // alphabet: 'TUV',
                    onPressed: () {
                      viewModel.numberButton('8');
                    },
                  ),
                  numberButtons(
                    number: '9',
                    // alphabet: 'WXYZ',
                    onPressed: () {
                      viewModel.numberButton('9');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  clearAllTxtButton(),
                  numberButtons(
                      number: '0',
                      // alphabet: '+',
                      onPressed: () {
                        viewModel.numberButton('0');
                      },
                      onLongPressed: () {
                        viewModel.numberButton('+');
                      }),
                  backButton(),
                ],
              ),
              checkInBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bulletsImage() {
    return Image.asset(
      "assets/images/bullet.png",
      height: 110,
      width: 110,
    );
  }

  Widget enterNumberTxt() {
    return Text(
      "Enter your phone Number",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        color: ThemeColors.grey1,
      ),
    );
  }

  Widget numberTxtField() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: countryFlagNumberTextField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: viewModel.txtFieldController,
          keyboardType: TextInputType.none,
          initialvalue: viewModel.number,
          onChanged: (value) {
            viewModel.countryCode.value = value.toString();
          },
          showCursor: false,
          validator: (value) {
            return CommonFunctions.validateDefaultTxtField(value);
          },
        ),
      ),
    );
  }

  Widget numberButtons({
    required String number,
    required VoidCallback? onPressed,
    VoidCallback? onLongPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.square(85),
          padding: const EdgeInsets.all(0),
          backgroundColor: const Color(0xffe9e9e9),
          foregroundColor: Colors.grey,
          elevation: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                height: 1,
                fontFamily: 'Roboto',
                fontSize: 35,
                fontWeight: FontWeight.w400,
                color: Color(0xff00293a),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clearAllTxtButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          viewModel.backButtonLongPress();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.square(85),
          padding: const EdgeInsets.all(0),
          backgroundColor: const Color(0xffe9e9e9),
          foregroundColor: Colors.grey,
          elevation: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'X',
              style: const TextStyle(
                height: 1,
                fontFamily: 'Roboto',
                fontSize: 35,
                fontWeight: FontWeight.w400,
                color: Color(0xff00293a),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          viewModel.backButton();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.square(85),
          padding: const EdgeInsets.all(0),
          backgroundColor: const Color(0xffe9e9e9),
          foregroundColor: Colors.grey,
          elevation: 0,
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 14, top: 0),
          child: Icon(
            Icons.arrow_back_ios,
            size: 35,
            color: ThemeColors.black1,
          ),
        ),
      ),
    );
  }

  Widget checkInBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: CustomElevatedBtn(
        foregroundColor: Colors.grey,
        backgroundColor: ThemeColors.primaryColor,
        onPressed: () {},
        child: const Text(
          'Check In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
