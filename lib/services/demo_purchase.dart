import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/student_model.dart';
import 'package:todo_app/modules/components/input_text_field.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var colorController = TextEditingController();
  int price = 0;
  String itemTitle = '';
  List<dynamic> mainItems = [];
  insertIntoShoppingItems()async{
    await ShoppingDB.insertItemsToDB(titleController.text,price,selectedIndex,colorController.text);
  }
  // getItemsFromDB() async{
  //   List shoppingItems = await ShoppingDB.retrieveDataFromDB();
  //   setState(() {
  //     mainItems = ShoppingDB.items;
  //   });
  //   return shoppingItems;}

 getItemsFromDB() async{
    List shoppingItems = await ShoppingDB.retrieveDataFromDB();
    setState(() {
      mainItems = shoppingItems;
    });

  }
  getData()async{
    return await ShoppingDB.retrieveDataFromDB();
  }
  deleteMyData()async{
    int response = await ShoppingDB.deleteData();
    print('response: $response');
    // return response;
  }
  List<int> categories = [0,1,2,3,4];
  List<String> categoriesItem = ['sneakers','Jackets','shirts','pants','shorts'];
  int selectedIndex = 0;
  @override
  void initState() {
    // getItemsFromDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // getItemsFromDB();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
      ),
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputTextField(
                  controller:titleController,
                  title: 'Title',
                  hint: 'Type in your title',
                ),
                const SizedBox(height:8.0),
                InputTextField(
                  controller: colorController,
                  title: 'Color',
                  hint: 'color',
                ),

                Center(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            if(price >= 0){
                              price--;
                            }
                          });
                        },
                        child:const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.remove),
                        ),
                      ),
                      Text('$price', style:const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                      InkWell(
                        onTap:(){
                          setState(() {
                            if(price <= 20){
                              price++;
                            }
                          });
                        },
                        child:const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0,),

                ...List.generate(categories.length, (index) => GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Stack(alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        // width: 120,
                        margin: const EdgeInsets.only(right: 10.0),
                        height: 20,
                        // color: Colors.white,
                        child: Text(categoriesItem[index],style: TextStyle(color: selectedIndex == index ? Colors.black : Colors.grey[300]),),
                      ),
                      Container(
                        height: 1,width: 25,
                        color: selectedIndex == index ? Colors.black : Colors.white,
                        // child: Text('',style: TextStyle(color: Colors.blue),),
                      ),
                    ],
                  ),
                ),

                ),
                const SizedBox(height: 25.0,),

                InkWell(onTap: () async{
                  if(price != 0 && titleController.text.isNotEmpty){
                    await insertIntoShoppingItems();
                    setState(() {
                      titleController.clear();
                      colorController.clear();
                      price = 0;
                    });
                    await getItemsFromDB();

                  }
                },
                    child: Container(
                      width:140 ,height:30 ,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: const[
                          Icon(Icons.add,color: Colors.white,size: 30,),
                          SizedBox(width: 10.0,),
                          Text('Add item',style:TextStyle(color: Colors.white,fontSize: 18.0)),
                        ],
                      ),
                    )),
              const SizedBox(height: 25.0,),
                InkWell(onTap: () async{
                 //await ShoppingDB.deleteOurDatabase();
                },
                    child: Container(
                      width:200 ,height:40 ,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child:const Center(child: Text('Delete database',style:TextStyle(color: Colors.white,fontSize: 18.0))),

                    )),
              const SizedBox(height: 25.0,),

                FutureBuilder(
                    future: getData(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics:const  BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index)=>Dismissible(
                              key: Key((snapshot.data as List)[index].toString()),
                          //     confirmDismiss: (DismissDirection direction) async{
                          //
                          //       if(direction == DismissDirection.endToStart){ // left swipe
                          //         backg
                          //       }else  if(direction == DismissDirection.endToStart){ // left swipe
                          //         deleteMyData();
                          //       }
                          //       return await showDialog(context: context,
                          //       builder: (context) => AlertDialog(
                          //       title: const Text('confirm'),
                          //       content: const Text('Are you sure you wish to delete this?'),
                          //       actions: <Widget>[
                          //       MaterialButton(onPressed: () => Navigator.of(context).pop(true),
                          //       child: const Text('DELETE',style: TextStyle(color: Colors.white,fontSize: 18.0),),
                          //       color: Colors.deepPurple.withOpacity(0.6),
                          //
                          //       ),
                          //       MaterialButton(onPressed: () => Navigator.of(context).pop(false),
                          //       child: const Text('Cancel',style: TextStyle(color: Colors.black,fontSize: 18.0),),
                          //       color: Colors.white,
                          //
                          //       ),
                          //       ],
                          // ));
                          //
                          //   },
                              onDismissed: (direction){
                                  deleteMyData();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 15.0),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(color: Colors.black26,width: 1,),
                                      boxShadow: [BoxShadow(
                                          offset:const Offset(16,16),
                                          color: Colors.black12.withOpacity(0.1),
                                          blurRadius: 16
                                      )]

                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Title: ${(snapshot.data as List?)? [index]['title']}',style:const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),
                                      Text('Price: ${(snapshot.data as List?)? [index]['price']}',style:const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),
                                  //   Text('Category:  ${selectedCategory((snapshot.data as List?)? [index]['category'])}',style:const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.blue),),
                                      Text('Color:  "${(snapshot.data as List?)? [index]['color']}"',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: selectedColor((snapshot.data as List?)? [index]['color'])),),
                                     // Text(DateFormat.yMMMd().format((snapshot.data as List?)? [index]['date']),style:const TextStyle(fontSize: 18.0,color: Colors.black26),),
                                    ],
                                  )
                              ),
                            ),
                            separatorBuilder: (context,index) => const SizedBox(height: 15.0,),
                            itemCount: (snapshot.data as List).length);
                      }else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    })
                /**mainItems.isNotEmpty ? ListView.separated(
              scrollDirection: Axis.vertical,
                  physics:const  BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.black26,width: 1,),
                        boxShadow: [BoxShadow(
                            offset:const Offset(16,16),
                            color: Colors.black12.withOpacity(0.1),
                            blurRadius: 16
                        )]

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title: ${mainItems[index]['title']}',style:const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),
                        Text('Price: ${mainItems[index]['price']}',style:const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),

                      ],
                    )
                ),
            separatorBuilder: (context,index) => const SizedBox(height: 15.0,),
            itemCount: mainItems.length) : const Center(child: CircularProgressIndicator(),)
*/

        // InputTextField(
        //             controller:titleController,
        //             title: 'Title',
        //             hint: 'title',
        //           ),
              ],
            ),
          ),
        ),
      ),
    );

  }
  selectedCategory(int index){
    switch(index){
      case 0:
        return 'sneakers';
      case 1:
        return 'Jackets';
      case 2:
        return 'T-shirts';
      case 3:
        return 'pants';
      case 4:
        return 'shorts';
      default:
        return 'Clothes';
    }
  }
  selectedColor(String color){
    switch(color){
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blueAccent;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
  confirmDismiss(DismissDirection direction) async{
    return await showDialog(context: context,
        builder: (context) => AlertDialog(
          title: const Text('confirm'),
          content: const Text('Are you sure you wish to delete this?'),
          actions: <Widget>[
            MaterialButton(onPressed: () => Navigator.of(context).pop(true),
            child: const Text('DELETE',style: TextStyle(color: Colors.white,fontSize: 18.0),),
              color: Colors.deepPurple.withOpacity(0.6),

            ),
            MaterialButton(onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel',style: TextStyle(color: Colors.black,fontSize: 18.0),),
              color: Colors.white,

            ),
          ],
        ));
  }
}
// class Prices extends StatefulWidget {
//   const Prices({required this.price,Key? key}) : super(key: key);
//   int? price;
//   @override
//   State<Prices> createState() => _PricesState(price);
// }
//
// class _PricesState extends State<Prices> {
//   final int price;
//   _PricesState(this.price);
//
//   @override
//   void initState() => super.initState();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           onTap: (){
//             setState(() {
//               if(price >= 0){
//                 price--;
//               }
//             });
//           },
//           child:const CircleAvatar(
//             radius: 25,
//             child: Icon(Icons.remove),
//           ),
//         ),
//         Text('$price', style:const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
//         InkWell(
//           onTap:(){
//            setState(() {
//             if(price <= 20){
//             price++;
//             }
//            });
//           },
//           child:const CircleAvatar(
//             radius: 25,
//             child: Icon(Icons.remove),
//           ),
//         ),
//       ],
//     );
//   }
// }
