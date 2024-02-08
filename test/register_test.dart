// import 'package:flutter_test/flutter_test.dart';
// import 'package:mmEasyInvoice/data/datamodel/register_request_model.dart';
// import 'package:mmEasyInvoice/data/network/NetworkApiServices.dart';


// void main() {
//   final testApiServices = NetworkApiService();
//   // test('Test getGetApiResponse', () async {
//   //   final response =
//   //       await testApiServices.getGetApiResponse(AppUrl.loginEndPoint);

//   //   expect(response, isNotNull);
//   // });

//  test('Test PostApiResponse', () async {
//   final response = await testApiServices.getPostApiResponse(
//     'https://www.mmeasyinvoice.com/api/register',  
//     RegisterRequestModel(
//       name: 'Test',
//       email: 'test@gmail.com',
//       password: 'momyintPan@1',
//       password_confirmation: 'momyintPan@1',
//     ),
//   );
//   expect(response, isNotNull);
//   expect(response['status'], 'success');
//   expect(response['message'], 'User registered successfully');
// });

// }
