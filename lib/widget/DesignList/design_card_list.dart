import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/widget/DesignList/single_sesign_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesignList extends StatefulWidget {

  @override
  _DesignListState createState() => _DesignListState();
}

class _DesignListState extends State<DesignList> {

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DesignProvider>(context, listen: false).getDesignList();
    });
  }

  @override
  Widget build(BuildContext context) {

    DesignProvider designProvider = Provider.of<DesignProvider>(context);

    double screenHeight = ((MediaQuery.of(context).size.height)/4)+40;
    double screenWidth = (MediaQuery.of(context).size.width)/3;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: screenHeight,
      child: designProvider.loadingDesignList ?
      Center(child: CupertinoActivityIndicator(),) :
      ListView(
        children: designProvider.designList.map((e) => (
            SingleDesignCard(e.price, e.name, screenWidth, screenHeight, '$IMAGE_URL${e.thumbnail}',e.descriptions)
        )).toList(),
      ),
    );
  }
}
