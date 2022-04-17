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

- [ ] 将商店页面由网页展示改为类似京东界面,只不过点击控件跳转到京东app
- [ ] data analysis 的 环形记录指示器 自定义 进度条首尾添加Icon组件(现在发现`syncfushion`有自定义组件的的这)
- [ ] data analysis 的 circular indicator 中间 添加水波浪效果
- [ ] 历史数据(滑雪记录)页面重新开发
- [ ] 修改 splash screen 图片
- [ ] 存储 user data
- [ ] 美化字体
- [ ] 将商店页面由webview改为flutter内置

## Knowing issues

- [x] Setting Page 里没有对get不存在的用户数据 讨论
  
- [ ] `community_page` 暂不能提前加载(根本是显示当前显示的元素的index),`scroll_positioned_list`库提供了
  这个功能，但是不能放在`CustomScrollView`里, 后期可能需要自己写
- [ ] 商店页面网页估计会自动跳转，然后导致出错，设置跳转规则