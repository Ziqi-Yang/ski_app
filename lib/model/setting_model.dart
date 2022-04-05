// | 字段         | 类型     | 备注       |
// |------------|--------|----------|
// | error_code | int    | NonNull  |
// | avatar     | String | Nullable |
// | username   | String | Nullable |
// | user_id    | String | Nullable |
// | blog       | int    | Nullable |
// | following  | int    | Nullable |
// | followers  | int    | Nullable |


class SettingModel{
  final int errorCode;
  final String? avatar;
  final String? username;
  final String? userId;
  final int? blog;
  final int? following;
  final int? followers;

  SettingModel({required this.errorCode, this.avatar, this.username, this.userId,
      this.blog, this.following, this.followers});

  factory SettingModel.fromJson(Map<String, dynamic> json){
    return SettingModel(
        errorCode: json["error_code"],
      avatar: json["avatar"],
      username: json["username"],
      userId: json["user_id"],
      blog: json["blog"],
      following: json["following"],
      followers: json["followers"]
    );
  }
}