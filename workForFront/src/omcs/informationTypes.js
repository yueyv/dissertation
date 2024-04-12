const informationTypes = {
  // 视频请求
  VideoRequest: 0,

  // 回复视频请求的结果
  VideoResult: 1,

  // 通知对方 挂断 视频连接
  CloseVideo: 2,

  // 通知好友 网络原因，导致 视频中断
  NetReasonCloseVideo: 3,

  // 通知对方(忙线中) 挂断 视频连接
  BusyLine: 4,

  // 远程桌面请求
  DesktopRequest: 5,

  // 回复远程桌面请求的结果
  DesktopResult: 6,

  // 主动取消远程桌面请求
  CancelDesktop: 7,

  // 对方（主人端）主动断开远程桌面
  OwnerCloseDesktop: 8,

  // 客人端断开远程桌面连接
  GuestCloseDesktop: 9,

  // 主动取消远程视频请求
  CancelVideo: 10
};

export default informationTypes;
