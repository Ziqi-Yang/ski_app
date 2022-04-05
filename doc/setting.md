# 设置界面

## 接口说明

接口 `/setting/<username>`, 类型 `get`  
当用户还没登陆时请求 `setting/null`   

| 字段         | 类型     | 备注       |
|------------|--------|----------|
| error_code | int    | NonNull  |
| avatar     | String | Nullable |
| username   | String | Nullable |
| user_id    | String | Nullable |
| blog       | int    | Nullable |
| following  | int    | Nullable |
| followers  | int    | Nullable |
