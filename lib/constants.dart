import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const kScaffoldAccent = 0xff26c6da;
const kHomeNewGameButtonAccent = 0xff64dd17;
const kHomeHowToPlayButtonAccent = 0xffff7043;
const kHomeOptionsButtonAccent = 0xff607d8b;

const k1PointAccent = 0xFF8F8F8F; //0xFF7CBD63;
const k2PointAccent = 0xFF167ADD; //0xFF00B6EF;
const k3PointAccent = 0xFF6F1E96; //0xFF8768AE;
const k4PointAccent = 0xFFFEBA22; //0xFFE75731;

const kSmallTextStyleWhite = TextStyle(
  color: Colors.white,
  fontFamily: 'Muli',
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
);

const kSetupTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'VarelaRound',
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
);

const kTeamScoreDisplayTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'VarelaRound',
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
  height: 0.5,
);

const kAlertStyle = AlertStyle(
  overlayColor: null,
  constraints: BoxConstraints.expand(),
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
  animationDuration: Duration(milliseconds: 300),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.black,
    fontFamily: 'VarelaRound',
    fontWeight: FontWeight.w700,
    fontSize: 40.0,
  ),
);

const kTimesUpAlertStyle = AlertStyle(
  overlayColor: null,
  constraints: BoxConstraints.expand(),
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
  animationDuration: Duration(milliseconds: 300),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.black,
    fontFamily: 'VarelaRound',
    fontWeight: FontWeight.w700,
    fontSize: 40.0,
  ),
);

const kBigNumberStyleWhite = TextStyle(
  color: Colors.white,
  fontSize: 80.0,
  fontFamily: 'VarelaRound',
  fontWeight: FontWeight.w700,
  height: 0.3,
);

const kTransitionHeaderTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 70.0,
  fontFamily: 'VarelaRound',
  fontWeight: FontWeight.w700,
);

const kTransitionGameOverTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 50.0,
  fontFamily: 'VarelaRound',
  fontWeight: FontWeight.w700,
);
