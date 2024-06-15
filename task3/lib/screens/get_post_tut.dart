// // // ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

// // Elbette, Dio ile GET ve POST istekleri göndermek, başlıkları yönetmek ve yanıt verilerini işlemek için bir örnek kod yazalım. Bu örnekte hem GET hem de POST isteklerinin nasıl yapılacağını, başlıkların nasıl ekleneceğini ve yanıt verilerinin nasıl işleneceğini göstereceğiz.
// // ### Adım 1: Dio Paketini Kurun
// // Öncelikle `dio` paketinin `pubspec.yaml` dosyanıza ekli olduğundan emin olun:
// // ```yaml
// // dependencies:
// //   dio: ^5.0.0
// // ```
// // ### Adım 2: Dio Kullanımı
// // Flutter uygulamanızda Dio'yu kullanarak GET ve POST istekleri yapma, başlıkları ekleme ve yanıt verilerini işleme örneği:
// // ```dart
// // import 'package:dio/dio.dart';
// // import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dio Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//   late Dio _dio;
//   String _getResponse = '';
//   String _postResponse = '';
//   @override
//   void initState() {
//     super.initState();
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://jsonplaceholder.typicode.com',
//         connectTimeout: 5000,
//         receiveTimeout: 3000,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
//         },
//       ),
//     );
//   }
//   Future<void> _sendGetRequest() async {
//     try {
//       final response = await _dio.get('/posts/1');
//       setState(() {
//         _getResponse = response.data.toString();
//       });
//     } on DioError catch (e) {
//       setState(() {
//         _getResponse = 'Failed to load data: ${e.message}';
//       });
//     }
//   }
//   Future<void> _sendPostRequest() async {
//     final data = {
//       'title': 'foo',
//       'body': 'bar',
//       'userId': 1,
//     };
//     try {
//       final response = await _dio.post('/posts', data: data);
//       setState(() {
//         _postResponse = response.data.toString();
//       });
//     } on DioError catch (e) {
//       setState(() {
//         _postResponse = 'Failed to post data: ${e.message}';
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dio Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _sendGetRequest,
//               child: const Text('Send GET Request'),
//             ),
//             const SizedBox(height: 20),
//             const Text('GET Response:'),
//             Text(_getResponse),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _sendPostRequest,
//               child: const Text('Send POST Request'),
//             ),
//             const SizedBox(height: 20),
//             const Text('POST Response:'),
//             Text(_postResponse),
//           ],
//         ),
//       ),
//     );
//   }
// // ### Açıklamalar:
// // 1. **Dio Başlatma:**
// //    - `Dio` nesnesi `BaseOptions` ile başlatılıyor. `baseUrl`, `connectTimeout`, `receiveTimeout` ve başlıklar (`headers`) burada tanımlanıyor.
// // 2. **GET İsteği:**
// //    - `_sendGetRequest` fonksiyonunda `dio.get` kullanılarak GET isteği yapılıyor.
// //    - Yanıt alındığında, yanıt verisi `_getResponse` değişkenine atanıyor ve ekranda gösteriliyor.
// //    - Hata durumunda hata mesajı `_getResponse` değişkenine atanıyor.
// // 3. **POST İsteği:**
// //    - `_sendPostRequest` fonksiyonunda `dio.post` kullanılarak POST isteği yapılıyor.
// //    - Gönderilecek veri `data` değişkeni içinde tanımlanıyor.
// //    - Yanıt alındığında, yanıt verisi `_postResponse` değişkenine atanıyor ve ekranda gösteriliyor.
// //    - Hata durumunda hata mesajı `_postResponse` değişkenine atanıyor.
// // 4. **Widget Yapısı:**
// //    - `MyHomePage` widget'ı, GET ve POST istekleri için iki düğme ve yanıtları göstermek için iki metin widget'ı içeriyor.
// // Bu örnek, Dio kullanarak GET ve POST isteklerini yapmayı, başlıkları eklemeyi ve yanıt verilerini işlemenin yanı sıra hata yönetimini de kapsayan kapsamlı bir uygulamadır.






// Elbette, Dio'nun interceptors, timeout ve otomatik yeniden deneme gibi özelliklerini kullanarak kapsamlı bir örnek oluşturalım. Bu örnekte aşağıdaki maddeleri ele alacağız:
// 1. **Interceptors ile Özel Mantık Ekleme (Örneğin, Authentication Token Ekleme)**
// 2. **Timeout Ayarları**
// 3. **Otomatik Yeniden Deneme ve Hata Yönetimi**
// ### Adım 1: Dio'yu Kurun
// Öncelikle `dio` paketinin `pubspec.yaml` dosyanıza ekli olduğundan emin olun:
// ```yaml
// dependencies:
//   dio: ^5.0.0
// ```
// ### Adım 2: Dio ve Interceptors Kullanımı
// Aşağıda Dio'nun interceptors, timeout ve otomatik yeniden deneme özelliklerini kullanarak detaylı bir örnek verilmiştir:
// ```dart
// import 'package:dio/dio.dart';
// class User {
//   int? id;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? avatar;
//   User({this.id, this.email, this.firstName, this.lastName, this.avatar});
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     email = json['email'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     avatar = json['avatar'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['email'] = email;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['avatar'] = avatar;
//     return data;
//   }
// }
// Future<void> postUser(User user) async {
//   final dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://yourapi.com', // API'nin temel URL'sini buraya ekleyin
//       connectTimeout: 5000, // Bağlantı zaman aşımı süresi (ms cinsinden)
//       receiveTimeout: 3000, // Yanıt alma zaman aşımı süresi (ms cinsinden)
//     ),
//   );
//   // Token Interceptor
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) {
//         // Burada isteğe token ekleniyor
//         options.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN';
//         return handler.next(options); // İsteği devam ettir
//       },
//       onResponse: (response, handler) {
//         // Yanıt işleme
//         return handler.next(response); // Yanıtı devam ettir
//       },
//       onError: (DioError e, handler) {
//         // Hata işleme
//         if (e.response?.statusCode == 401) {
//           // Yeniden deneme mantığını burada ekleyebilirsiniz
//           // Örneğin, token yenileme
//         }
//         return handler.next(e); // Hataları devam ettir
//       },
//     ),
//   );
//   // Retry Interceptor
//   dio.interceptors.add(
//     RetryInterceptor(
//       dio: dio,
//       retries: 3, // Yeniden deneme sayısı
//       retryDelays: [1000, 2000, 3000], // Yeniden deneme süreleri (ms cinsinden)
//     ),
//   );
//   try {
//     final response = await dio.post(
//       '/endpoint', // API endpoint'inizi buraya ekleyin
//       data: user.toJson(),
//     );
//     print('Response status: ${response.statusCode}');
//     print('Response data: ${response.data}');
//   } on DioError catch (e) {
//     if (e.response != null) {
//       print('Dio error!');
//       print('Status: ${e.response?.statusCode}');
//       print('Data: ${e.response?.data}');
//     } else {
//       // İstek gönderme problemi
//       print('Error sending request!');
//       print(e.message);
//     }
//   }
// }
// void main() {
//   User user = User(
//     id: 1,
//     email: 'test@example.com',
//     firstName: 'John',
//     lastName: 'Doe',
//     avatar: 'https://example.com/avatar.jpg',
//   );
//   postUser(user);
// }
// // RetryInterceptor sınıfını oluşturuyoruz
// class RetryInterceptor extends Interceptor {
//   final Dio dio;
//   final int retries;
//   final List<int> retryDelays;
//   RetryInterceptor({
//     required this.dio,
//     required this.retries,
//     required this.retryDelays,
//   });
//   @override
//   Future onError(DioError err, ErrorInterceptorHandler handler) async {
//     if (_shouldRetry(err)) {
//       for (var i = 0; i < retries; i++) {
//         try {
//           await Future.delayed(Duration(milliseconds: retryDelays[i]));
//           return handler.resolve(await _retry(err.requestOptions));
//         } catch (e) {
//           if (i == retries - 1) {
//             return handler.next(err);
//           }
//         }
//       }
//     }
//     return handler.next(err);
//   }
//   bool _shouldRetry(DioError err) {
//     // Yeniden deneme şartları
//     return err.type == DioErrorType.other || err.type == DioErrorType.response;
//   }
//   Future<Response> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return dio.request(
//       requestOptions.path,
//       options: options,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//     );
//   }
// }
// ```
// ### Açıklamalar:
// 1. **Interceptors ile Özel Mantık Ekleme:**
//    - `InterceptorsWrapper` kullanarak istek öncesinde `Authorization` başlığı ekliyoruz.
//    - Yanıt ve hata durumları için de `onResponse` ve `onError` metodları ile işlemler yapabiliyoruz.
// 2. **Timeout Ayarları:**
//    - `BaseOptions` ile `connectTimeout` ve `receiveTimeout` ayarları yapıyoruz.
// 3. **Otomatik Yeniden Deneme ve Hata Yönetimi:**
//    - `RetryInterceptor` sınıfı ile belirli koşullarda isteklerin yeniden denenmesini sağlıyoruz.
//    - `retries` ile yeniden deneme sayısını ve `retryDelays` ile yeniden deneme aralıklarını ayarlıyoruz.
// Bu örnek ile Dio kütüphanesinin sunduğu interceptors, timeout ve otomatik yeniden deneme gibi güçlü özellikleri kullanarak daha güvenli ve esnek API çağrıları gerçekleştirebilirsiniz.