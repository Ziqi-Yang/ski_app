# 历史数据

**文档需要修改**

## 接口说明

### 接口大略

默认`history/general/<username>`相当于`history/general/<username>/1`
加载新数据就修改最后的数字`1`即可

```json
{
  "data": {
    "2022-4-6": [
      ["13:47", "00:03:13", 88, 3.02],
      ["15:12", "00:05:13", 90, 5.02],
      ["17:24", "00:01:10", 50, 1.02]
    ],
    "2022-4-5": [
      ["13:47", "00:03:13", 88, 3.02],
      ["15:12", "00:05:13", 90, 5.02],
      ["17:24", "00:01:10", 50, 1.02]
    ]
  },
  "next": 2
}
```

"data" 包含10条历史数据的大体信息  
"next" 表示接下来的数字,类似于`history/<userId>/general/1`里的`1`, 若没有接下来的数据，则返回`null`

### 字段解释

| 参数   | 类型  | 备注       |
|------|-----|----------|
| next | int | Nullable |


对于`data` ->`2020-4-5` 内部的数据:

| 位置 | 类型     | 备注           |
|----|--------|--------------|
| 0  | String | NonNull 开始时间 |
| 1  | String | NonNull 持续时间 |
| 2  | int    | NonNull 分数   |
| 3  | int    | NonNull 平均配速 |

