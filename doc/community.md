# 社区模块

## 数据接口
对于直接放userId在url中(不安全)的原因是`websocket`不能自定义请求头(参考[Websocket 能否自定义请求头](https://hgl2.com/2021/websocket-request-header/))  

> 为 WebSocket 做认证的常规方案是：服务端实现一个 ticket ，客户端在建立连接后，发送第一条信息时，在 URL 或 query string 中传递这个 ticket，服务端检查其是否有效。关于 WebSocket 安全相关的信息还可以查看[这篇文章](https://devcenter.heroku.com/articles/websocket-security)。

但是现在暂时不搞那么麻烦  

社区首页接口地址`/community/tweets/userId`, `websocket`类型 (`userId`在请求包中传递)  
回复的信息接口地址`/community/reply/messageId`, `websocket`类型 (`userId`在请求包中传递)  

返回List<Tweet>类型(类型说明见下方)

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

