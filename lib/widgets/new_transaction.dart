import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate;

  void submitdata() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null)
      return;

    widget.addtx(_titleController.text, double.parse(_amountController.text),
        _selectDate);
    Navigator.of(context).pop();
  }

  void _presentDatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else {
        setState(() {
          _selectDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: _titleController,
            onSubmitted: (_) => submitdata(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitdata(),
          ),
          Container(
            height: 15,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    (_selectDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date ${DateFormat.yMd().format(_selectDate)}'),
                    style: TextStyle(
                        fontWeight: FontWeight.w100, color: Colors.blue),
                  ),
                ),
                FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatepicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.w100, color: Colors.blue),
                    ))
              ],
            ),
          ),
          RaisedButton(
            child: Text('Add Transcation'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: submitdata,
          )
        ],
      ),
    ));
  }
}
