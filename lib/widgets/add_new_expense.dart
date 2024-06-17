import 'package:expences_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewExpense extends StatefulWidget {
  final void Function(ExpenseModel expense) onAddExpense;
  const AddNewExpense({super.key, required this.onAddExpense});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedCategory = Category.food;

  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime
          .now()
          .year - 1, DateTime
      .now()
      .month, DateTime
      .now()
      .day);
  final DateTime lastDate = DateTime(
      DateTime
          .now()
          .year + 1, DateTime
      .now()
      .month, DateTime
      .now()
      .day);

  DateTime _selectedDate = DateTime.now();

  Future<void> _openDateModel() async {
    try {
      final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate);

      setState(() {
        _selectedDate = pickedDate!;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  //handle form submit
  void _handleFormSubmit() {
    final userAmount = double.parse(_amountController.text.trim());
    final userTitle = _titleController.text.trim();

    if (userTitle.isEmpty || userAmount <= 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error while Submitting'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Title should not be Empty or the Expense Amount should not be less than Rs.0'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // Set the text color to red
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          });
    } else {
      //create new expense
      ExpenseModel newExpense = ExpenseModel(amount: userAmount,
          date: _selectedDate,
          category: _selectedCategory,
          title: _titleController.text.trim());
      //save the data from form
      widget.onAddExpense(newExpense);
      Navigator.of(context).pop();

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose(); //used to clear the garbage memory
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: const Color(0xff0c6f74), // pop window background color
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Expense title",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: const Color(0xb5000000)),
                  label: Text("Title",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xb5000000))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide
                          .none // Set borderRadius to zero for no rounded corners
                  ),
                  filled: true,
                  fillColor: const Color(
                      0xffffffff), // Set background color of the TextField
                ),
                keyboardType: TextInputType.text,
                maxLength: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: "Expensed amount",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: const Color(0xb5000000)),
                        label: Text("Amount Rs.",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xb5000000))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide
                                .none // Set borderRadius to zero for no rounded corners
                        ),
                        filled: true,
                        fillColor: const Color(
                            0xffffffff), // Set background color of the TextField
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(formattedDate.format(_selectedDate)),
                          IconButton(
                              onPressed: _openDateModel,
                              icon: const Icon(Icons.date_range_outlined)),
                        ],
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) =>
                        DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name,
                          ),
                        ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                              WidgetStatePropertyAll(Color(0xfffa3a4d)),
                            ),
                            child: Text("Close",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xffffffff))),
                          ),
                          const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: _handleFormSubmit,
                            style: const ButtonStyle(
                              backgroundColor:
                              WidgetStatePropertyAll(Color(0xff0f959b)),
                            ),
                            child: Text("Save",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xffffffff))),
                          )
                        ],
                      ))
                ],
              ),
            )
          ], // Children
        ),
      ),
    );
  }
}
