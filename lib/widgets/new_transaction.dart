import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//change from stless to stateful so data don't get lost in the textfield
class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;
  void _submitData() {

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(amountController.text.isEmpty){
      return;
    }
    if (_selectedDate==null||enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((value) {
      if(value==null){
        return;
      }
      setState((){
        _selectedDate=value;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all( 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate==null?
                    'No Date Chosen!'
                        :'Picked Date:${DateFormat.yMd().format(_selectedDate!)}'
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: const Text(
                        'Choose Date!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal)),
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
