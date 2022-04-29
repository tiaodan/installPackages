// 是否使用切图瓦片
const ISSUNMAP = false;
// 切图瓦片集名称
const GRIDSETNAME = "EPSG:3857_Sun Maps";
// 切图瓦片名称
const GRIDNAMES = [
    "EPSG:3857_Sun Maps:0",
    "EPSG:3857_Sun Maps:1",
    "EPSG:3857_Sun Maps:2",
    "EPSG:3857_Sun Maps:3",
    "EPSG:3857_Sun Maps:4",
    "EPSG:3857_Sun Maps:5",
    "EPSG:3857_Sun Maps:6",
    "EPSG:3857_Sun Maps:7",
    "EPSG:3857_Sun Maps:8",
    "EPSG:3857_Sun Maps:9",
    "EPSG:3857_Sun Maps:10",
    "EPSG:3857_Sun Maps:11",
    "EPSG:3857_Sun Maps:12",
    "EPSG:3857_Sun Maps:13",
    "EPSG:3857_Sun Maps:14"
];
// 切图地址
const BASEMAPURL = "http://120.2.0.199:8080/geowebcache/service/wmts";
// 切图图层名称
const MAPLAYERNAME = "Sun Maps";
// 分辨率
const MAPRESOLUTION = [
    1058.3354500042335,
    529.1677250021168,
    264.5838625010584,
    158.75031750063502,
    105.83354500042334,
    52.91677250021167,
    26.458386250105836,
    13.229193125052918,
    6.614596562526459,
    3.3072982812632294,
    1.5875031750063502,
    0.7937515875031751,
    0.39687579375158755,
    0.21166709000084669,
    0.13229193125052918
];
// 基本参数
const BASEMAPPARAMS = [
    "VERSION",
    "LAYER",
    "STYLE",
    "TILEMATRIX",
    "TILEMATRIXSET",
    "SERVICE",
    "FORMAT"
];
// 参数集
const MAPPARAMS = {
    VERSION: "1.0.0",
    LAYER: "Sun Maps",
    STYLE: "",
    TILEMATRIX: [
        "EPSG:3857_Sun Maps:0",
        "EPSG:3857_Sun Maps:1",
        "EPSG:3857_Sun Maps:2",
        "EPSG:3857_Sun Maps:3",
        "EPSG:3857_Sun Maps:4",
        "EPSG:3857_Sun Maps:5",
        "EPSG:3857_Sun Maps:6",
        "EPSG:3857_Sun Maps:7",
        "EPSG:3857_Sun Maps:8",
        "EPSG:3857_Sun Maps:9",
        "EPSG:3857_Sun Maps:10",
        "EPSG:3857_Sun Maps:11",
        "EPSG:3857_Sun Maps:12",
        "EPSG:3857_Sun Maps:13",
        "EPSG:3857_Sun Maps:14"
    ],
    TILEMATRIXSET: "EPSG:3857_Sun Maps",
    SERVICE: "WMTS",
    FORMAT: "image/png"
};
// 是否展示链路按钮
const ISLINESHOWCONFIG = is_show_line;
