import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/util/common/custom_button.dart';
import 'package:mmeasyInvoice/ui/widget/all_delivery_widget.dart';
import 'package:mmeasyInvoice/data/response/all_product_response.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_produc_cubit.dart';
import 'package:mmeasyInvoice/state/get/cubit/fetch_all_product_state.dart';




class AllProductWidget extends StatefulWidget {
  const AllProductWidget({super.key});

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  String utype = '';
  List<ProductListItem>? productList;

  @override
  void initState() {
    super.initState();
    fetchUserType();
  }

  Future<void> fetchUserType() async {
    final userType = await SharePreferenceService().getUserRole();
    setState(() {
      utype = userType ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildDynamicButton('Add Product', () {}),
        Expanded(
          child: BlocBuilder<FetchingProductCubit, FetchingProductState>(
            builder: (context, state) {
              if (state is FetchingProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchingProductSuccess) {
                productList = state.productListItem;

                // if (products.isEmpty) {
                //   return const Center(
                //     child: Text("No Product Data found."),
                //   );
                // }

                //   return BlocConsumer<DeleteProductItemCubit, DeleteProductItemState>(
                //     builder: (context, deleteState) {
                //       bool loading = deleteState is DeleteProductItemLoading;

                //       return AllProductWidget(isLoading: loading, products: state.products,);
                //     },
                //     listener: (context, deleteState) {
                //       if (deleteState is DeleteProductItemSuccess) {
                //         showToastMessage('Deleted Product successful.');
                //         BlocProvider.of<GetAllProductCubit>(context)
                //             .getAllProduct();
                //       } else if (deleteState is DeleteProductItemFail) {
                //         showToastMessage(
                //             'Failed to delete product: ${deleteState.error}');
                //       }
                //     },
                //   );
                //

                return ListView.builder(
                  itemCount: productList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productList?[index];
                    return Card(
                      semanticContainer:
                          true, // Set to true to make it a semantic container
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      color: Colors.white,
                      elevation: 5,
                      child: InkWell(
                        onTap: () async {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              product?.url != null
                                  ? Image.network(
                                      product!.url!,
                                      width: 80.0,
                                      height: 80.0,
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Icon(
                                      Icons.production_quantity_limits_outlined,
                                      color: Colors.grey.shade300,
                                      size: 80.0,
                                    ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Product name: ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors
                                                  .black, // Color for "Product name: "
                                            ),
                                          ),
                                          TextSpan(
                                            text: product?.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue
                                                  .shade900, // Color for the dynamic product name
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(
                                        text: 'Category Id: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Color for "Product name: "
                                        ),
                                      ),
                                      TextSpan(
                                        text: product?.category_id.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue
                                              .shade900, // Color for the dynamic product name
                                        ),
                                      ),
                                    ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(
                                        text: 'Stock: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Color for "Product name: "
                                        ),
                                      ),
                                      TextSpan(
                                        text: product?.stock_status.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue
                                              .shade900, // Color for the dynamic product name
                                        ),
                                      ),
                                    ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(
                                        text: 'Product Id: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Color for "Product name: "
                                        ),
                                      ),
                                      TextSpan(
                                        text: product?.id.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue
                                              .shade900, // Color for the dynamic product name
                                        ),
                                      ),
                                    ])),
                                  ],
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        'Date: ${product?.created_at.substring(0, 10)},'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Center(
                                      child: (utype == 'ADM')
                                          ? CustomButton(
                                              label: 'View Detail Product',
                                              onPressed: () {},
                                            )
                                          : null,
                                    ),
                                  ])
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox(); // Handle other states if needed
              }
            },
          ),
        ),
      ],
    );
  }
}
