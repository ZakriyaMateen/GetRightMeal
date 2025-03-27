import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';
import '../Constants/Sizes.dart';
import '../Controllers/OnBoardingControllers/Screen2Controller.dart';

class HeightPicker extends StatefulWidget {
  final Screen2Controller controller;
  const HeightPicker({Key? key, required this.controller}) : super(key: key);

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  final TextEditingController ftController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final FocusNode inchFocusNode = FocusNode();
  final FocusNode ftFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v){
      ftFocusNode.requestFocus();
    });
  }
  // void updateCombinedHeight() {
  //   // Get feet and inches strings
  //   String ftStr = ftController.text;
  //   String inchStr = inchController.text;
  //
  //   // Optionally, you can validate or limit the values here
  //   int ft = int.tryParse(ftStr) ?? 0;
  //   int inch = int.tryParse(inchStr) ?? 0;
  //   if (inch > 11) {
  //     inch = 11;
  //     inchController.text = '11';
  //   }
  //
  //   // Instead of converting inches to fraction, combine as a string
  //   String combinedHeightStr = '$ft.$inch';
  //
  //   // If needed as a double (note: 2.11 as double is two and eleven-hundredths, not 2 ft 11 in)
  //   // widget.controller.selectedHeight.value = double.tryParse(combinedHeightStr) ?? ft.toDouble();
  //
  //   // For display or storage, you can save the string value:
  //   // widget.controller.selectedHeightString.value = combinedHeightStr; // assuming you have a reactive variable for this
  //
  //   print("Total Height: $combinedHeightStr");
  // }
  void updateCombinedHeight() {
    // Parse feet and inches; default to 0 if invalid
    int ft = int.tryParse(ftController.text) ?? 0;
    int inch = int.tryParse(inchController.text) ?? 0;


    double inchInString = ((ft*12)+ inch).toDouble();

    // Ensure inch stays in 0-11 range

    // Parse the string to a double
    widget.controller.selectedHeight.value = inchInString;
    // widget.controller.cmInchFeet.value = 'in';
    print("Total Height: ${widget.controller.selectedHeight.value}");
  }


  @override
  void dispose() {
    ftController.dispose();
    inchController.dispose();
    inchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Adjust these widths as needed for your design.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Feet Field
        Container(
          width: 80,
          height: 60,
          alignment: Alignment.center,
          child: TextFormField(
            focusNode: ftFocusNode,
            controller: ftController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              // Limit to 1 digit since max is 7
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              suffixText: "ft",
              suffixStyle: GoogleFonts.roboto(
                fontSize: size14,
                color: red
              ),
              hintText: '0',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: GoogleFonts.roboto(
              fontSize: 50,
              color: red,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (value) {
              int ft = int.tryParse(value) ?? 0;
              if (ft > 7) {
                ftController.text = '7';
              }
              // When feet is entered, move focus to inches
              if (value.isNotEmpty) {
                FocusScope.of(context).requestFocus(inchFocusNode);
              }
              updateCombinedHeight();
            },
          ),
        ),
        SizedBox(width: 10),
        // Inches Field
        Container(
          width: 80,
          height: 60,
          alignment: Alignment.center,
          child: TextFormField(
            controller: inchController,
            focusNode: inchFocusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              // Limit to 2 digits (but will check below to enforce 0-11)
              LengthLimitingTextInputFormatter(2),
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              suffixText: "in",
              suffixStyle: GoogleFonts.roboto(
                  fontSize: size14,
                  color: red
              ),
              hintText: '0',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: GoogleFonts.roboto(
              fontSize: 50,
              color: red,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (value) {
              int inch = int.tryParse(value) ?? 0;
              if (inch > 11) {
                inchController.text = '11';
              }
              updateCombinedHeight();
            },
          ),
        ),
      ],
    );
  }
}
