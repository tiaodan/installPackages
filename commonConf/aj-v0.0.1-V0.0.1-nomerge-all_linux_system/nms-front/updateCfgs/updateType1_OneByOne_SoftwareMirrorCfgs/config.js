const href = window.location.href;
// ip配置
// // 709
const ip1 = {
    backIP: "http://nmsIp:security_port", // 入口ip
    userCenter: "http://nmsIp:usercenter_port", // 用户中心ip
    mqttIP: "ws://nmsIp:mqtt_manage_port/mqtt", // mqttip
    gisIP: "http://nmsIp:map_port/roadmap/{z}/{x}/{y}.png", // 地图ip
    btsGisIP: "http://nmsIp:usercenter_port/"
};
// 708
const ip2 = {
    backIP: "http://nmsIp:security_port", // 入口ip
    userCenter: "http://nmsIp:usercenter_port", // 用户中心ip
    mqttIP: "ws://nmsIp:mqtt_manage_port/mqtt", // mqttip
    gisIP: "http://nmsIp:map_port/roadmap/{z}/{x}/{y}.png", // 地图ip
    btsGisIP: "http://nmsIp:usercenter_port/"
};
// 现场
const ip3 = {
    backIP: "http://nmsIp:security_port", // 入口ip
    userCenter: "http://nmsIp:usercenter_port", // 用户中心ip
    mqttIP: "ws://nmsIp:mqtt_manage_port/mqtt", // mqttip
    gisIP: "http://nmsIp:map_port/roadmap/{z}/{x}/{y}.png", // 地图ip
    btsGisIP: "http://nmsIp:usercenter_port/"
};
// 模块配置
// 709环境
const service1 = {
    fault: "/v1/eurekaAlarmServiceNamee", // 告警
    equipment: "/v1/eurekaResourceServiceName", // 设备管理
    organization: "/v1/eurekaOrganizationServiceName", // 组织架构
    statistic: "/v1/nms-statistic-service", // 性能统计
    topology: "/v1/nms-topology-service", // 拓扑
    devConfig: "/v1/nms-devconfig-service", // 设备配置
    user: "/v1/nms-user-service",  // 用户管理
    userCenter: "/v1/nms-user-service" // 用户中心
};
// 现场版
const service2 = {
    fault: "/v1/eurekaAlarmServiceName", // 告警
    equipment: "/v1/eurekaResourceServiceName", // 设备管理
    organization: "/v1/eurekaOrganizationServiceName", // 组织架构
    statistic: "/v1/eurekaStatisticServiceName", // 性能统计
    topology: "/v1/eurekaTopologyServiceName", // 拓扑
    devConfig: "/v1/eurekaDevConfigServiceName", // 设备配置
    user: "/v1/eurekaUserServiceName",  // 用户管理
    userCenter: "/v1/eurekaUserCenterServiceName" // 用户中心
};

// mqtt配置
const topic = {
    performance: "/analysize/#",
    // 设备告警
    fault: "front-service/alarm",
    topology: ["alarm", "device", "hello"],
    // 设备状态
    equipment: "front-service/status",
    // 链路告警
    link: "front-service/link",
    // 基站序列号错误主题
    errorSerialNumber: "bts/deviceSn",
    // 用户导入成功主题
    userImportNum: '/user/import'

};
const lowerLevelLoginForm = {
    username: "nouser",
    password: "nochange"
};
btsFreObj = {
    pdtSend: 3580000,
    pdtReceive: 3480000,
    pdtStep: 125,
    mdtStep: 250,
    mdtSend: 3860125,
    mdtReceive: 3760125,
}

// 是否为数据中心
const Is_Data_Center = false;
// const Is_Data_Center = true;
// 拓扑页面轮询时间间隔（单位：毫秒）
const Topo_Interval = 50000000;
const oamPort = 6124;
// console.log((387.0375 * Math.pow(10, 4) - btsFreObj.mdtSend) / btsFreObj.mdtStep + 1)
if (href.indexOf("172.16") != -1) {
    var ip = ip1;
    var service = service2;
} else if (href.indexOf("192.1.1") != -1) {
    var ip = ip2;
    var service = service2;
} else {
    var ip = ip3;
    var service = service2;
}