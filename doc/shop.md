# 商店界面

数据示例:

```json
{
  "swiper": [
    {"cover":"https://m15.360buyimg.com/mobilecms/jfs/t1/200647/4/21861/48111/625deb78Ec3607f7f/a0976d4f30762973.jpg!cr_1125x449_0_166!q70.jpg",
      "link": null
    },
    {
      "cover":"https://m15.360buyimg.com/mobilecms/s1062x420_jfs/t1/199402/20/24156/134595/619cca36E2264ff49/3dad2037e4740483.jpg!cr_1053x420_4_0!q70.jpg",
      "link": "taobao://item.taobao.com/item.htm?id=582612625569"
    },
    {
      "cover":"https://m15.360buyimg.com/mobilecms/s1062x420_jfs/t1/157321/8/28031/403185/62158bdfe70a63830/b6c3b908a87ac21f.png!cr_1053x420_4_0!q70.jpg",
      "link": "https://www.baidu.com"
    }
  ],
  "itemList": [
    {
      "cover": "https://gw.alicdn.com/img/bao/uploaded/i4/i4/3894579939/O1CN01xEzrfz2NI7Fd8NXDu_!!2-item_pic.png_.webp",
      "description": "nobaday滑雪板单板装备",
      "details": "148cm | 153cm",
      "price": 2559.00,
      "externalLink": "taobao://item.taobao.com/item.htm?id=582612625569"
    },
    {
      "cover": "https://gw.alicdn.com/img/bao/uploaded/i4/i1/430784795/O1CN01ivrvGD1lI9rupcBz1_!!430784795.jpg_Q75.jpg_.webp",
      "description": "vamei滑雪单板套装flow快穿固定",
      "details": "153cm | 150cm",
      "price": 3100.00,
      "externalLink": "taobao://item.taobao.com/item.htm?id=624904687869"
    },
    {
      "cover": "https://gw.alicdn.com/img/bao/uploaded/i4/i1/7877/O1CN01Ws2Jpo283iWUbXsB6_!!7877.jpg_Q75.jpg_.webp",
      "description": "防水滑雪拖轮单板双板头盔雪靴包",
      "details": null,
      "price": 899.00,
      "externalLink": "taobao://item.taobao.com/item.htm?id=657561884972"
    },
    {
      "cover": "https://gw.alicdn.com/img/bao/uploaded/i4/i4/105682752/O1CN01FRztur1WCSgrExzQ3_!!105682752.jpg_Q75.jpg_.webp",
      "description": "杜邦考度拉面料 连体滑雪服",
      "details": "棉 | 中性 | 长款",
      "price": 1740.00,
      "externalLink": "taobao://item.taobao.com/item.htm?id=660341770151"
    },
    {
      "cover": "https://gw.alicdn.com/img/bao/uploaded/i4/i4/12977833/O1CN01qkdS0v27jZ6UwSTCx_!!12977833.jpg_Q75.jpg_.webp",
      "description": "nandn南恩防水黑白军绿色滑雪服",
      "details": null,
      "price": 698.00,
      "externalLink": "taobao://item.taobao.com/item.htm?id=580726566839"
    }
  ]
}
```

## 字段说明

| **字段**       | **类型** | **备注**   |
|--------------|--------|----------|
| swiper       | List   | NonNull  |
| cover        | String | NonNull  |
| link         | String | Nullable 商品淘宝链接，更改示例中的id即可|
| itemList     | List   |          |
| cover        | String | NonNull  |
| description  | String | NonNull  |
| details      | String | Nullable |
| price        | double | NonNull  |
| externalLink | String | NonNull 商品淘宝链接，更改示例中的id即可|