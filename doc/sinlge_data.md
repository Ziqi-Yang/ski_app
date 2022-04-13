# 单独数据

地址`/data/<userId>/<dataId>`

## 接口说明

返回值范例

```json
{
  "start_time": "13:47",
  "end_time": "13:50",
  "last_time": "00:03",
  "score": 70,
  "average_speed": 3.0,
  "max_slope": 48.0,
  "max_swivel": 185.0,
  "swivel_num": 4,
  "instant_speed": {
    "distance": [300.0, 600.0, 900.0, 1200.0, 1500.0, 1800.0],
    "speed": [18.4, 30.1, 41.2, 81.0, 55.2, 61.3]
  },
  "action_compare_video_url": "https://dl.vibe.cn/assets/video/video-demo-full.mp4"
}
```

| **字段**           | **类型**    | **备注**  |
|------------------|-----------|---------|
| start_time       | string    | NonNull |
| end_time         | string    | NonNull |
| last_time        | string    | NonNull |
| score            | int       | NonNull |
| average_speed    | double       | NonNull |
| max_slope        | double       | NonNull |
| max_swivel       | double       | NonNull |
| swivel_num       | int       | NonNull |
| instant_speed    | dict      | NonNull |
| distance         | list<double> | NonNull |
| speed            | list<double> | NonNull |
| action_compare_video_url | string    | NonNull |
| comment | string    | NonNull |

备注: `double`类型最多保留一位小数