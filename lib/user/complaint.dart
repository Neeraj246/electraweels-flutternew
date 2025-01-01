import 'package:flutter/material.dart';

class ComplaintRegistrationScreen extends StatefulWidget {
  @override
  _ComplaintRegistrationScreenState createState() => _ComplaintRegistrationScreenState();
}

class _ComplaintRegistrationScreenState extends State<ComplaintRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register Complaint',style: TextStyle(color: Colors.white),),
 backgroundColor: const Color.fromARGB(255, 33, 58, 34),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              _buildTextField(
                controller: _titleController,
                label: 'Complaint Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Description Field
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Category Dropdown
              _buildDropdownField(),
              SizedBox(height: 20.0),

              // Centered Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitComplaint,
                  style: ElevatedButton.styleFrom(
                    elevation: 5, // Elevation for button
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12), // Padding
                  ),
                  child: Text(
                    'Submit Complaint',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Select Category',
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
      ),
      items: <String>['Service', 'payment failure', 'power issues', 'Other issues']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      // Perform your complaint registration logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint Registered Successfully!')),
      );

      // Optionally clear the form fields after submission
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = null;
      });
    }
  }
}
