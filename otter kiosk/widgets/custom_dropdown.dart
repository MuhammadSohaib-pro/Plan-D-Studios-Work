import 'package:kiosk/libraries.dart';

import '../helper/get_state.dart';

class CustomStatedropdown extends StatelessWidget {
  RxString val = ''.obs;
  Function(String?)? onchange;
  CustomStatedropdown({super.key, required this.val, required this.onchange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: RichText(
            text: TextSpan(
              text: 'State',
              style: const TextStyle(
                fontSize: 14,
                color: ThemeColors.primaryColor,
              ),
              children: [
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(() => Container(
              decoration: BoxDecoration(
                  color: ThemeColors.white,
                  border: Border(
                      bottom:
                          BorderSide(width: 1.7, color: ThemeColors.grey1))),
              child: PopupMenuButton<String>(
                  initialValue: val.value,
                  onSelected: onchange,
                  itemBuilder: (BuildContext context) {
                    return StateGet.model.value.states!.map((state) {
                      return PopupMenuItem<String>(
                        value: state.stateCode,
                        child: Text(state.name!),
                      );
                    }).toList();
                  },
                  child: Obx(() => Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            val.value == "" ? "State" : val.value,
                          ),
                          Spacer(),
                          Icon(Icons.arrow_drop_down_sharp),
                        ],
                      )))),
            ))
      ],
    );
  }
}
