import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:out_of_stock/controller/database_controller.dart';
import 'package:out_of_stock/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:out_of_stock/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();
  DataBaseController dataBaseController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await dataBaseController.loadString(
          path: "assets/json/product_data.json");
      await dataBaseController.init();
      await dataBaseController.insertBulkRecord();
      await dataBaseController.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping App"),
      ),
      body: Obx(() => (dataBaseController.productFetchData.value.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06, vertical: size.width * 0.05),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: dataBaseController.productFetchData.length,
                    itemBuilder: (context, index) {
                      Product product =
                          dataBaseController.productFetchData[index];

                      return Container(
                        width: double.infinity,
                        // height: size.height * 0.17,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 2,
                                  spreadRadius: 0.3)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/image/placeholder.jpg"),
                                      fit: BoxFit.cover)),
                              child: Container(
                                width: size.width * 0.3,
                                height: size.width * 0.3,
                                decoration: BoxDecoration(

                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    base64Decode(product.image!),fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${product.name}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Row(
                                  children: [
                                    const Text("Quantity: ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    Text(
                                      "${product.quantity}",
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    if (dataBaseController.randomNumber.value ==
                                        index && dataBaseController.countDown.value >= 20) {
                                      dataBaseController.isAddToCart(true);
                                    }

                                    dataBaseController.addToCart(
                                        product: product, index: index);
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("Add To Cart",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                if (index ==
                                    dataBaseController.randomNumber.value) ...[
                                  Text(
                                    "Out Of Stock",
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                  SizedBox(width: 10),
                                  Obx(
                                    () => Text(
                                      "${dataBaseController.countDown.value}",
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ))
                ],
              ),
            )),
    );
  }
}
