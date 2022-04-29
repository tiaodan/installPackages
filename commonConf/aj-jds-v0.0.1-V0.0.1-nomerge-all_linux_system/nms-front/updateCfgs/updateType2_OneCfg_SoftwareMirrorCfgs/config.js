const href = window.location.href;
/** ip配置*/
// 凯讯-小盒子环境
const ip_sun_vir = {
    backIP: "http://nmsIp:7300/api", // 入口ip
    mqttIP: "ws://nmsIp:8083/mqtt", // mqttip
    gisIP: "http://nmsIp:12001/roadmap/{z}/{x}/{y}.png"
};
//凯讯普通内网开发环境
const ip_sun = {
    backIP: "http://nmsIp:7300/api", // 入口ip
    mqttIP: "ws://nmsIp:8083/mqtt", // mqttip
    gisIP: "http://nmsIp:12001/roadmap/{z}/{x}/{y}.png" // 地图ip
};
//汉达环境
const ip_hd = {
    backIP: "http://nmsIp:7300/api", // 入口ip
    mqttIP: "ws://nmsIp:8083/mqtt", // mqttip
    gisIP: "http://nmsIp:12001/roadmap/{z}/{x}/{y}.png"
};

// 模块配置
const service_hd = {
    security: "", // 安全管理
    fault: "/eurekaAlarmServiceName", // 告警
    equipment: "/eurekaResourceServiceName", // 设备管理
    organization: "/eurekaOrganizationServiceName", // 组织架构
    statistic: "/eurekaStatisticServiceName", // 性能统计
    // statistic: "", // 性能统计-zy
    topology: "/aj03-topology-service", // 拓扑
    devConfig: "/aj03-devconfig-service", // 设备配置
    user: "/eurekaUserServiceName",
    gmapsystem: "/aj03-gmapsystem-service", //态势页面服务
    kubernetes: "/aj03-kubernetes-service", //编排管理
    presence: '/aj03-presence-service', // 呈现
    subnet: [
        "core-network", // 核心网00
        "access-network", // 接入网01
        "aa", //02保密安全
        "auxiliary-power-supply", // 辅助电源设备03
        "bb" // 运控系统04
    ],
    subsystem: [
        "frequency-conversion", // 变频
        "clock", // 时钟
        "antenna", // 天线
        "emergency", // 应急
        "antijam", // 抗干扰
        "general/provider-device", // 常规
        "trunked" // 集群
    ]
};
console.log(href);
if (href.indexOf("127.0.0.1") != -1) {
    // var ip = ip_hd;
    var ip = ip_sun;
    var service = service_hd;
} else if (href.indexOf("172.16") != -1) {
    var ip = ip_sun;
    var service = service_hd;
} else {
    var ip = ip_sun;
    var service = service_hd;
}
// mqtt配置
const topic = {
    gmapemergencySys: "sms-emergency", //态势页面应急短消息 2020-8-4-nxm
    gmapantijamSys: "sms-antijam", //态势页面抗干扰短消息 2020-8-4-nxm
    gmapsysTerminal: "terminal-info", //态势页面实时终端 2020-9-5-nxm
    gmapsysBeam: "beam-info", //态势页面实时波束 2020-9-5-nxm
    performance: "/analysize/#",
    fault: "front-service/alarm",
    deviceStatus: "front-0203/deviceStatus",
    // topology: ['alarm', 'device', 'hello'],
    equipment: "front-service/status",
    faultLine: "front-0203/linkStatus",
    event: "event",
    gmapevent: "event-info"
};
const mqttUser = {
    mqttUsername: "admin",
    mqttPassword: "public"
};

const ANTICOLOR = "red";
// 接入网管理
const ACCESSNET = "http://10.20.1.1:8080?t=";
// 服务器主备
const SERVER_TYPE = "主服务器";
// 定时器轮询告警列表时间间隔
const Topo_Interval = 30000;
const version = 'V8.1.5'