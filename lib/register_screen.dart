import 'package:flutter/material.dart';
import 'thank_you_screen.dart';
import 'grid.dart';

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

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_plain.jpg'),
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
                                      'Name',
                                      'Please enter your name',
                                      TextInputType.name,
                                      (value) => name = value!),
                                  _buildFormField(
                                      'Mobile Number',
                                      'Please enter your mobile number',
                                      TextInputType.phone,
                                      (value) => mobile = value!),
                                  _buildFormField(
                                      'Pincode',
                                      'Please enter your pincode',
                                      TextInputType.number,
                                      (value) => pincode = value!),
                                  SizedBox(height: 0.03 * maxHeight),
                                  SizedBox(
                                    height: 0.08 * maxHeight,
                                    width: 0.2 * maxWidth,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FlashingIconsGrid()),
                                          );
                                        }
                                      },
                                      child: Text('SUBMIT',
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 0.03 * maxHeight)),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(
                                                vertical: 0.02 * maxHeight)),
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
    );
  }

  Widget _buildFormField(String label, String hint, TextInputType keyboardType,
      Function(String?) onSaved) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.03 * maxHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 0.0302 * maxHeight,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.01 * maxHeight),
          Container(
            height: 0.08 * maxHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFC5A54A), width: 3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.025 * maxHeight),
                    border: InputBorder.none,
                  ),
                  keyboardType: keyboardType,
                  style: TextStyle(
                    color: Color(0xFFC5A54A),
                    letterSpacing: 1,
                    fontSize: 0.035 * maxHeight,
                    fontWeight: FontWeight.bold,
                    height: 2, // to center the text vertically
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  onSaved: onSaved),
            ),
          ),
        ],
      ),
    );
  }
}
