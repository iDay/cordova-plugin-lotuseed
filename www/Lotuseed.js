/*  
    Javascript interface of Cordova plugin for Lotuseed Analytics SDK 
*/

var LotuseedPlugin = {

	// 触发自定义事件
    // eventId:    自定义事件的 eventId
    // eventLabel: 自定义事件的事件标签
    onEvent:function(eventId) {
        cordova.exec(null, null, "LotuseedAgent", "onEvent", [eventId]);
    },	
    
    // 触发自定义事件
    // eventId:    自定义事件的 eventId
    // eventLabel: 自定义事件的事件标签
    onEventWithLabel:function(eventId, eventLabel) {
        cordova.exec(null, null, "LotuseedAgent", "onEventWithLabel", [eventId, eventLabel]);
    },

    // 触发自定义事件
    // eventId:    自定义事件的 eventId
    // eventParams : 自定义事件的数据，Json 对象格式
    onEventWithParams:function(eventId, eventParams) {
        var eventDataJson = JSON.stringify(eventDict);
        cordova.exec(null, null, "LotuseedAgent", "onEventWithParams", [eventId, eventDataJson]);
    },

    // 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 onPageViewBegin 和 onPageViewEnd 接口了
    // pageName  : 页面自定义名称
    onPageView:function(pageName) {
        cordova.exec(null, null, "LotuseedAgent", "onPageView", [pageName]);
    },

    // 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageViewEnd 配合使用
    // pageName  : 页面自定义名称
    onPageViewBegin:function(pageName) {
        cordova.exec(null, null, "LotuseedAgent", "onPageViewBegin", [pageName]);
    },

    // 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageViewBegin 配合使用
    // pageName  : 页面自定义名称
    onPageViewEnd:function(pageName) {
        cordova.exec(null, null, "LotuseedAgent", "onPageViewEnd", [pageName]);
    },

    // 账号注册事件
    // accountId  : 账号ID
    onRegistration:function(accountId) {
        cordova.exec(null, null, "LotuseedAgent", "onRegistration", [accountId]);
    },

    // 账号登录事件
    // accountId  : 账号ID
    onLogin:function(accountId) {
        cordova.exec(null, null, "LotuseedAgent", "onLogin", [accountId]);
    },
    
    // 账号登出事件
    // accountId  : 账号ID
    onLogout:function(accountId) {
        cordova.exec(null, null, "LotuseedAgent", "onLogout", [accountId]);
    },

    // 订单事件
    // accountId  : 账号ID
    // orderId    : 订单ID
    // amount     : 订单数量
    onOrder:function(accountId, orderId, amount) {
        cordova.exec(null, null, "LotuseedAgent", "onOrder", [accountId, orderId, amount]);
    }
};

module.exports = LotuseedPlugin; 
