import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Model/home_page_design.dart';
import 'package:designers_hub_modile_app/Model/home_page_design_details.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Provider/home_page_design_provider.dart';
import 'package:designers_hub_modile_app/Provider/profile_provider.dart';
import 'package:designers_hub_modile_app/Screen/product_details_screen.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/widget/Design/single_sesign_card.dart';
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
      if(Provider.of<HomePageDesignProvider>(context, listen: false).homePageDesignList.isEmpty)
        Provider.of<HomePageDesignProvider>(context, listen: false).getHomePageDesignList();
      if(Provider.of<DesignProvider>(context, listen: false).designList.isEmpty)
        Provider.of<DesignProvider>(context, listen: false).getDesignList();
      if(Provider.of<ProfileProvider>(context,listen: false).profile.primaryNumber.isEmpty)
        Provider.of<ProfileProvider>(context,listen: false).isLogin();
    });
  }

  @override
  Widget build(BuildContext context) {


    HomePageDesignProvider homePageDesignProvider = Provider.of<HomePageDesignProvider>(context);
    DesignProvider designProvider = Provider.of<DesignProvider>(context);

    double screenHeightForDesignCard = ((MediaQuery.of(context).size.height)/4);
    double screenWidthForDesignCard = (MediaQuery.of(context).size.width);

    double screenHeight = ((MediaQuery.of(context).size.height)/3);
    double screenWidth = (MediaQuery.of(context).size.width)+200;

    return homePageDesignProvider.loadingHomePageDesignList?
    Center(child: CupertinoActivityIndicator(),)
    : ListView(


      children:[

        ...homePageDesignProvider.homePageDesignList.map((HomePageDesign homePageDesign) => (
          Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2.0)),
            width: screenWidth,
            height: homePageDesign.height/2.5,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: homePageDesign.homePageDesignDetailsList.map((HomepageDesignDetails designDetails) => (
                  hotDesignCard(homePageDesign: homePageDesign,designDetails: designDetails, onClick: (){},screenHeight: screenHeight-6,screenWidth: screenWidth)
              )).toList(),
            ),
          )
      )),

      ...designProvider.designList.map((e) =>
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(id: e.id,)));
            },
            child: (
                SingleDesignCard(
                    e.price,
                    e.name,
                    screenWidthForDesignCard,
                    screenHeightForDesignCard,
                    '$IMAGE_URL${e.thumbnail}',
                )
            ),
          )
        ),
      ]

    );
  }
}

Widget hotDesignCard({required HomePageDesign homePageDesign,required HomepageDesignDetails designDetails, required Function onClick, required double screenWidth, required double screenHeight}) {
  return (
    Card(
      elevation: 2,
      shadowColor: Colors.grey,
      child: Column(
        children: [
          Image.network('$IMAGE_URL${designDetails.image}',height: (homePageDesign.height/2.5)-14,width: (screenWidth/12)*designDetails.colSize, fit: BoxFit.cover,),
          // Container(margin:EdgeInsets.only(top: 5),child: Text(designDetails.design.name,textAlign: TextAlign.left,) ,width: screenWidth,height: screenHeight/4,)
        ],
      ),
    )
  );
}


