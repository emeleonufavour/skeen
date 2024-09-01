import 'package:flutter/material.dart';

/// This is an extension on the [num] datatype in Dart. With this we are able to create
/// a [SizedBox] widget from [num] objects. An example is this "5.sH" where a [SizedBox]
/// of a height of 5 will be generated. The [num] datatype was chosen to accomodate both [int]
/// and [double] datatypes.

extension SizedBoxExt on num {
  Widget get sH => SizedBox(
        height: toDouble(),
      );
  Widget get sW => SizedBox(
        width: toDouble(),
      );
}
