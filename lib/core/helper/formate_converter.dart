import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatConverter {
  static Uint8List base64ToUint8List(String base64String) {
    return base64Decode(base64String);
  }

  static String uint8ListToBase64(Uint8List uint8List) {
    return base64Encode(uint8List);
  }

  static TimeOfDay base64ToTimeOfDay(String base64String) {
    return TimeOfDay(
      hour: int.parse(base64String.split(':')[0]),
      minute: int.parse(base64String.split(':')[1]),
    );
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE, dd MMM yyyy').format(dateTime);
  }

  static String formatTimeOfDay(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}