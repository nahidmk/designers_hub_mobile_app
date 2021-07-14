import 'dart:async';

import 'package:designers_hub_modile_app/Model/design.dart';
import 'package:designers_hub_modile_app/Provider/design_provider.dart';
import 'package:designers_hub_modile_app/Screen/product_details_screen.dart';
import 'package:designers_hub_modile_app/helper/colors.dart';
import 'package:designers_hub_modile_app/helper/constants.dart';
import 'package:designers_hub_modile_app/widget/Design/single_sesign_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // List<Design> designList = [];
  TextEditingController _searchFieldController = new TextEditingController();
  Timer? _debounce;
  bool loading = false;

 _searchDesign() {
    setState(() {
      Provider.of<DesignProvider>(context,listen: false).getDesignList();
      loading = false;
    });

  }

  _onSearch() {

    print('is calling ---');
    setState(() {
      loading = true;
    });
    if(_searchFieldController.text.isEmpty){
      print('if empty---');
      _searchDesign();
      return;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: 600), () async {
      if (this.mounted) {
         Provider.of<DesignProvider>(context, listen: false)
            .getDesignList(designName: _searchFieldController.text);

        setState(() {
          loading = false;
        });
      }
     }
    );
  }

  @override
  Widget build(BuildContext context) {

    DesignProvider designProvider = Provider.of<DesignProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: CupertinoTextField(
          controller: _searchFieldController,
          autofocus: true,
          placeholder: 'Type Design name to search',
          placeholderStyle: TextStyle(
            fontSize: 16,
            color: Colors.black38,
          ),
          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
          style: TextStyle(fontSize: 18),
          decoration: BoxDecoration(
            color: LIGHT_GRAY,
            // borderRadius: BorderRadius.circular(10),
          ),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Icon(CupertinoIcons.search),
          ),
          onChanged: (value){
            // _searchDesign();
            _onSearch();
          },
        ),


      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: designProvider.designList.isEmpty? Container(
          child: Center(
            child: Text(
                'No match found',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black38
                ),
            ),
          ),
        )
            :loading?Center(child: CupertinoActivityIndicator(),):ListView(
          children: [
            ...designProvider.designList.map((e) =>
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(id: e.id,)));
                    },
                    child:
                    SingleDesignCard(
                      e.price,
                      e.name,
                      MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height/4,
                      '$IMAGE_URL${e.thumbnail}',
                    )

                )
            ),
          ],
        ),
      ),

    );
  }
}
