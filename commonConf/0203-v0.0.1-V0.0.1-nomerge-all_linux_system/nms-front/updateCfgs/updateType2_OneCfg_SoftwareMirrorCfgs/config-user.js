const href = window.location.href
    // ip配置
const ip_03 = {
    backIP: 'http://nmsIp:7300', // 入口ip
    // mqttIP: 'ws://192.168.100.20/mqtt', // mqttip
}
const ip_02 = {
        backIP: 'http://172.36.24.120:7300', // 入口ip
        // mqttIP: 'ws://10.20.4.200:8083/mqtt', // mqttip
    }
    // 模块配置
const service = {
        fault: '/v1/fh03-alarm-service', // 告警
        equipment: '/v1/fh03-resource-service', // 设备管理
        organization: '/api/oss-organization-service', // 组织架构
        statistic: '/v1/fh03-statistic-service', // 性能统计
        topology: '/v1/fh03-topology-service', // 拓扑
        devConfig: '/v1/fh03-devconfig-service', // 设备配置
        user: '/api/oss-user-service',
        // security: '/v1/security-service'
    }
    // mqtt配置
const topic = {
    performance: '/analysize/#',
    fault: 'front-service/alarm',
    topology: ['alarm', 'device', 'hello'],
    equipment: 'front-service/status',
}

if (href.indexOf('172.36') != -1) {
    var ip = ip_02
} else {
    var ip = ip_03
}
