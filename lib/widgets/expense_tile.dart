import 'package:expences_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: const Color(0xffffffff),
      elevation: 0,
      child: Padding(
        padding:  const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
             const SizedBox(height: 8,),
            // const Spacer(),
            Row(
              children:[Text(
                'Rs.${expense.amount.toStringAsFixed(2)}',
              ),
                 const SizedBox(width: 10,),
                 const Spacer(),
                Row(
                  children: [
                     Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 10),
                    Text(expense.getFormattedDate)

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
