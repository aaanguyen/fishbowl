import 'package:flutter/material.dart';
import 'package:fishbowl/constants.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class SetupRadioGroup extends StatelessWidget {
  final bool isNumbered;
  final String title;
  final List<String> labels;
  final Function providerCallback;

  SetupRadioGroup(
      {@required this.isNumbered,
      @required this.title,
      @required this.labels,
      @required this.providerCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: kSetupTextStyle,
        ),
        Theme(
          data: Theme.of(context).copyWith(
            toggleableActiveColor: Colors.white,
            unselectedWidgetColor: Colors.white,
          ),
          child: RadioButtonGroup(
            orientation: GroupedButtonsOrientation.HORIZONTAL,
            margin: const EdgeInsets.only(left: 12.0),
            onSelected: (String selected) {
              providerCallback(int.parse(selected));
            },
            labels: labels,
            labelStyle: kSetupTextStyle,
            picked: null,
            itemBuilder: (Radio rb, Text txt, int i) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: <Widget>[
                    rb,
                    txt,
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
