import 'package:designers_hub_modile_app/Model/user.dart';
import 'package:designers_hub_modile_app/Model/widget_helper_models/textFieldProperties.dart';
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/helper/colors.dart';
import 'package:designers_hub_modile_app/widget/common/form_attribute.dart';
import 'package:designers_hub_modile_app/widget/signin_signup_form/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  final User user;

  ProfileInformation({ required this.user});

  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {

  TextFieldProperties _firstNameProperties =  TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Full Name',
      inputType: "text",
      keyboardType: TextInputType.text,
      validate: (String text) {
        if (text.length < 3) {
          return 'Too small';
        } else if (text.length > 20) {
          return 'Too long';
        } else
          return '';
      });



  TextFieldProperties _contactNumberProperties =  TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Contact number',
      inputType: "number",
      keyboardType: TextInputType.number,
      validate: (String text) {
        if (text.length < 11 || text.length > 11) {
          return 'Phone number must be 11 digits.';
        } else
          return '';
      });


  TextFieldProperties _addressProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Address',
      inputType: "text",
      keyboardType: TextInputType.text,
      validate: (String text) {
        if (text.length < 3) {
          return 'Not a valid address.';
        } else
          return '';
      });

  TextFieldProperties _birthDateProperties = new TextFieldProperties(
    controller: TextEditingController(),
      inputType: "date",
      keyboardType: TextInputType.datetime,
      label: 'Birth date',
      selectedDate: '',
      validate: (String text) {
        return '';
      });

  String _gender="";
  bool _changed = false;
  bool _updateProfileLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      Provider.of<ProfileProvider>(context, listen: false).updateProfileErrorMsg = '';
    });

    _firstNameProperties.controller.text = widget.user.fullName;
    _addressProperties.controller.text = widget.user.address;
    _contactNumberProperties.controller.text = widget.user.secondaryNumber != null ? widget.user.secondaryNumber.substring(3) : '';
    _birthDateProperties.selectedDate = widget.user.dateOfBirth == null
        ? 'Select your birth date.'
        : widget.user.dateOfBirth;

    _gender = widget.user.gender;
    _changed = false;
  }

  _onChangeGender(String selectedGender) {
    setState(() {
      _gender = selectedGender;
      _changed = true;
    });
  }

  _onChange(){
    setState(() {
      _changed = true;
    });
  }

  _updateProfile(){
    setState(() {
      _changed = false;
    });

    widget.user.fullName = (_firstNameProperties.controller.text != '' ? _firstNameProperties.controller.text : null)!;
    widget.user.secondaryNumber = (_contactNumberProperties.controller.text != '' ? '+88${_contactNumberProperties.controller.text}' : null)!;
    widget.user.address = (_addressProperties.controller.text != '' ? _addressProperties.controller.text : null)!;
    widget.user.gender = _gender;
    widget.user.dateOfBirth = (_birthDateProperties.selectedDate != 'Select your birth date.' ? _birthDateProperties.selectedDate : null)!;

    _updateProfileLoading = true;

    final status = Provider.of<ProfileProvider>(context, listen: false).updateProfile(widget.user);

    print("status---->${status}");
    _updateProfileLoading = false;

  }

  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right:20.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: _updateProfileLoading ? CupertinoActivityIndicator() : SizedBox(
                    width: 80,
                    child: FittedBox(
                      child: CupertinoButton(
                        child: Text('Save', style: TextStyle(fontSize: 40, color: Colors.white),),
                        disabledColor: Colors.grey,
                        color: Colors.blueAccent,
                        onPressed: !_changed ? null : (){
                          _updateProfile();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 350,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    ShowErrorMsgIfNeeded(profileProvider.updateProfileErrorMsg,(){profileProvider.updateProfileErrorMsg = '';} ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/name.svg'),
                      properties: _firstNameProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/name.svg'),
                      properties: _contactNumberProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/address.svg'),
                      properties: _addressProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/calendar.svg'),
                      properties: _birthDateProperties,
                      onChange: (String value) {
                        print('date value ----> $value');
                        _onChange();
                        _birthDateProperties.selectedDate = value.split(' ')[0];
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GenderRadioButtons(gender: _gender, onChange: _onChangeGender),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class GenderRadioButtons extends StatelessWidget {
  final Function onChange;
  final String gender;

  GenderRadioButtons({required this.onChange, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RadioButtons(label: 'Male',value: 'MALE',selectedValue: gender,onChange: onChange),
          RadioButtons(label: 'Female',value: 'FEMALE',selectedValue: gender,onChange: onChange),
          RadioButtons(label: 'Other',value: 'OTHER',selectedValue: gender,onChange: onChange),
        ],
      ),
    );
  }
}

class RadioButtons extends StatelessWidget {
  final String label;
  final String value;
  final String selectedValue;
  final Function onChange;

  RadioButtons({required this.label, required this.value, required this.selectedValue, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange(value);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 70) / 3,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: value == selectedValue ? GRADIENT_RED : [Colors.grey, Colors.grey],
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),

      ),
    );
  }
}

Widget _buildSvgPicture(String url) {
  return SvgPicture.asset(
    url,
    fit: BoxFit.cover,
    height: 30,
    width: 30,
  );
}
