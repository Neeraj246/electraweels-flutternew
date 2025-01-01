// import 'package:flutter/material.dart';


// class Viewmydonation extends StatefulWidget {
//   const Viewmydonation({super.key, required this.data});
//   final data;

//   @override
//   State<Viewmydonation> createState() => _ViewmydonationState();
// }

// class _ViewmydonationState extends State<Viewmydonation> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   bool _otpSent = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 241, 240, 236),
//         title: Text('OTP Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // if (!_otpSent)
//             //   TextFormField(
//             //     controller: _emailController,
//             //     decoration: InputDecoration(
//             //       labelText: 'Email',
//             //     ),
//             //     keyboardType: TextInputType.phone,
//             //   ),
//             if (!_otpSent)
//               TextFormField(
//                 controller: _otpController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter OTP',
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 //otpApi(_otpController.text, widget.data, context);

//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (context) => const UserHomePage()));
//                 // if (!_otpSent) {
//                 //   // Here, you would send the OTP to the user's phone number
//                 //   print('Sending OTP to ${_emailController.text}');
//                 //   setState(() {
//                 //     _otpSent = true;
//                 //   });
//                 // } else {
//                 //   // Here, you would verify the OTP entered by the user
//                 //   print('Verifying OTP: ${_otpController.text}');

//                 // }
//               },
//               child: Text(_otpSent ? 'Verify OTP' : 'Send OTP'),
//             ),
//             const SizedBox(height: 20),
//             if (_otpSent)
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     _otpSent = false;
//                     // _emailController.clear();
//                     _otpController.clear();
//                   });
//                 },
//                 child: Text('Need help?'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
