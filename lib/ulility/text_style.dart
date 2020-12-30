import 'package:brhhappy/ulility/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle headingTextStyle = GoogleFonts.pridi(
  fontSize: 30.0,
  color: Colors.white54,
  fontWeight: FontWeight.w700,
  letterSpacing: 5,
);
final TextStyle headTextStyle = GoogleFonts.pridi(
  fontSize: 25.0,
  color: Colors.white54,
  fontWeight: FontWeight.w700,
  letterSpacing: 3,
);
final TextStyle popularnumberStyle = GoogleFonts.pridi(
  fontSize: 28.0,
  color: Colors.red,
  fontWeight: FontWeight.w900,
  letterSpacing: 5,
);
final TextStyle headerStyle = GoogleFonts.pridi(
  fontSize: 18.0,
  color: Colors.black38,
  fontWeight: FontWeight.w600,
  letterSpacing: 3,
);
final TextStyle loginStyle = GoogleFonts.pridi(
  fontSize: 18.0,
  color: Colors.black54,
  fontWeight: FontWeight.w600,
  letterSpacing: 3
);
final TextStyle loginTextStyle = GoogleFonts.pridi(
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.w600,
  letterSpacing: 3
);
final TextStyle resetTextStyle = GoogleFonts.pridi(
  fontSize: 18.0,
  color: Colors.white54,
  fontWeight: FontWeight.w600,
  letterSpacing: 3
);
final TextStyle doctorTextStyle = GoogleFonts.pridi(
  fontSize: 24.0,
  color: Colors.black,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.5,
);
final TextStyle titleTextStyle = GoogleFonts.pridi(
  fontSize: 24.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: 5,
);
final TextStyle titledepartmentTextStyle = GoogleFonts.pridi(
  fontSize: 16.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.4,
);
final TextStyle menuStyle = GoogleFonts.pridi(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: 5,
);
final TextStyle listtitleStyle = GoogleFonts.pridi(
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.w700,
  letterSpacing: 2,
);
final TextStyle titleStyle = GoogleFonts.pridi(
  fontSize: 16.0,
 color: Colors.black54,
  fontWeight: FontWeight.w600,
  letterSpacing: 3,
);
final TextStyle titleNameStyle = GoogleFonts.pridi(
  fontSize: 16.0,
 color: Colors.white60,
  fontWeight: FontWeight.w600,
  letterSpacing: 3,
);
final TextStyle menuTextStyle = GoogleFonts.pridi(
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.w600,
  letterSpacing: 2,
);
final TextStyle numberStyle = GoogleFonts.orbitron(
  fontSize: 12.0,
  color: Colors.black45,
  fontWeight: FontWeight.w600,
  letterSpacing: 3,
);
final TextStyle textStyle = GoogleFonts.pridi(
  fontSize: 14.0,
  color: Colors.black45,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.5,
);
final TextStyle departmentStyle = GoogleFonts.pridi(
  fontSize: 12.0,
  color: Colors.black45,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.1,
);
final TextStyle datetimetStyle = GoogleFonts.pridi(
  fontSize: 10.0,
  color: Colors.black38,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.5,
);
final TextStyle smallStyle = GoogleFonts.pridi(
  fontSize: 8.0,
  color: Colors.green[800],
  fontWeight: FontWeight.w600,
  letterSpacing: 1.2,
);
final TextStyle commentStyle = GoogleFonts.pridi(
  fontSize: 8.0,
  color: Colors.red[800],
  fontWeight: FontWeight.w600,
  letterSpacing: 1.2,
);

final TextStyle waitingStyle = GoogleFonts.pridi(
  fontSize: 14.0,
  color: Colors.yellow,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.5,
);
final TextStyle apporveStyle = GoogleFonts.pridi(
  fontSize: 14.0,
  color: Colors.green,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.5,
);
final TextStyle cancelStyle = GoogleFonts.pridi(
  fontSize: 14.0,
  color: Colors.red,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.5,
);
final TextStyle titledoctor_style = GoogleFonts.pridi(
  fontSize: 25.0,
  color: Colors.black54,
  fontWeight: FontWeight.w800,
  letterSpacing: 5,
);
final TextStyle titleB_style = GoogleFonts.pridi(
  fontSize: 20,
  color: Colors.black,
  fontWeight: FontWeight.w800,
  letterSpacing: 3,
);
final TextStyle title_style = GoogleFonts.pridi(
  fontSize: 18.0,
  color: Colors.black54,
  fontWeight: FontWeight.w800,
  letterSpacing: 3,
);
final TextStyle statusStyle = GoogleFonts.pridi(
  fontSize: 15.0,
  color: Colors.white,
  fontWeight: FontWeight.w800,
  letterSpacing: 3,
);
final TextStyle txt_style = GoogleFonts.pridi(
  fontSize: 10.0,
  color: Colors.white,
  fontWeight: FontWeight.w800,
  letterSpacing: 5,
);
buildTextTitleVariation1(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: GoogleFonts.breeSerif(
        fontSize: 36,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    ),
  );
}

buildTextTitleVariation2(String text, bool opacity){
  return Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: Text(
      text,
      style: GoogleFonts.pridi(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: opacity ? Colors.blueAccent[400] : Colors.black,
      ),
    ),
  );
}

buildTextSubTitleVariation1(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey[400],
      ),
    ),
  );
}

buildTextSubTitleVariation2(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[400],
      ),
    ),
  );
}

buildRecipeTitle(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

buildRecipeSubTitle(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[400],
      ),
    ),
  );
}

buildCalories(String text){
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

const kHeadingextStyle = TextStyle(
  fontSize: 28,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
const kSubheadingextStyle = TextStyle(
  fontSize: 24,
  color: Color(0xFF61688B),
  height: 2,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextSyule = TextStyle(
  fontSize: 18,
  color: kTextColor,
  // fontWeight: FontWeight.bold,
);
