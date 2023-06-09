import 'package:flutter/material.dart';

import '../user/helpers/user_functions.dart';

class RandomTransactionPopup extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const RandomTransactionPopup({Key? key, required this.onSubmit})
      : super(key: key);

  @override
  _RandomTransactionPopupState createState() => _RandomTransactionPopupState();
}

class _RandomTransactionPopupState extends State<RandomTransactionPopup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _tidController = TextEditingController();

  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _tidController.text = generateRandomTransactionId();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _tidController.dispose();
    super.dispose();
  }

  void _onSubmitPressed(BuildContext context) {
    setState(() {
      _submitted = true;
    });

    if (_validateFields()) {
      String name = _nameController.text;
      int amount = int.tryParse(_amountController.text) ?? 0;
      int tid = int.tryParse(_tidController.text) ?? 0;

      widget.onSubmit({'name': name, 'amount': amount, 'tid': tid});
      Navigator.pop(context);
    }
  }

  bool _validateFields() {
    bool isValid = true;

    if (_nameController.text.isEmpty || _nameController.text.length > 20) {
      isValid = false;
    }

    if (_amountController.text.isEmpty) {
      isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Transaction Details',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 23.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  errorText: _submitted &&
                          (_nameController.text.isEmpty ||
                              _nameController.text.length > 20)
                      ? 'Maximum of 20 characters only'
                      : null,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: const OutlineInputBorder(),
                  errorText: _submitted && _amountController.text.isEmpty
                      ? 'Amount is required'
                      : null,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _tidController,
                enabled: false, // Make the transaction ID field read-only
                decoration: const InputDecoration(
                  labelText: 'Transaction ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _onSubmitPressed(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  // Close the popup
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
