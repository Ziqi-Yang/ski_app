# 闪动滑雪

## Current Work

## Test Notice

1. 在`获取数据`(目前是`首页`)页面, 测试使用的`api`没有生成随机数据,需要手动修改服务端`latest_data`才能显示所有效果

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

- [ ] 登陆界面交互
- [ ] 将 `http` 库换成 `dio` 库
- [ ] 历史数据界面加上加上添加/显示收藏
- [ ] 添加检测更新功能
- [ ] 更换加载特效(如使用滑雪的人的gif而不是使用) https://github.com/LaoMengFlutter/flutter-do
- [ ] shopping page 把Swiper放在滑动列表里(此处由于商品少，可以考虑shrinkwrap?)
- [ ] shopping page 点击商品跳转(在跳转前先显示正在加载)时候判断用户是否安装淘宝(判断打开链接失败)，未安装则提示安装
- [ ] shopping page 使用微光加载特效(`shimmer`)
- [ ] community page 里面的 tweet widget 加上点击图片放大的插件
- [ ] community page 使用 websocket 接口
- [ ] data analysis 的 环形记录指示器 自定义 进度条首尾添加Icon组件(现在发现`syncfushion`有自定义组件的的这)
- [ ] data analysis 的 circular indicator 中间 添加水波浪效果
- [ ] 将有需要的地方使用cached_network_image, 比如setting page
- [ ] 美化字体
- [ ] 将商店页面由webview改为flutter内置

## Known issues

- [x] Setting Page 里没有对get不存在的用户数据 讨论
  
- [ ] community_page 使用 `scrollable_positioned_list` 插件,
  导致 `customScrollView`或者`NestedScrollView` 顶部的 SliverAppBar无法float
- [ ] 断网后没获取到数据应该要重新尝试获取数据
- setting page 升级模块问题, 但不影响使用
    - [ ] `setState() Called After Dispose()`
    - [ ] 有些时候没下载也会print出connect error的错误, 或许是`r_upgrade`插件的问题


## 需求

### 图片

1. [x] splash screen
   requirement:
> It must be a png file and should be sized for 4x pixel density.

example:
![](./assets/splash_test.png)

[演示](https://pub.dev/packages/flutter_native_splash)

2. [x] App Icon 
   > low:medium:high:extra-high:extra-extra-high=3:4:6:8:12
   
需要 `36x36`, `48x48`, `72x72`, `96x96`, `144x144` 比例的`png`图片

顺便也提供下透明背景的其他地方有用
