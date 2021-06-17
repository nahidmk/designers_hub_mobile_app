import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:os_ios/helper/colors.dart';
import 'package:os_ios/models/enums/input_types.dart';
import 'package:os_ios/models/user.dart';
import 'package:os_ios/models/widget_helper_models/textFieldProperties.dart';
import 'package:os_ios/providers/profile_provider.dart';
import 'package:os_ios/widgets/common/Text_field_with_validation.dart';
import 'package:os_ios/widgets/common/customeScrollBar.dart';
import 'package:os_ios/widgets/common/form_attribute.dart';
import 'package:os_ios/widgets/common/form_attribute.dart';
import 'package:os_ios/widgets/common/form_attribute.dart';
import 'package:os_ios/widgets/common/form_attribute.dart';
import 'package:os_ios/widgets/common/form_attribute.dart';
import 'package:os_ios/widgets/signin_signup_form/helper_widgets.dart';
import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  final User user;

  const ProfileInformation({Key key, this.user}) : super(key: key);

  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {

  TextFieldProperties _firstNameProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'First name',
      validate: (String text) {
        if (text.length < 3) {
          return 'Too small';
        } else if (text.length > 20) {
          return 'Too long';
        } else
          return '';
      });

  TextFieldProperties _lastNameProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Last Name',
      validate: (String text) {
        if (text.length < 3) {
          return 'Too small';
        } else if (text.length > 20) {
          return 'Too long';
        } else
          return '';
      });

  TextFieldProperties _contactNumberProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Contact number',
      inputType: InputTypes.number,
      keyboardType: TextInputType.number,
      validate: (String text) {
        if (text.length < 11 || text.length > 11) {
          return 'Phone number must be 11 digits.';
        } else
          return '';
      });

  TextFieldProperties _emailProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Email',
      validate: (String text) {
        if (text.length < 12 || !text.contains('.') || !text.contains('@')) {
          return 'Not a valid email.';
        } else
          return '';
      });

  TextFieldProperties _addressProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Address',
      validate: (String text) {
        if (text.length < 3) {
          return 'Not a valid address.';
        } else
          return '';
      });

  TextFieldProperties _birthDateProperties = new TextFieldProperties(
      inputType: InputTypes.date,
      label: 'Birth date',
      selectedDate: '',
      validate: (String text) {
        return '';
      });

  String _gender;
  bool _changed = false;
  bool _updateProfileLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<ProfileProvider>(context, listen: false).updateProfileErrorMsg = '';
    });

    _firstNameProperties.controller.text = widget.user.name.firstName;
    _lastNameProperties.controller.text = widget.user.name.lastName;
    _emailProperties.controller.text = widget.user.email;
    _addressProperties.controller.text = widget.user.address;
    _contactNumberProperties.controller.text = widget.user.alternativePhone != null ? widget.user.alternativePhone.substring(3) : '';
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

    widget.user.name.firstName = _firstNameProperties.controller.text != '' ? _firstNameProperties.controller.text : null;
    widget.user.name.lastName = _lastNameProperties.controller.text != '' ? _lastNameProperties.controller.text : null;
    widget.user.email = _emailProperties.controller.text != '' ? _emailProperties.controller.text : null;
    widget.user.alternativePhone = _contactNumberProperties.controller.text != '' ? '+88${_contactNumberProperties.controller.text}' : null;
    widget.user.address = _addressProperties.controller.text != '' ? _addressProperties.controller.text : null;
    widget.user.gender = _gender;
    widget.user.dateOfBirth = _birthDateProperties.selectedDate != 'Select your birth date.' ? _birthDateProperties.selectedDate : null;

    _updateProfileLoading = true;

    final status = Provider.of<ProfileProvider>(context, listen: false).updateProfile(widget.user);

    _updateProfileLoading = false;

  }

  @override
  Widget build(BuildContext context) {

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return CustomScrollbar(
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
                  child: _updateProfileLoading ? CupertinoActivityIndicator : SizedBox(
                    width: 80,
                    child: FittedBox(
                      child: CupertinoButton(
                        child: Text('Save', style: TextStyle(fontSize: 40, color: CupertinoColors.white),),
                        disabledColor: CupertinoColors.inactiveGray,
                        color: CupertinoColors.activeBlue,
                        onPressed: !_changed ? null : (){
                          _updateProfile();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Row(
                        children: [
                          Text('Referral code:  '),
                          SelectableText(profileProvider.profile.referralCode, style: TextStyle(fontSize: 16),),
                          GestureDetector(
                            onTap: (){
                              FlutterShare.share(
                                  title: 'Oushod sheba',
                                  text: 'Oushod sheba referral code: ${profileProvider.profile.referralCode} \n\nandroid app: https://play.google.com/store/apps/details?id=com.oushodsheba.consumer \n\nIOS app: https://apps.apple.com/bn/app/oushod-sheba/id1524743363  \n\nwebsite: https://oushodsheba.com'
                              );
                            },
                              child: Icon(CupertinoIcons.share_solid, color: CupertinoColors.activeBlue,)
                          )
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child:Text('Share the referral code and earn 25 BDT per installation.')
                    ),
                    SizedBox(height: 10,),
                    ShowErrorMsgIfNeeded(profileProvider.updateProfileErrorMsg,(){profileProvider.updateProfileErrorMsg = '';} ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/name.svg'),
                      properties: _firstNameProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/name.svg'),
                      properties: _lastNameProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/email.svg'),
                      properties: _emailProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/name.svg'),
                      properties: _contactNumberProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormAttribute(
                      icon: _buildSvgPicture('assets/icons/address.svg'),
                      properties: _addressProperties,
                      onChange: _onChange,
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 20,
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

  GenderRadioButtons({this.onChange, this.gender});

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

  RadioButtons({this.label, this.value, this.selectedValue, this.onChange});

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
            colors: value == selectedValue ? GRADIENT_RED : [CupertinoColors.inactiveGray, CupertinoColors.inactiveGray],
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w300),
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
