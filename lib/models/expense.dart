import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();

//date formatter
final formattedDate = DateFormat.yMd();
final categoryIcons = {
  Category.work: Icons.work,
  Category.other: Icons.notes_sharp,
  Category.travel: Icons.bus_alert,
  Category.food: Icons.fastfood
};

enum Category { food, travel, work, other }

class ExpenseModel {
  //constructor
  ExpenseModel({
    required this.amount,
    required this.date,
    required this.category,
    required this.title,
  }) : id = uuid;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getter > formatted date
  String get getFormattedDate {
    return formattedDate.format(date);
  }
}
