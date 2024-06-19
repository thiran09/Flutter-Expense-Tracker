import 'package:expences_tracker/widgets/expense_tile.dart';

import '../models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> expenseList;
  final void Function(ExpenseModel) onDeleteExpense;
  const ExpenseList({super.key, required this.expenseList, required this.onDeleteExpense});



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: ValueKey(expenseList[index]),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction){
                  onDeleteExpense(expenseList[index]);
                },
                child: ExpenseTile(expense: expenseList[index]));
          }),
    );
  }
}
