import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'rules.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String mobile = '';
  String pincode = '';
  double maxHeight = 0.0;
  double maxWidth = 0.0;
  bool _isButtonEnabled = false;

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final String apiUrl = 'https://advocacygame.herokuapp.com/register';
    final Map<String, dynamic> requestData = {
      'name': name,
      'mobile': mobile,
      'pincode': pincode,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RulesScreen()),
        );
        print('Data sent successfully');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode}'),
            duration: Duration(seconds: 5),
          ),
        );
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          duration: Duration(seconds: 5),
        ),
      );
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the input fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // Prevent resizing when the keyboard is displayed
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_plain.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              maxHeight = constraints.maxHeight;
              maxWidth = constraints.maxWidth;

              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.1 * maxHeight, horizontal: 0.1 * maxWidth),
                child: Center(
                  child: SizedBox(
                    width: 0.4 * maxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxHeight: 0.6 * maxHeight),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 0.08 * maxHeight),
                                    _buildFormField(
                                      'NAME',
                                      'Please enter your name',
                                      TextInputType.name,
                                      (value) {
                                        setState(() {
                                          name = value!;
                                          _updateButtonEnabledStatus();
                                        });
                                      },
                                    ),
                                    _buildFormField2(
                                      'MOBILE NUMBER',
                                      'Please enter your mobile number',
                                      TextInputType.number,
                                      (value) {
                                        setState(() {
                                          mobile = value!;
                                          _updateButtonEnabledStatus();
                                        });
                                      },
                                      10,
                                    ),
                                    _buildFormField2(
                                      'PINCODE',
                                      'Please enter your pincode',
                                      TextInputType.number,
                                      (value) {
                                        setState(() {
                                          pincode = value!;
                                          _updateButtonEnabledStatus();
                                        });
                                      },
                                      6,
                                    ),
                                    SizedBox(height: 0.03 * maxHeight),
                                    SizedBox(
                                      height: 0.08 * maxHeight,
                                      width: 0.12 * maxWidth,
                                      child: ElevatedButton(
                                        onPressed: _isButtonEnabled
                                            ? () {
                                                _submitData();
                                              }
                                            : null, // disable the button
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(0),
                                          primary: Colors.transparent,
                                          onPrimary: Colors.white,
                                          elevation: 5,
                                        ),
                                        child: Opacity(
                                          opacity: _isButtonEnabled ? 1 : 0.5,

                                          // reduce the opacity when disabled
                                          child: Container(
                                            padding: EdgeInsets.only(top: 3),
                                            width: 0.12 * maxWidth,
                                            height: 0.08 * maxHeight,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(
                                                      134, 99, 66, 1),
                                                  Color.fromRGBO(
                                                      247, 222, 132, 1),
                                                  Color.fromRGBO(
                                                      247, 222, 132, 1),
                                                  Color.fromRGBO(
                                                      247, 222, 132, 1),
                                                  Color.fromRGBO(
                                                      134, 99, 66, 1),
                                                ],
                                                stops: [
                                                  0.01,
                                                  0.2,
                                                  0.5,
                                                  0.7,
                                                  0.95,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                transform: GradientRotation(
                                                    170 * (pi / 180)),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'SUBMIT',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'CustomFont',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _updateButtonEnabledStatus() {
    setState(() {
      _isButtonEnabled = _formKey.currentState!.validate() &&
          name.isNotEmpty &&
          mobile.isNotEmpty &&
          pincode.isNotEmpty;
    });
  }

  Widget _buildFormField(String label, String hint, TextInputType keyboardType,
      Function(String?) onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.03 * maxHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CustomFont',
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 0.0302 * maxHeight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.01 * maxHeight),
          Container(
            height: 0.09 * maxHeight,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromRGBO(247, 222, 132, 1), width: 3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: TextFormField(
                  cursorColor: Color.fromRGBO(247, 222, 132, 1),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.025 * maxHeight),
                    border: InputBorder.none,
                  ),
                  keyboardType: keyboardType,
                  style: TextStyle(
                    color: Color.fromRGBO(247, 222, 132, 1),
                    letterSpacing: 1,
                    fontSize: 0.035 * maxHeight,
                    fontWeight: FontWeight.bold,
                    height: 2, // to center the text vertically
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  onChanged: onChanged),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField2(String label, String hint, TextInputType keyboardType,
      Function(String?) onChanged, int maxLength) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.03 * maxHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CustomFont',
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 0.0302 * maxHeight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.01 * maxHeight),
          Container(
            height: 0.09 * maxHeight,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromRGBO(247, 222, 132, 1), width: 3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: TextFormField(
                  cursorColor: Color.fromRGBO(247, 222, 132, 1),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.025 * maxHeight),
                    border: InputBorder.none,
                    counterText: '', // hide the counter
                  ),
                  keyboardType: keyboardType,
                  style: TextStyle(
                    color: Color.fromRGBO(247, 222, 132, 1),
                    letterSpacing: 1,
                    fontSize: 0.035 * maxHeight,
                    fontWeight: FontWeight.bold,
                    height: 2, // to center the text vertically
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  onChanged: onChanged,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: maxLength),
            ),
          ),
        ],
      ),
    );
  }
}
