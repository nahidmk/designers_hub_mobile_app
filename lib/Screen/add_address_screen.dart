import 'package:designers_hub_modile_app/Model/delivery_address.dart';
import 'package:designers_hub_modile_app/Model/widget_helper_models/textFieldProperties.dart';
import 'package:designers_hub_modile_app/Provider/delivery_address_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  static const routeName = 'add_address';

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  DeliveryAddress args  = DeliveryAddress(id: 0, address: "", title: "", preDefine: false, disable: false, phoneNumber: '');

  TextFieldProperties _titleProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Title  (Home / Office / Other)',
      validate: (String text) {
        if (text.length < 3) {
          return 'Too small';
        } else if (text.length > 20) {
          return 'Too long';
        } else
          return '';
      });

  TextFieldProperties _addressProperties = new TextFieldProperties(
      controller: new TextEditingController(),
      label: 'Address',
      maxLine: 3,
      validate: (String text) {
        if (text.length < 3) {
          return 'Too small';
        } else if (text.length > 100) {
          return 'Too long';
        } else
          return '';
      });


  String _errorMessage = '';

  _dismissErrorMsg() {
    setState(() {
      _errorMessage = '';
    });

    Provider.of<DeliveryAddressProvider>(context, listen: false)
        .deliveryAddressesErrorMsg = '';
  }

  _onChange() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      Provider.of<DeliveryAddressProvider>(context, listen: false)
          .addAddressErrorMsg = '';
      args = ModalRoute.of(context).settings.arguments;
      if (args != null) {
        _titleProperties.controller.text = args.title;
        _addressProperties.controller.text = args.address;

      }
    });

  }

//  @ove



    Navigator.pop(context);
  }

  _checkFormValidity() {
    bool valid = true;
    [_addressProperties, _titleProperties].forEach((element) {
      if (element.controller.text.isEmpty) {
        setState(() {
          _errorMessage = 'Please fill all the fields';
        });
        valid = false;
        return;
      } else if (element.validate(element.controller.text).length > 0) {
        setState(() {
          _errorMessage = 'Please validate the form.';
        });
        valid = false;
        return;
      }
    });

    if (_area.areaName == 'Select area') {
      valid = false;
      _errorMessage = 'Please select an area.';
    }

    return valid;
  }

  _submitAddress(BuildContext context) async {
    if (_checkFormValidity()) {
      bool status = true;
      DeliveryAddress deliveryAddress = new DeliveryAddress(
          title: _titleProperties.controller.text,
          area: _area,
          address: _addressProperties.controller.text);
      if (args == null)
        status =
            await Provider.of<DeliveryAddressProvider>(context, listen: false)
                .createDeliveryAddress(deliveryAddress);
      else {
        deliveryAddress.id = args.id;
        status =
            await Provider.of<DeliveryAddressProvider>(context, listen: false)
                .updateDeliveryAddress(deliveryAddress);
      }

      if (status) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    DeliveryAddressProvider deliveryAddressProvider =
        Provider.of<DeliveryAddressProvider>(context);

    return deliveryAddressProvider.loadingAreas
        ? CupertinoActivityIndicator(
            radius: 15,
          )
        : deliveryAddressProvider.areasErrorMsg != ''
            ? ShowError(
                errorMsg: deliveryAddressProvider.areasErrorMsg,
                onReload: () {
                  deliveryAddressProvider.getAllAreas();
                },
              )
            : CupertinoPageScaffold(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        buildCustomNavigationBar(
                            args == null ? 'Add Address' : 'Edit address',
                            context),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          height:
                              MediaQuery.of(context).size.height - 40 - 58 - 16,
                          child: ListView(
                            children: <Widget>[
                              FormAttribute(
                                icon:
                                    _buildSvgPicture('assets/icons/title.svg'),
                                properties: _titleProperties,
                                onChange: _onChange,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AreaPicker(
                                area: _area,
                                pickArea: _pickArea,
                                areas: deliveryAddressProvider.areas,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormAttribute(
                                icon: Icon(CupertinoIcons.home),
                                properties: _addressProperties,
                                onChange: _onChange,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ShowErrorMsgIfNeeded(
                                  _errorMessage.length > 0
                                      ? _errorMessage
                                      : deliveryAddressProvider
                                          .addAddressErrorMsg,
                                  _dismissErrorMsg),
                              deliveryAddressProvider.loadingAddAddress
                                  ? CupertinoActivityIndicator()
                                  : CupertinoButton(
                                      onPressed: () {
                                        _submitAddress(context);
                                      },
                                      color: CupertinoColors.activeBlue,
                                      child: Text(
                                        args == null
                                            ? 'Add address'
                                            : 'Edit address',
                                        style: TextStyle(
                                            color: CupertinoColors.white),
                                      ),
                                    )
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

class AreaPicker extends StatefulWidget {
  final Area area;
  final Function pickArea;
  final List<Area> areas;

  AreaPicker({this.area, this.pickArea, this.areas});

  @override
  _AreaPickerState createState() => _AreaPickerState();
}

class _AreaPickerState extends State<AreaPicker> {


  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.inactiveGray.withOpacity(0.5),
                  spreadRadius: -7,
                  blurRadius: 15,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                _buildSvgPicture('assets/icons/area.svg'),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Area',
                      style: FormAttribute.labelStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.area != null ? widget.area.areaName : 'Choose area',
                      style: FormAttribute.textStyle,
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 100,
                      height: 60,
                      child: FittedBox(
                        child: Material(
                          color: Colors.transparent,
//                          child: DropdownButton(
//                            hint: Text('Select'),
//                            value: widget.area.id,
//                            onChanged: (value){
//                              widget.pickArea(widget.areas.firstWhere((element) => element.id == value));
//                            },
//                            items: widget.areas.map((e){
//                              return DropdownMenuItem(
//                                child: Text(e.areaName),
//                                value: e.id,
//                              );
//                            }).toList(),
//                          ),
                        child: CupertinoButton(
                          color: widget.area != null ? CupertinoColors.systemOrange : CUSTOMER,
                          child: Text( widget.area != null ? 'Change' : 'Choose', style: TextStyle(fontSize: 30),),
                          onPressed: (){
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder:
                                    (_, scrollController) =>
                                    AreaSelector(areaList: widget.areas,
                                    selectArea: widget.pickArea,
                                    ));
                          },
                        ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class AreaSelector extends StatefulWidget {

  final List<Area> areaList;
  final Function selectArea;

  AreaSelector({this.areaList, this.selectArea});

  @override
  _AreaSelectorState createState() => _AreaSelectorState();
}

class _AreaSelectorState extends State<AreaSelector> {
  List<Area> _backupArea = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _backupArea = [...widget.areaList];
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        children: [
          CupertinoButton(
            onPressed: (){
              Navigator.pop(context);
            },
              child: buildShutterDown(),
          ),
          Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                onChanged: (value){
                  setState(() {
                    _backupArea = [...widget.areaList];
                    setState(() {
                      _backupArea = widget.areaList.where((area) => area.areaName.toLowerCase().contains(value.toLowerCase())).toList();
                    });
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search area',
                    contentPadding: EdgeInsets.only(left: 10)
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _backupArea.map((e) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(e.areaName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                      ),
                      CupertinoButton(
                        child: Text('Select', style: TextStyle(color: CupertinoColors.activeBlue, fontWeight: FontWeight.bold),),
                        onPressed: (){
                          widget.selectArea(e);
                        },
                      ),
                    ],
                  ),
                  Divider()
                ],
              )).toList(),
            ),
          ),
        ],
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
