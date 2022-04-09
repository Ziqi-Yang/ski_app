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
  "average_speed": 3,
  "max_slope": 48,
  "max_swivel": 185,
  "swivel_num": 4,
  "instant_speed": {
    "distance": [300, 600, 900, 1200, 1500, 1800],
    "speed": [18.4, 30.1, 41.2, 81.0, 55.2, 61.3]
  },
  "skeleton_gif_url": "https://i0.wp.com/www.printmag.com/wp-content/uploads/2021/02/4cbe8d_f1ed2800a49649848102c68fc5a66e53mv2.gif?fit=476%2C280&ssl=1"
}
```

| **字段**           | **类型**    | **备注**  |
|------------------|-----------|---------|
| start_time       | string    | NonNull |
| end_time         | string    | NonNull |
| last_time        | string    | NonNull |
| score            | int       | NonNull |
| average_speed    | int       | NonNull |
| max_slope        | int       | NonNull |
| max_swivel       | int       | NonNull |
| swivel_num       | int       | NonNull |
| instant_speed    | dict      | NonNull |
| distance         | list<int> | NonNull |
| speed            | list<int> | NonNull |
| skeleton_gif_url | string    | NonNull |