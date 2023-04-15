import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scouting_platform/routes/qrcode/currentQRCode.dart';
import 'package:scouting_platform/textStyles/header.dart';
import 'package:scouting_platform/utils/data/commentsData.dart';
import 'package:scouting_platform/utils/data/schedulingData.dart';
import 'package:scouting_platform/utils/data/teamAndMatchData.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../ui/style/style.dart';
import '../../builders/textInputField.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({
    Key? key,
  }) : super(key: key);

  @override
  _CommentsSectionState createState() => _CommentsSectionState();

  static bool qrIsVisible = false;
}

class _CommentsSectionState extends State<CommentsSection> {
  Future<Image>? image;

  @override
  void initState() {
    super.initState();
    // If the driver station starts with "Red" make alliance colour red, if it starts with "Blue" make alliance colour blue
    if (SchedulingData.currentScoutingDriverStation.startsWith("Red")) {
      TeamAndMatchData.teamAlliance = "Red";
    } else if (SchedulingData.currentScoutingDriverStation.startsWith("Blue")) {
      TeamAndMatchData.teamAlliance = "Blue";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(children: [
              TextInputField(
                controller: CommentsData.autoCommentsController,
                margin: const EdgeInsets.only(left: 20.0),
                width: 600.0,
                height: 100.0,
                onChanged: (value) {},
                textAlign: TextAlign.justify,
                hintText: "Auto (Starting position? Routine? etc)",
                maxLines: 3,
              ),
            ]),
            Row(children: [
              TextInputField(
                controller: CommentsData.preferenceCommentsController,
                margin: const EdgeInsets.only(left: 20.0),
                width: 600.0,
                height: 100.0,
                onChanged: (value) {},
                textAlign: TextAlign.justify,
                hintText: "Preference (Cubes/Cones, Pickup Location, etc)",
                maxLines: 3,
              ),
            ]),
            Row(children: [
              TextInputField(
                controller: CommentsData.otherCommentsController,
                margin: const EdgeInsets.only(left: 20.0),
                width: 600.0,
                height: 125.0,
                onChanged: (value) {},
                textAlign: TextAlign.justify,
                hintText: "Other (Anything else important)",
                maxLines: 5,
              ),
            ]),
            Row(children: [
              Container(
                  padding: const EdgeInsets.only(right: 2),
                  height: 47.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyle
                          .textInputColorLight, // Set the background color here
                    ),
                    onPressed: () async {
                      // setState(() {
                      //   CommentsSection.qrIsVisible = true;
                      // });
                      if (TeamAndMatchData.matchNumberController.text == "" ||
                          TeamAndMatchData.teamNumberController.text == "") {
                        showErrorDialog(context);
                        return;
                      } else {
                        showConformationDialog(context);
                      }
                    },
                    child: const Text(
                      'Go To QR Code',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              HeaderStyle(
                text:
                    "   Team Number: ${TeamAndMatchData.teamNumberController.text}  |  Match Number: ${TeamAndMatchData.matchNumberController.text}",
                padding: const EdgeInsets.only(left: 0.0),
              )
            ])
          ],
        ),
      ],
    );
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      throw 'Failed to set brightness';
    }
  }

  showErrorDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error: Not enough fields filled out"),
      content: const Text(
        "Error 1114! Not enough fields have been filled out to generate a QR code.\n\nPlease fill out all team and match information fields before generating a QR code.",
      ),
      actions: [
        okButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showFailedDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error: Incorrect field input"),
      content: const Text(
        "Error! The team number you types did not match the team number of the team\nyou are scouting. Please re-type the team number!",
      ),
      actions: [
        okButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showConformationDialog(BuildContext context) {
    TextEditingController fieldController = TextEditingController(text: "");
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("Submit"),
      onPressed: () {
        if (fieldController.text !=
            TeamAndMatchData.teamNumberController.text) {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          showFailedDialog(context);
        } else {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CurrentQRCode(title: "Current QR Code");
          }));
          setBrightness(1.0);
        }
      },
    );
    Widget teamNumberField = TextField(
      controller: fieldController,
      decoration: const InputDecoration(
        hintText: "Type the team number here...",
        hintStyle: TextStyle(fontFamily: 'Helvetica', color: Colors.black),
        filled: true,
      ),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirmation: Please type TEAM NUMBER"),
      content: Text(
        "Please type the TEAM NUMBER of the team you are scouting in the \nbox below to confirm the generation of the QR code.\n\nMatch Number: ${TeamAndMatchData.matchNumberController.text}\nTeam Number: ${TeamAndMatchData.teamNumberController.text}",
      ),
      actions: [
        teamNumberField,
        okButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
