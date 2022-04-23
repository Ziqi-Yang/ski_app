# 社区模块

## 数据接口
接口地址`/community/tweets/`, `websocket`类型 (`userId`在请求包中传递)

返回List<Tweet>类型(类型说明见下方)

## 实现思路
仿`twitter`  


## Tweet 类型说明

示例:

```json
{
  "username": "列奥那多是勇者",
  "userId": "LeonardoZarkli",
  "avatar": "https://img3.sycdn.imooc.com/61c58ca10001966a09600960-140-140.jpg",
  "message": "This video will teach you all the relevant concepts you need to build a solid app with the clean architectural guidelines. You'll learn to use dependency injection with Dagger-Hilt, SOLID principles, CSV parsing with OpenCSV, working with remote APIs using Retrofit, local caching with Room, custom drawing on a canvas using Compose and much more. <br> What Should We <bold>Do</bold>?",
  "medias": {
    "pictures": ["https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png"],
    "videos": null
  },
  "retweet": 5,
  "fav": 10,
  "replyNum":  2,
  "verified": true,
  "hasRt":  false,
  "hasFav":  false
}
```

| **字段**   | **类型**       | **备注**   |
|----------|--------------|----------|
| username | String       | NonNull  |
| userId   | String       | NonNull  |
| avatar   | String       | NonNull  |
| message  | String       | NonNull  |
| pictures | List<String> | Nullable |
| videos   | List<String> | Nullable |
| retweet  | int          | NonNull  |
| fav      | int          | NonNull  |
| replyNum      | int          | NonNull  |
| verified | bool         | NonNull  |
| hasRt      | bool          | NonNull  |
| hasFav      | bool          | NonNull  |

