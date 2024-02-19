import 'package:bloc/bloc.dart';
import 'package:mmeasyInvoice/data/data_request_model/barcode_request_model.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/invoice_response.dart';
import 'package:mmeasyInvoice/state/post/cubit/invoice_state.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final AuthRepository _authRepository;
  InvoiceCubit(this._authRepository) : super(InvoiceInitial());

  Future<void> invoiceBarcode(ProductInvoiceRequest invoiceRequest) async {
    emit(InvoiceLoading());
    try {
      final data = invoiceRequest.toJson();
      logger.e("Barcode request model is $data");
      final response = await _authRepository.barcodeInvoice(data);
      final invoiceResponse = Invoice.fromJson(response);
      logger.e("Invoice response is $invoiceResponse");
      emit(InvoiceBarCodeScan(invoiceResponse.data!));
    } catch (error) {
      logger.e("Error is $error");
      emit(BarcodeFail(error.toString()));
    }
  }

//generate invoice
  Future<List<InvoiceData>?> invoice() async {
    emit(InvoiceLoading());

    try {
      final response = await _authRepository.invoice();
      //  logger.e("Request shopkeeper response is $response");
      final invoiceData = Invoice.fromJson(response).data;

      emit(GenerateInvoice(invoiceData!));

      return invoiceData;
    } catch (e) {
      emit(BarcodeFail(e.toString()));
      return null;
    }
  }
}
