import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/dependency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmeasyInvoice/ui/widget/invoice_widget.dart';
import 'package:mmeasyInvoice/util/common/toast_message.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mmeasyInvoice/data/response/invoice_response.dart';
import 'package:mmeasyInvoice/state/post/cubit/invoice_cubit.dart';
import 'package:mmeasyInvoice/state/post/cubit/invoice_state.dart';


class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<InvoiceData> invoice = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceCubit(getIt.call()),
      child: BlocConsumer<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceLoading) {
            EasyLoading.show(
              status: 'Loading...',
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is InvoiceBarCodeScan) {
            invoice = state.response;
            EasyLoading.dismiss();
          } else if (state is BarcodeFail) {
            final error = state.error;
            EasyLoading.dismiss();
            showToastMessage(error.toString());
          }
          return InvoiceWidget(invoices: invoice);
        },
        listener: (BuildContext context, InvoiceState state) {},
      ),
    );
  }
}
