import 'package:http/http.dart' as http;

Future<http.Response> get( String url ) async {
    return await http.get( Uri.parse( url ) );
}

