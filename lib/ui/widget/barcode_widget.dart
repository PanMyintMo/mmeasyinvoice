import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/home_route.dart';
import 'package:mmeasyInvoice/util/common/data_source.dart';
import 'package:mmeasyInvoice/state/post/cubit/invoice_cubit.dart';
import 'package:mmeasyInvoice/data/response/invoice_response.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:mmeasyInvoice/util/common/build_data_column_widget.dart';
import 'package:mmeasyInvoice/util/common/validation/form_validator.dart';
import 'package:mmeasyInvoice/data/data_request_model/barcode_request_model.dart';

class BarcodeWidget extends StatefulWidget {
  final List<InvoiceData> invoice;
  const BarcodeWidget({super.key, required this.invoice});

  @override
  State<BarcodeWidget> createState() => _BarcodeWidgetState();
}

class _BarcodeWidgetState extends State<BarcodeWidget> {
  var productNo = TextEditingController();
  final Map<int, int> itemQuantities = {};
  int quantity = 0;

  Future<void> barcodeScanner() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(
          cancelButtonText: "Cancel",
          scanType: ScanType.barcode,
        ),
      ),
    );

    if (result != null) {
      String scannedBarcode = result.toString();
      setState(() {
        productNo.text = scannedBarcode;
      });
    }
  }

  void _handleSearch() {
    if (productNo.text.isNotEmpty) {
      context
          .read<InvoiceCubit>()
          .invoiceBarcode(ProductInvoiceRequest(barcode: productNo.text));

      productNo.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        actions: <Widget>[
          TextButton(
            onPressed: barcodeScanner,
            child: const Icon(
              Icons.qr_code_scanner,
              size: 24,
              weight: 50.0,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
             padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: widget.invoice.isNotEmpty
                        ? () async {
                            AppRouter.changeRoute<HomeModule>(HomeRoute.pdfPage);
                          }
                        : null,
                    child: const Text('Print'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: productNo,
                  validator: validateField,
                  onEditingComplete: _handleSearch,
                  decoration: InputDecoration(
                    labelText: 'Invoice Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                PaginatedDataTable(
                  columns: [
                    buildDataColumn('Product Name'),
                    buildDataColumn('Qty'),
                    buildDataColumn('Sale Price'),
                    buildDataColumn('Total'),
                  ],
                  source: DataSource<InvoiceData>(
                      data: widget.invoice,
                      buildRowWidgets: (invoice) => [
                            Text(invoice.id.toString()),
                            Text(invoice.product_name.toString()),
                            Text(invoice.sale_price.toString()),
                            Text(invoice.quantity.toString()),
                          ],
                      context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
