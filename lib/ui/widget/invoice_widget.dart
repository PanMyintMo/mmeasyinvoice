import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mmeasyInvoice/ui/widget/printer_enum.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:mmeasyInvoice/data/response/invoice_response.dart';

class InvoiceWidget extends StatefulWidget {
  final List<InvoiceData> invoices;
  const InvoiceWidget({super.key, required this.invoices});

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  BlueThermalPrinter bluetoothPrint = BlueThermalPrinter.instance;

  bool _connected = false;
  List<BluetoothDevice>? _devices = [];
  BluetoothDevice? _device;
  String tips = 'No device connected';

  @override
  void initState() {
    super.initState();
    initBluetooth();
  }

  Future<void> initBluetooth() async {
    bool? isConnected = await bluetoothPrint.isConnected;

    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetoothPrint.getBondedDevices();
    } on PlatformException {
      // print("Platform error");
    }

    bluetoothPrint.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            tips = "Bluetooth device is connected";
          });
          break;

        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = "Bluetooth device is disconnected";
          });
          break;

        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            tips = "Bluetooth device disconnect requested";
          });
          break;

        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            tips = "Bluetooth device STATE_TURNING_OFF";
          });
          break;

        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            tips = "Bluetooth device Not Connected";
          });
          break;

        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            tips = "Bluetooth device Connect";
          });
          break;

        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            tips = "Bluetooth device STATE_TURNING_ON";
          });
          break;

        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            tips = "Bluetooth device error";
          });
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected == true) {
      setState(() {
        _connected = true;
      });
    }
  }

  Future<Uint8List> imagePathToUint8List(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List imageBytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return imageBytes;
  }

  Future<void> printText(List<InvoiceData> invoice) async {
    // print("invoiceList$invoice");
    try {
      await bluetoothPrint.connect(_device!);
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);

      List<int> bytes = [];

      final now = DateTime.now();
      final timestamp = DateFormat('dd/MM/yyyy h:mm:ss a').format(now);

      bluetoothPrint.printLeftRight("", timestamp.toString(), Size.bold.val,
          format: "%-15s %15s %n");

      bluetoothPrint.printNewLine();

      //for invoice profile
      try {
        final imageBytes =
            await imagePathToUint8List("assets/dailyNeedItem.png");
        await bluetoothPrint.printImageBytes(imageBytes);
        bluetoothPrint.printNewLine();
      } catch (e) {
        // print("Error printing image: $e");
      }

      bluetoothPrint.printCustom(
          "MMEasyInvoice", Size.boldMedium.val, Aligns.center.val);
      bluetoothPrint.printNewLine();

      bluetoothPrint.printCustom(
          "09798217582", Size.boldMedium.val, Aligns.center.val);
      bluetoothPrint.printNewLine();
      bluetoothPrint.print3Column(
          "Client Name", " ", "ITVisionHub Co.ltd;", Size.bold.val,
          format: "%-15s %10s %15s %n");
      //  await bluetoothPrint.printNewLine();
      bluetoothPrint.print3Column(
          "Sayar Yan Aung", " ", "ITVisionHub Co.ltd;", Size.bold.val,
          format: "%-15s  %10s %15s %n");
      await bluetoothPrint.printNewLine();

      bluetoothPrint.print4Column(
          "Product Name", "Price", "Quantity", "Total", Size.bold.val,
          format: "%-10s %10s %10s %10s %n");
      await bluetoothPrint.printNewLine();
      bytes.addAll(generator.text('-' * 48));
      for (var data in invoice) {
        bytes.addAll(formatInvoiceData(data, generator));
        bytes += generator.hr();
        generator.cut();
      }
      bytes.addAll(generator.text("Thank You Choosing Our Service!",
          styles: const PosStyles(align: PosAlign.center)));

      await bluetoothPrint.printNewLine();
      await bluetoothPrint.writeBytes(Uint8List.fromList(bytes));

      // Disconnecting from the printer
      await bluetoothPrint.disconnect();
    } catch (e) {
      //  print("Printing error: $e");
    }
  }

  List<int> formatInvoiceData(InvoiceData data, Generator generator) {
    List<int> bytes = [];

    String productInfo =
        "${data.product_name}, ${data.sale_price}, ${data.quantity}, ${data.total}";
    bytes.addAll(generator.text(productInfo,
        styles: const PosStyles(align: PosAlign.left)));

    return bytes;
  }

  Future<void> generateAndPrintPdf() async {
    try {
      final pdfDoc = pw.Document();
      pdfDoc.addPage(
        pw.MultiPage(
          build: (context) => [
            buildHeader(),
            buildInvoice(widget.invoices),
            pw.SizedBox(height: 100),
            pw.Divider(),
            pw.Align(
              alignment: pw.Alignment.bottomCenter,
              child: pw.Text("Thanks for choosing our service."),
            ),
          ],
        ),
      );
      final pdfAsUint8List = await pdfDoc.save();

      if (_connected) {
        await bluetoothPrint.connect(_device!);
        await bluetoothPrint.writeBytes(pdfAsUint8List);
        await bluetoothPrint.printNewLine();
        await bluetoothPrint.disconnect();
      }
    } catch (e) {
      // print("Printing error in pdf file $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices!.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices?.forEach((device) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(device.name ?? ""),
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device != null) {
      setState(() {
        tips = "Device is connected";
        _connected = true;
      });

      bluetoothPrint.isConnected.then((isConnected) {
        if (isConnected == true) {
          bluetoothPrint.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
        }
      });
    } else {}
  }

  void _disconnect() {
    bluetoothPrint.disconnect();
    setState(() => _connected = false);
  }
}

pw.Widget buildHeader() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text("Xiao Pan"),
          pw.Text("MyanmarEasyInvoice"),
        ],
      ),
      //   pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          // Add content for the customer address and invoice info as needed
        ],
      ),
    ],
  );
}

pw.Widget buildInvoice(List<InvoiceData> invoice) {
  final headers = ['Product name', 'Qty', 'Sale Price', 'Total'];
  final data = invoice.map((item) {
    return [
      '${item.product_name}',
      '${item.quantity}',
      '${item.sale_price}',
      '${item.total}'
    ];
  }).toList();

  return pw.Table.fromTextArray(
    data: data,
    headers: headers,
    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
    headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
    cellAlignments: {
      0: pw.Alignment.centerLeft,
      1: pw.Alignment.centerRight,
      2: pw.Alignment.centerRight,
      3: pw.Alignment.centerRight,
    },
  );
}
