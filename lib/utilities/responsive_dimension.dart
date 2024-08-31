import 'package:flutter/material.dart';

// This is a class that helps with responsive dimensions to be used in the application.
// A typical usage will be ResponsiveDimension.height(0.1, context) where the value could range from 0 to 1.
//with 1 being the full dimension of the screen and 0 being an empty dimension.

class ResponsiveDimension {
  ResponsiveDimension._();

  static double height(double value, BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return (height * value);
  }

  static double width(double value, BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * value);
  }
}
