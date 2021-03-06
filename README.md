# 闪动滑雪

**前期开发不到位，有些界面设计也不满意，不打算填坑了，暂停开发此项目，将重新设计，新的仓库为[ski app re](https://github.com/Ziqi-Yang/ski_app_re)**

## Current Work

## Notice

1. 本仓库中的接口文档已转移, [位置](https://gitee.com/zarkliazrael/ski_app_docs/tree/master), gitee私有仓库

## TODO

- [x] 添加splash screen
- [x] Setting页面
- [x] SliverAppBar
- [x] 商店页面用webview暂时开发下
- [x] fetch_data_page 定时器自动获取数据
- [x] 为 setting 上半user profile区域设置图片
- [x] 将商店页面由网页展示改为类似京东界面,只不过点击控件跳转到京东app
- [x] tweet details 页面需要加上显示他人的评论
- [x] 实现登陆页面UI
- [x] 历史数据(滑雪记录)页面重新开发
- [x] 修改 splash screen 图片
- [x] 添加检测更新功能
- [x] 历史数据界面加上加上添加/显示收藏
- [x] shopping page 和 community 使用微光加载特效(`shimmer`)
- [x] data details 界面视频播放器修改
- [x] shopping page 把Swiper放在滑动列表里
- [x] shopping page 点击商品跳转(在跳转前先显示正在加载)时候判断用户是否安装淘宝(判断打开链接失败)，未安装则提示安装
- [x] community page 里面的 tweet widget 加上点击图片放大的插件
- [x] 将有需要的地方使用cached_network_image, 比如setting page

- [ ] 重新设计Setting Page, 应该只设置为一个头像(FlexibleArea)，下面是很多settings(setting 组件要重新设计)
- [ ] Community Page 里面的user profile 可以借鉴[这](https://www.youtube.com/watch?v=ZfSiFtT0z_I)
- [ ] 首页的开始滑雪Page与下面滑雪历史最好不要结合在一起,应该重新设计(比如说如果没有自动连接上可以展示历史数据，
自动连接上了就 动画切换到开始滑雪(单纯一个按钮(或者最多加个跳转到最近一天之内数据的界面)，可以开始也可以暂停，不同动画效果，如背景和水波纹变化), 然后点击
`scaffold`的返回按钮可以返回到历史滑雪)
- [ ] 登陆界面交互,头像 以及忘记密码界面
- [ ] 重新设置splash screen 适配 `android 12`
- [ ] 设置界面需要更加专注于设置
- [ ] 商店界面添加分类
- [ ] 为点赞按钮添加动效
- [ ] 图片放大界面仿twitter添加评论功能
- [ ] community page 使用 websocket 接口
- [ ] data analysis 的 环形记录指示器 自定义 进度条首尾添加Icon组件(现在发现`syncfushion`有自定义组件的的这)
- [ ] data analysis 的 circular indicator 中间 添加水波浪效果
- [ ] 美化字体

## wished feature

- [ ] `twitter` 查看大图的背景颜色是根据图片来生成的 (或者是服务端先处理好的)


## Known issues

- [x] Setting Page 里没有对get不存在的用户数据 讨论
  
- [ ] community_page 使用 `scrollable_positioned_list` 插件,
  导致 `customScrollView`或者`NestedScrollView` 顶部的 SliverAppBar无法随滑动消失
- [ ] 断网后没获取到数据应该要重新尝试获取数据(可以显示网络)
- setting page 升级模块问题, 但不影响使用
    - [ ] `setState() Called After Dispose()`
- [ ] setting page 有些时候会print出os connect error的错误, 但实际使用没影响
- [ ] 第一次 登陆帐号界面会print overflow, 但实际使用没影响
- [ ] 在`history`日历界面, 在有数据的事件格子，如果一直上拉，见到事件底部，可能会出现`Null check operator used on a null value`的错误，
但这个错误个人认为是插件问题, 并且对实际使用没有影响
- [ ] `history`日历界面, 数据加载后有几率数据页面出错（但点一下又好了）, 可能是测试数据过多导致


## 需求

### 图片

1. [x] splash screen
   requirement:
> It must be a png file and should be sized for 4x pixel density.

[example](./assets/splash_test.png) (占空间，点进去看)  
[演示](https://pub.dev/packages/flutter_native_splash)

2. [x] App Icon 
   > low:medium:high:extra-high:extra-extra-high=3:4:6:8:12
   
需要 `36x36`, `48x48`, `72x72`, `96x96`, `144x144` 比例的`png`图片

顺便也提供下透明背景的其他地方有用

## 开发状态

5.16 为了模仿twitter用户信息界面动画花了不少时间，然后还没模仿出来, 摆烂到网上找个其他的界面了 (╬ ಠ益ಠ)  

