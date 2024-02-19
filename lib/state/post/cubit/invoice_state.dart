import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/invoice_response.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();
}

class InvoiceInitial extends InvoiceState {
  @override
  List<Object> get props => [];
}

class InvoiceLoading extends InvoiceState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InvoiceBarCodeScan extends InvoiceState {
  final  List<InvoiceData> response;

  const InvoiceBarCodeScan(this.response);

  @override
  List<Object?> get props => [response];
}


class BarcodeFail extends InvoiceState {
  final String error;

  const BarcodeFail(this.error);

  @override
  List<Object?> get props => [error];
}

//Invoice
class GenerateInvoice extends InvoiceState {
  final List<InvoiceData> _invoiceData;

  const GenerateInvoice(this._invoiceData);

  List<InvoiceData> get invoiceData => _invoiceData;

  @override
  List<Object?> get props => [_invoiceData];
}
