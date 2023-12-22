import 'dart:developer' as dev;

class Choreographer {
  static Map<String, Map<int, Function>> callbackMap = {};

  static void register(
    String event,
    Function callback,
  ) {
    if (callbackMap[event] == null) {
      callbackMap[event] = {};
    }

    dev.log(callback.hashCode.toString(), name: "Choreographer.register");

    callbackMap[event]?[callback.hashCode] = callback;
  }

  static void unregister(String event, Function callback) {
    if (callbackMap[event] == null) {
      return;
    }

    callbackMap[event]?.remove(callback.hashCode);
  }

  static void post(String event, dynamic data) {
    if (callbackMap[event] == null) {
      return;
    }

    callbackMap[event]?.forEach((id, callback) {
      callback(data);
    });
  }

  static void postAll(dynamic data) {
    callbackMap.forEach((event, callbacks) {
      callbacks.forEach((id, callback) {
        callback(data);
      });
    });
  }
}
