import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AddSparesPage extends StatefulWidget {
  const AddSparesPage({Key? key}) : super(key: key);

  @override
  _AddSparesPageState createState() => _AddSparesPageState();
}

class _AddSparesPageState extends State<AddSparesPage> {
  final _formKey = GlobalKey<FormState>();
  String partName = '';
  String category = '';
  String description = '';
  double price = 0.0;
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  final NumberFormat currencyFormat = NumberFormat.currency(locale: "en_IN", symbol: "₹");

  // List of predefined categories
  final List<String> categories = [
    'Battery',
    'Motor',
    'Charger',
    'Tires',
    'Accessories'
  ];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add EV Spare Parts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 58, 34),
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Image Picker Section
            GestureDetector(
              onTap: () async {
                // Show options for camera or gallery
                final ImageSource? source = await showDialog<ImageSource>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Image Source'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, ImageSource.camera);
                          },
                          child: const Text('Camera'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, ImageSource.gallery);
                          },
                          child: const Text('Gallery'),
                        ),
                      ],
                    );
                  },
                );

                // If a source is selected, pick the image
                if (source != null) {
                  final XFile? pickedFile =
                      await _picker.pickImage(source: source);
                  if (pickedFile != null) {
                    setState(() {
                      imageFile = File(pickedFile.path);
                    });
                  }
                }
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.4),
                child: imageFile == null
                    ? const Icon(Icons.camera_alt,
                        size: 50, color: Colors.green)
                    : ClipOval(
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Form Section
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Part Name
                  _buildTextField(
                    label: 'Part Name',
                    icon: Icons.shopping_cart,
                    onSaved: (value) => partName = value!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter part name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      prefixIcon:
                          const Icon(Icons.category, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    items: categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    onSaved: (value) {
                      category = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Description
                  _buildTextField(
                    label: 'Description',
                    icon: Icons.description,
                    onSaved: (value) => description = value!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Price Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Price',
                      prefixIcon: const Icon(Icons.currency_rupee_rounded, color: Colors.green),
                      prefixText: '₹ ', // Indian Rupee symbol
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        price = double.tryParse(value) ?? 0.0;
                      }
                    },
                    onSaved: (value) => price = double.tryParse(value!) ?? 0.0,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Part Added Successfully')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.green,
                      shadowColor: Colors.greenAccent.withOpacity(0.5),
                      elevation: 10,
                    ),
                    child: const Text(
                      'Add Part',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom method for text fields with icons
  Widget _buildTextField({
    required String label,
    required IconData icon,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
