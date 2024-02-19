import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/home_route.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Invoice"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TitleWidget(
                icon: Icons.picture_as_pdf,
                text: 'Generate Invoice',
              ),
              const SizedBox(height: 48),
              ButtonWidget(
                text: 'Invoice PDF',
                onClicked: () async {
                  AppRouter.changeRoute<HomeModule>(HomeRoute.productInvoice);
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TitleWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, size: 100, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
        ),
        onPressed: onClicked,
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
}
