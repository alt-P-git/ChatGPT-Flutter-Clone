import 'dart:async';

class ResponseService {
  final StreamController<String> _responseStreamController =
  StreamController<String>();

  Stream<String> get responseStream => _responseStreamController.stream;

  void simulateResponse() async {
    final response = "This is a dummy response sent word by word.";
    final words = response.split(' ');

    for (var word in words) {
      await Future.delayed(const Duration(milliseconds: 500));
      _responseStreamController.add(word);
    }
  }

  void dispose() {
    _responseStreamController.close();
  }
}
