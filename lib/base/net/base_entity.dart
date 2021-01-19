class BaseEntity<T> {
  int code;
  String message;
  T data;

  BaseEntity(this.code, this.message, this.data);

  // 请求是否成功
  bool get success => (code == 1 || code == 200);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json["code"] as int;
    message = json["message"] as String;
    data = json["data"];
  }
}
