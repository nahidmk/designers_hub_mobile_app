import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/home_page_design.dart';
import 'package:designers_hub_modile_app/Model/home_page_design_details.dart';
import 'package:designers_hub_modile_app/Provider/home_page_design_provider.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotDesign extends StatefulWidget {

  @override
  _HotDesignState createState() => _HotDesignState();
}

class _HotDesignState extends State<HotDesign> {
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<HomePageDesignProvider>(context, listen: false).getHomePageDesignList();
    });
  }

  @override
  Widget build(BuildContext context) {


    HomePageDesignProvider homePageDesignProvider = Provider.of<HomePageDesignProvider>(context);

    double screenHeight = ((MediaQuery.of(context).size.height)/4).roundToDouble();
    double screenWidth = (MediaQuery.of(context).size.width);

    return homePageDesignProvider.loadingHomePageDesignList?
    Center(child: CupertinoActivityIndicator(),)
    : ListView(
      padding: EdgeInsets.all(5.0),
      children: homePageDesignProvider.homePageDesignList.map((HomePageDesign homePageDesign) => (
          Container(
            width: screenWidth,
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: homePageDesign.homePageDesignDetailsList.map((HomepageDesignDetails designDetails) => (
                  hotDesignCard(designDetails: designDetails, onClick: (){})
              )).toList(),
            ),
          )
      )).toList()

    );
  }
}

Widget hotDesignCard({required HomepageDesignDetails designDetails, required Function onClick}) {
  return (
    Container(
      height: 150,
      child: Column(
        children: [
          Image.network('$IMAGE_URL${designDetails.image}',height: 130, fit: BoxFit.fill,),
          Text(designDetails.design.name)
        ],
      ),
    )
  );
}


