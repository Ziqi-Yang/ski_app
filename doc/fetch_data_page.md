# 首页获取最新记录接口

`/history/latest/<userId>`

返回最新的滑雪数据

```json
{
  "data": ["13:47", "00:03:13", 88, 3.02],
  "id": "123"
}
```

`data`数据格式:

| 位置 | 类型     | 备注           |
|----|--------|--------------|
| 0  | String | NonNull 开始时间 |
| 1  | String | NonNull 持续时间 |
| 2  | int    | NonNull 分数   |
| 3  | int    | NonNull 平均配速 |

`id` 即为记录id, String ,NonNull