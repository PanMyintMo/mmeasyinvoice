import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/auth_module.dart';
import 'package:mmeasyInvoice/auth/auth_route.dart';
import 'package:mmeasyInvoice/data/response/company_profile_response.dart';
import 'package:mmeasyInvoice/ui/widget/get_image_widget.dart';
import 'package:mmeasyInvoice/ui/widget/profile_menu_widget.dart';
import 'package:mmeasyInvoice/ui/widget/show_custom_dialog.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';

class CompanyProfileWidget extends StatefulWidget {
  final CompanyProfileResponse companyProfileResponse;

  const CompanyProfileWidget({
    super.key,
    required this.companyProfileResponse,
  });

  @override
  State<CompanyProfileWidget> createState() => _CompanyProfileWidgetState();
}

class _CompanyProfileWidgetState extends State<CompanyProfileWidget> {
  File? image;
  void _updateImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 200,
              alignment: Alignment.center,
              child: GetImageWidget(
                  imageUrl: widget.companyProfileResponse.image,
                  onImageChanged: _updateImage),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.black38),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuWidget(
              title: "Settings",
              icon: LineAwesomeIcons.cog,
              iconColor: Colors.redAccent,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "Billing Details",
              icon: LineAwesomeIcons.wallet,
              iconColor: Colors.redAccent,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "User Management",
              icon: LineAwesomeIcons.user_check,
              iconColor: Colors.redAccent,
              onPress: () {},
            ),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuWidget(
              title: "Information",
              icon: LineAwesomeIcons.info,
              iconColor: Colors.redAccent,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "Logout",
              icon: LineAwesomeIcons.alternate_sign_out,
              iconColor: Colors.red,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                showCustomDialog(
                  title: 'Log out of your account? ',
                  content: 'Are you sure you want to logout',
                  confirmText: 'Yes',
                  onConfirm: () async {
                    SharePreferenceService().removeToken();
                    AppRouter.changeRoute<AuthModule>(AuthRoutes.root);
                  },
                  context: context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
