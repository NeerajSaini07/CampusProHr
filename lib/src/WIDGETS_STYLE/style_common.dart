import 'package:flutter/material.dart';

Widget internalTextForDateTime(BuildContext context,
    {String? selectedDate, double? width}) {
  return Container(
    width: width ?? MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xffECECEC)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            selectedDate!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Icon(Icons.today, color: Theme.of(context).primaryColor)
      ],
    ),
  );
}

// Widget googleFontStyleLeto(BuildContext context,
//     {String? txt, double? fontSize, Color? color, FontWeight? fontWeight}) {
//   return Text(
//     "$txt",
//     textScaleFactor: 1.0,
//     //leto
//     style: GoogleFonts.openSans(
//         fontStyle: FontStyle.normal,
//         fontSize: fontSize ?? 15,
//         color: color ?? Colors.black,
//         fontWeight: fontWeight ?? FontWeight.w500),
//   );
// }
