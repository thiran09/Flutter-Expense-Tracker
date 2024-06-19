import 'package:expences_tracker/models/expense.dart';
import 'package:expences_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../widgets/add_new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  //expenses list
  final List <ExpenseModel> _expenseList = [
    ExpenseModel(amount: 1000,
        date: DateTime.now(),
        category: Category.food,
        title: "Fried Rice"),
    ExpenseModel(amount: 200,
        date: DateTime.now(),
        category: Category.travel,
        title: "Bus ride"),
    ExpenseModel(amount: 99.99,
        date: DateTime.now(),
        category: Category.other,
        title: "Online Order"),
  ]; //_expenseList is a private variable that can only be used in this class. _ means a private variable

  //add new expense
  void onAddNewExpense(ExpenseModel expense) {
    setState(() {
      _expenseList.add(expense);
      calCategoryValues();
    });


  }

  //remove an expense
  void onDeleteExpense(ExpenseModel expense) {
    //store the deleting expense
    ExpenseModel deletedExpense = expense;
    //index of deleting expense
    final removingExpense = _expenseList.indexOf(expense);
    setState(() {
      _expenseList.remove(expense);
      calCategoryValues();
    });
    //show snack bar
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: const Text("Deleted successful"),
          action: SnackBarAction(
              label: "Undo",
              onPressed: (){
                setState(() {
                  _expenseList.insert(removingExpense, deletedExpense);
                  calCategoryValues();
                });
              }
          )),

    );
  }

  //A function to open add new expense window
  void _addNewExpense() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddNewExpense(onAddExpense: onAddNewExpense,);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0), // Set to 0 for no rounded corners
          ),
        )
    );
  }

  //pie chart
  Map<String, double> dataMap = {
    "Food": 10,
    "Work": 20,
    "Travel": 5,
    "Other": 4,
  };

  double foodVal = 0;
  double workVal = 0;
  double travelVal = 0;
  double otherVal = 0;

  void calCategoryValues(){
    double foodValTotal = 0;
    double workValTotal = 0;
    double travelValTotal = 0;
    double otherValTotal = 0;

    for(final expense in _expenseList){
      if(expense.category == Category.food){
        foodValTotal += expense.amount;
      }
      if(expense.category == Category.work){
        workValTotal += expense.amount;
      }
      if(expense.category == Category.travel){
        travelValTotal += expense.amount;
      }
      if(expense.category == Category.other){
        otherValTotal += expense.amount;
      }
    }

    setState(() {
      foodVal = foodValTotal;
      travelVal = travelValTotal;
      workVal = workValTotal;
      otherVal = otherValTotal;
    });

    //update data map
    dataMap = {
      "Food": foodVal,
      "Work": workVal,
      "Travel": travelVal,
      "Other": otherVal,
    };

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calCategoryValues();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text (
          "Expense Master",
          style: TextStyle(
            color: Color(0xffffffff),
          ),
        ),
        backgroundColor: const Color(0xff05161a),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20.0),
            decoration: BoxDecoration(
              color: const Color(0xff0f969c),
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
      body: Column(
        children: [
          PieChart(dataMap: dataMap),
          ExpenseList(
            expenseList: _expenseList, onDeleteExpense: onDeleteExpense,),
        ],
      ),

    );
  }
}
