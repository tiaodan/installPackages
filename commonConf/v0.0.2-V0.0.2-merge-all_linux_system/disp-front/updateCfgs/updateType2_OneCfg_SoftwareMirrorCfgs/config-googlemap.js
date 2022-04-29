/** ip配置*/
const href = window.location.href;
const version = "disp_login_show_version"; //登录页大版本号
const tipMessage = "V20220322"; //详细版本号
//凯讯普通内网开发环境
const ip_sun = {
    organizationIp: "https://dispIp:443/organizationIp", //  组织架构ip
    gisIp: "https://dispIp:443/gisIp", //gis ip
    // webscoket:'wss://dispIp:8090/webrtc',    //webscoket  //webscoket:'ws://dispIp:8090/webrtc',
    webscoket: "wss://dispIp:443/webrtc",
    password: "123456", //功能配置密码，可修改
    coordinate: [{
            city: "石家庄",
            maxZoom: 17,
            minZoom: 4,
            x: 114.53952,
            y: 38.03647,
            zoom: 9,
            value: "1"
        },
        {
            city: "北京",
            maxZoom: 18,
            minZoom: 6,
            x: 116.12,
            y: 39.54,
            zoom: 9,
            value: "2"
        }
    ], //该配置只用于增加城市，新增时增加一个花括号
    mdt: { encry: "53", unencry: "59" }, //mdt用户 限制发送短信字符数  不加密59   加密的53
    pdt: { encry: "20", unencry: "23" }, //pdt用户 限制发送短信字符数  加密20   不加密23
    general: "20", // 非mdt/pdt  比如离线 默认配置20
    groupMessage: "group_message_max_lenth", //组短信长度
    numberConfig: { numberLength: 8, numberComple: "phonePrefix" }, //号码取后几位 numberLength:5/8/11; 新建组时组号补位groupComple:6位/3位/0位;
    groupNameLeng: 8, //组名称限制8个字符
    groupMaxLength: 200, //配置群组规模上限
    isDongAo: is_dongAo, // 冬奥设置了不显示群组规模限制,true为冬奥版本，不显示群组规模限制，false为非冬奥版本，显示群组规模限制
    issyMap: is_enable_business_map, // 是否支持商用地图,true为支持，false为不支持
    GROUPNUM: 16, //电话本下发群组数目上限
    CONTACTNUM: 200, //电话本下发联系人数目上限
    SMSMAXLENGTH: 19 //新建短信限制19个字符
};
// 组织架构的token
const AUTHENTICATION =
    "18cb5343d0e75887793d5db2bd19729e649d19bf0c3c5d16e012d526644615a071255ba1505644d3aba1e3eb65ba6b1463ecae2cd86d5406ca181d5b8b66ac2a383d2eedc98823345c7581f984e1f06462114f706443fe36d572487287b8b2e29f9d1a54023c95456c8a406615454320ace3735a8757ee482833214dc11e47798245976042ed42e6a03aede720bda7f20d1624032fb3991a997bf8137db268fe2c251040eb041e841fc062c6b5543d87e9a8055f96d9cf18";

// 模块配置
const service_hd = {
    organization: "/v1/eurekaOrganizationServiceName", //本机组织架构
    user: "/v1/eurekaUserServiceName", //本机组织架构用户
    remoteUser: "/v1/eurekaUserServiceName", //远端组织架构用户
    location: {
        city: "石家庄",
        maxZoom: 18,
        minZoom: 8,
        x: 114.12,
        y: 38.54,
        zoom: 6
    } //gis地图默认显示城市，可做修改
};

if (href.indexOf("localhost") != -1) {
    var ip = ip_sun;
    var service = service_hd;
} else {
    var ip = ip_sun;
    var service = service_hd;
}
// module.exports = {ip};