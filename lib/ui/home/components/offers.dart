import 'package:flutter/material.dart';

class OffersHeader extends StatefulWidget {
  static final id = 'offers';
  @override
  _OffersHeaderState createState() => _OffersHeaderState();
}

class _OffersHeaderState extends State<OffersHeader> {
  int index = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getOffers();
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OffersText(),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.21,
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Offers(index);
              }),
        ),
      ],
    );
  }

//------------------------------------------------------------------------------
  Widget OffersText() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: Text(
            "آخر التبرعات",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            //TODO: Go to more details page
          },
          child: Text(
            "تحميل المزيد",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }

  //------------------------------Offers----------------------------------------
  Widget Offers(int index) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imgList[index].toString()),
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            width: 90,
            child: Column(
              children: [
                Text(
                  "Apple Watch",
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "10 \$",
                  style: TextStyle(color: Colors.red),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------

} //------------------------End class-------------------------------------------
//TODO: arrange code in seperate classes and add information of offers under each item
