const href = window.location.href;
/** ip配置*/
// 凯讯-小盒子环境
const ip_sun_vir = {
    backIP: "http://nmsIp:7300/api", // 入口ip
    mqttIP: "ws://nmsIp:8083/mqtt", // mqttip
    gisIP: "http://nmsIp:8098/roadmap/{z}/{x}/{y}.png"
};
//凯讯普通内网开发环境
const ip_sun = {
    // backIP: "http://172.16.0.39:7300/api", // 入口ip
    // backIP: "http://172.16.2.29:7215/api", // 入口ip

    backIP: "http://nmsIp:7300/api", // 入口ip
    // backIP: "http://nmsIp:7321/api", // 入口ip
    mqttIP: "ws://nmsIp:8083/mqtt", // mqttip
    gisIP: "http://nmsIp:7929/map/roadmap/{z}/{x}/{y}.png"
};
//汉达环境
const ip_hd = {
    backIP: "http://nmsIp:7300/api", // 入口ip
    mqttIP: "ws://nmsIp:8083/mqtt", // mqttip
    gisIP: "http://nmsIp:8898/map/roadmap/{z}/{x}/{y}.png"
};
const ip_02 = {
    backIP: "http://nmsIp:7300/api", // 入口ip
    mqttIP: "ws://nmsIp:8083/mqtt", // mqttip
    gisIP: "http://nmsIp:8898/map/roadmap/{z}/{x}/{y}.png"
};

/**内网配置-nxm-7-28 */
/**内网配置-nxm-9-8 */
const service_sun = {
    security: "", // 安全管理
    fault: "/0203-alarm-service", // 告警
    equipment: "/0203-resource-service", // 设备管理
    organization: "/0203-organization-service", // 组织架构
    statistic: "/0203-statistic-service", // 性能统计
    topology: "/0203-topology-service", // 拓扑
    devConfig: "/0203-devconfig-service", // 设备配置
    user: "/0203-user-service",
    gmapsystem: "/0203-gmapsystem-service", //态势页面服务
    // 汉达微服务
    // security: '/v1/security-service'
    subnet: [
        "core-network", // 核心网
        "access-network" // 接入网
    ],
    subsystem: [
        "radio-frequency", // 变频
        "clock", // 时钟
        "antenna", // 天线
        "emergency", // 应急
        "antijam", // 抗干扰
        "general/provider-deivce", // 常规
        "trunked" // 集群
    ]
};
// 模块配置
const service_hd = {
    security: "", // 安全管理
    fault: "/oss-alarm-service", // 告警
    equipment: "/oss-resource-service", // 设备管理
    organization: "/oss-organization-service", // 组织架构
    statistic: "/oss-statistic-service", // 性能统计
    topology: "/oss-topology-service", // 拓扑
    devConfig: "/oss-devconfig-service", // 设备配置
    user: "/oss-user-service",
    gmapsystem: "/oss-gmapsystem-service", //态势页面服务
    subnet: [
        "core-network", // 核心网00
        "access-network", // 接入网01
        "aa", //02保密安全
        "auxiliary-power-supply", // 辅助电源设备03
        "bb" // 站控系统04
    ],
    subsystem: [
        "frequency-conversion", // 变频
        "clock", // 时钟
        "antenna", // 天线
        "emergency", // 应急
        "antijam", // 抗干扰
        "general/provider-device", // 常规
        "trunked" // 集群
    ],
    property: "/oss-nms-ne-service",
    monitor: "/oss-monitor-service"
};
if (href.indexOf("localhost") != -1) {
    // var ip = ip_hd;
    var ip = ip_sun;
    var service = service_hd;
} else if (href.indexOf("172.16") != -1) {
    var ip = ip_sun;
    var service = service_hd;
} else if (href.indexOf("172.36") != -1) {
    var ip = ip_02;
    var service = service_hd;
} else {
    var ip = ip_hd;
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
    deviceStatus: "front-service/deviceStatus",
    // topology: ['alarm', 'device', 'hello'],
    equipment: "front-service/status",
    faultLine: "front-service/linkStatus",
    event: "event",
    gmapevent: "event-info"
};
const mqttUser = {
    mqttUsername: "admin",
    mqttPassword: "public"
};

const ANTICOLOR = "red";
// 接入网管理
const ACCESSNET = "http://nmsIp:7930?t=";
// 服务器主备
const SERVER_TYPE = "主服务器";
// 告警提示间隔
const WARNING_VOICE_TIME = 10000000;
// wms服务地址
const wmsUrl =
    "http://nmsIp:8090/iserver/services/map-china400/wms111/China?";
// const wmsUrl =
//     "http://172.16.0.155:8098/geowebcache/service/wmts?";
// wms图层名称
const wmsLayer = "China";
// const wmsLayer = "Sun Maps";
// 系统名称
const SYSTEMTITLE = "天通一号北京站站控系统";
// 设备管理页面接入网一、核心网一是否可点击
const ISINSERTONE = false;
// 设备管理页面接入网二、核心网二是否可点击
const ISINSERTTWO = true;
// 设备管理页面接入网三、核心网三是否可点击
const ISINSERTTHREE = true;
// 拒绝主备切换IP  本站为备站时，对端主站的地址
const MAINIP = "http://nmsIp";
// 拒绝主备切换IP  备站
const CASEIP = "http://10.26.24.219";
// 拒绝主备站端口   按照1、2、3接入网区分
//const CHANGEPORT = {
//    1: '8344',
//    2: '8354',
//    3: '8364',
//}
const CHANGEPORT = "7300";
// 拓扑页面是否可拖动
const DRAGABLE = false;
// 用户管理中心
// const USERCENTER = "http://nmsIp:7922";
const USERCENTER = "http://localhost:8082";

// 用户管理中心
// const USERCENTER = "http://nmsIp:7922";

// 机柜上设备的排列方法  机柜顶部为1：Positive；机柜顶部为42：Reverse
const SAMSUNGSORT = "Positive";
// 机柜排列计算公式
function SAMSUNGMETHOD(sort, y, imgheight) {
    // 机柜顶部为1
    if (sort == "Positive") {
        return 45 + 17 * (y - 1);
    } // 机柜顶部为42
    if (sort == "Reverse") {
        return 45 + 17 * (43 - y) - imgheight;
    }
}
// 机房中每一排机柜的数目
const CABINETNUM = 5;
// 手机号码正则校验 nxm-2020-8-21
function VALIDMOBILE(rule, value, callback) {
    console.log(value)
    console.log(!Number.isNaN(Number(value)))
    if (!Number.isNaN(Number(value))) {
        callback();
    } else {
        return callback(new Error("请输入正确的号码（号码应为数字格式）"));
    }
}
