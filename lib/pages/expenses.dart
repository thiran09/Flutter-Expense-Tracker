import 'package:expences_tracker/models/expense.dart';
import 'package:expences_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import '../widgets/add_new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  //expenses list
  final List <ExpenseModel> _expenseList = [
    ExpenseModel(amount: 1000, date: DateTime.now(), category: Category.food, title: "Fried Rice"),
    ExpenseModel(amount: 200, date: DateTime.now(), category: Category.travel, title: "Bus ride"),
    ExpenseModel(amount: 99.99, date: DateTime.now(), category: Category.other, title: "Online Order"),
  ]; //_expenseList is a private variable that can only be used in this class. _ means a private variable

  //add new expense

  void onAddNewExpense(ExpenseModel expense){
    setState(() {
      _expenseList.add(expense);
    });
  }

  //A function to open add new expense window
  void _addNewExpense(){
    showModalBottomSheet(
        context: context,
        builder: (context){
    return AddNewExpense(onAddExpense: onAddNewExpense,);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0), // Set to 0 for no rounded corners
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text (
          "Expense Master",
          style: TextStyle(
            color:  Color(0xffffffff),
          ),
        ),
        backgroundColor: const Color(0xff05161a),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right :20.0),
            decoration:  BoxDecoration(
              color:  const Color(0xff0f969c),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Color(0xffffffff),
              ),
              onPressed: _addNewExpense,
            ),
          ),
        ],
      ),
      body:  Column(
        children: [
            ExpenseList(expenseList: _expenseList,),
        ],
      ),
      
    );
  }
}
