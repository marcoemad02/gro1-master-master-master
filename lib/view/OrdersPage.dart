import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    Key? key,
    required this.productStream,
    required this.BranchName,
    required this.cRef,
    required this.streamBranchOrders,
    required this.deleteRef, required this.cref3,
  }) : super(key: key);

  final Stream<QuerySnapshot> productStream;
  final Stream<QuerySnapshot> streamBranchOrders;
  final String BranchName;
  final CollectionReference cRef;
  final CollectionReference deleteRef;
  final CollectionReference cref3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Text(
              'الطلبات',
              style: TextStyle(fontFamily: 'alexandria'),
            ),
          ],
        ),
        backgroundColor: const Color(0xffFF7517),
        actions: [
          IconButton(
            onPressed: () async {
              var snapshot = await deleteRef.get();
              for (var doc in snapshot.docs) {
                await doc.reference.delete();
              }
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: streamBranchOrders,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Loading'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.requireData;

                return ListView.builder(
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    // print("Order :${ data.docs[index].get('order')['totalprice'].runtimeType}");
                    // final docId= data.docs[index]['docId'];
                    // dynamic dataa=data.docs[index]['order'];
                    // print('Here ${dataa}');

                    //****another Widget to build order
                    // return Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     width: double.infinity,
                    //      height: 150,
                    //     decoration: BoxDecoration(
                    //       color: Colors.orangeAccent[100]
                    //     ),
                    //     child:Column(
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: [
                    //         Text('TotalPrice : ${data.docs[index]['order']['totalprice']}'),
                    //         Row(children: [
                    //           Text(
                    //
                    //             'Order : ${data.docs[index]['order']['orderlist'][index]['ProductName'] }'
                    //             ,
                    //             style: TextStyle(
                    //                 fontSize: 28
                    //             ),
                    //
                    //
                    //
                    //           ),
                    //          const  SizedBox(width: 10,),
                    //           Text(
                    //
                    //             '${data.docs[index]['order']['orderlist'][index]['Quantity']} '
                    //             ,
                    //             style: TextStyle(
                    //                 fontSize: 28
                    //             ),
                    //
                    //
                    //
                    //           ),
                    //         ]),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // );
                    return OrderCard(
                      Color2: data.docs[index]['color'],
                      cRef3: cref3,
                      product: data.docs[index]['order']['orderlist'],
                      total: data.docs[index]['order']['Totalprice'],
                      name: data.docs[index]['order']['Name'],
                      address: data.docs[index]['order']['Address'],
                      phone: data.docs[index]['order']['Phone'],
                      deleteRef: deleteRef,
                      time: data.docs[index]['order']['Time'],
                      OrderId: data.docs[index]['order']['OrderId'],
                      payment: data.docs[index]['order']['Payment'],
                      rewardPoints: data.docs[index]['order']
                      ['RewardPoints'],
                      userId: data.docs[index]['order']['UserID'],
                      UserPoints: data.docs[index]['order']['UserPoints'],
                      PtsTotalPrice: data.docs[index]['order']
                      ['PtsTotalPrice'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  OrderCard({
    Key? key,
    required this.product,
    this.total,
    this.name,
    this.address,
    this.phone,
    required this.deleteRef, this.payment, this.rewardPoints, this.userId, this.OrderId, this.UserPoints, this.TotalAfterReward, this.PtsTotalPrice, required this.cRef3, this.time, required this.Color2,
  }) : super(key: key);

  final List<dynamic> product;
  final dynamic total;
  final dynamic name;
  final dynamic address;
  final dynamic phone;
  final CollectionReference deleteRef;
  var colr = true;
  var Colore = Colors.white;
  final dynamic payment;
  final dynamic rewardPoints;
  final dynamic userId;
  final dynamic OrderId;
  final dynamic UserPoints;
  final dynamic TotalAfterReward;
  final dynamic PtsTotalPrice;
  final CollectionReference cRef3;
  final String Color2;
  final dynamic time;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: UpdateColoe(widget.Color2),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${widget.time}',textAlign: TextAlign.end,style: TextStyle(color: Colors.red)),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.product.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(
                'Product :   ${widget.product[index]['ProductName']}',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600,fontFamily: 'poppins'),
              ),
              subtitle: Text(
                'Quantity :   ${widget.product[index]['Quantity']}',
                style: const TextStyle(fontSize: 16),
              ),

            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Total Price (L.E) :   ${widget.total}',
              style: TextStyle(fontSize: 18 , fontFamily: 'poppins'),
            ),
          ),

          Divider(),
          ListTile(
            title: Text(
            'USER NAME :   ${widget.name}',
            style: TextStyle(fontSize: 18,fontFamily: 'poppins'),
              ),
          ),


          Divider(),
          ListTile(
            title: Text(
              'ADDRESS :   ${widget.address}',
              style: TextStyle(fontSize: 18,fontFamily: 'poppins'),
            ),
          ),

          Divider(),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: widget.product.length,
          //   itemBuilder: (context, index) {
          //     // Skip the first product since it's already displayed above
          //     if (index == 0) return Container();
          //
          //     //return ListTile(
          //       //title: Text('Quantity: ${widget.product[index]['Quantity']}'),
          //     //);
          //   },
          // ),
          Divider(),
          ListTile(
            title:
                Text('PHONE :   ${widget.phone}',
                  style: TextStyle(
                      fontSize: 18,fontFamily: 'poppins'),),

          ),
          Divider(),
          Text.rich(
            TextSpan(
                text: 'Payment : ' ,
                style: TextStyle(
                    fontSize: 18,fontFamily: 'poppins'),
                children: [
                  TextSpan(
                    text: '${widget.payment}',
                    style: buildTextStyle(widget.payment),
                  ),
                ]),
          ),
          Divider(),
          ListTile(
            title:
            Text('Reward Points  :   ${widget.rewardPoints}',
              style: TextStyle(
                  fontSize: 18,fontFamily: 'poppins'),),

          ),
          Divider(),
          ListTile(
            title:
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(' حاله الطلب ',
                  style: TextStyle(
                      fontSize: 18,fontFamily: 'alexandria'),),
                Switch(
                  value: widget.colr,
                  onChanged: (value) {
                    setState(() {
                      widget.colr = value;
                      if (widget.Colore == Colors.white) {
                        widget.Colore = Colors.black54;
                      } else {
                        widget.Colore = Colors.white;
                      }
                    });
                  },
                ),


              ],
            ),

          ),
          Divider(),
          ElevatedButton(
              onPressed: ()async {
                if (widget.payment == 'Cash') {
                  await widget.cRef3.doc(widget.userId).update({
                    'points': updatePoinstCash(userPoints: widget.UserPoints,rewardpoints: widget.rewardPoints)
                  });
                  Get.snackbar('udated','points');
                }
                if (widget.payment == 'Points') {
                  widget.cRef3.doc(widget.userId).update({
                    'points': updtePoinstPoints(rewardpoints: widget.rewardPoints,userPoints: widget.UserPoints,Totalptsprice: widget.PtsTotalPrice)
                  });
                  Get.snackbar('udated','points');
                }
              },
              child: const Text('Add Reward')),
          ElevatedButton(
              onPressed: ()async {
                // widget.deleteRef.doc(widget.OrderId).update({
                //   'OrderStatue': Colors.yellow
                // });
                widget.deleteRef.doc(widget.OrderId).update({
                  'color': 'Yellow'
                });
              },
              child: const Text('Yellow')),
          ElevatedButton(
              onPressed: ()async {
                widget.deleteRef.doc(widget.OrderId).update({
                  'color': 'Green'
                });
              },
              child: const Text('Green')),
          ElevatedButton(
              onPressed: ()async {
                widget.deleteRef.doc(widget.OrderId).update({
                  'color': 'Red'
                });
              },
              child: const Text('Red')),
          ElevatedButton(
              onPressed: ()async {
                widget.deleteRef.doc(widget.OrderId).update({
                  'color': 'White',
                });
              },
              child: const Text('White')),

        ],
      ),
    );
  }

  dynamic buildTextStyle(paymentstatue ) {
    if(paymentstatue=='Cash'){
      return TextStyle(
          color: Colors.green,
          fontSize: 18,fontFamily: 'poppins');
    }
    if(paymentstatue=='Points'){
      return TextStyle(
          color: Colors.yellow,
          fontSize: 18,fontFamily: 'poppins');
    }
  }
  int updatePoinstCash({userPoints, rewardpoints}) {
    int sum = userPoints + rewardpoints;
    return sum;
  }
  int updtePoinstPoints({userPoints, rewardpoints, Totalptsprice}){
    int sum=((userPoints-Totalptsprice) + rewardpoints );
    return sum;
  }
  dynamic UpdateColoe(colorsatue){
    if(colorsatue=='Yellow'){
      return Colors.yellow;
    }
    if(colorsatue=='Green'){
      return Colors.green;
    }
    if(colorsatue=='Red'){
      return Colors.red;
    }
    if(colorsatue=='White'){
      return Colors.white;
    }

  }
}

// void main() {
//   runApp(MaterialApp(
//     home: OrdersPage(
//       productStream: Stream.empty(),
//       BranchName: 'Branch',
//       cRef: FirebaseFirestore.instance.collection('collection'),
//       streamBranchOrders: Stream.empty(),
//       deleteRef: FirebaseFirestore.instance.collection('deleteCollection'),
//     ),
//   ));
// }
