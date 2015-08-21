package com.lotuseed.sdk;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;
import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.content.Context;

import com.lotuseed.android.Lotuseed;

public class LotuseedAgent extends CordovaPlugin {
	Activity act;
	Context ctx;
	String currPageName;
	
	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		this.act = cordova.getActivity();
		this.ctx = cordova.getActivity().getApplicationContext();
		Lotuseed.init(this.ctx);
	}
	
	@Override
	public void onResume(boolean multitasking) {
		super.onResume(multitasking);
		Lotuseed.onResume(act);
	}
	
	@Override
	public void onPause(boolean multitasking) {
		super.onPause(multitasking);
		Lotuseed.onPause(act);
	}
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("onEvent")) {
			String eventId = args.getString(0);
			Lotuseed.onEvent(eventId);
			return true;
		} else if (action.equals("onEventWithLabel")) {
    		// 触发带事件标签的自定义事件
			String eventId = args.getString(0);
			String eventLabel = args.getString(1);
			Lotuseed.onEvent(eventId, eventLabel);
			return true;
		} else if (action.equals("onEventWithParams")) {
    		// 触发带多事件属性的自定义事件
			String eventId = args.getString(0);
			String eventDataJson = args.getString(1);
			if (eventDataJson != null) {
				Map<String, String> eventData = this.toMap(eventDataJson);
				Lotuseed.onEvent(eventId, eventData);
			}
			return true;
		} else if (action.equals("onPageView")) {
			// 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 onPageViewBegin 和 onPageViewEnd 接口了
			String pageName = args.getString(0);
			// 如果上次记录的页面名称不为空，则本次触发为新页面，触发上一个页面的 onPageEnd
			if (currPageName != null) {
				Lotuseed.onPageViewEnd(currPageName);
			}
			// 继续触发本次页面的 onPageBegin 事件
			currPageName = pageName;
			Lotuseed.onPageViewBegin(currPageName);
			return true;
		} else if (action.equals("onPageViewBegin")) {
			// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 trackPageEnd 配合使用
			String pageName = args.getString(0);
			currPageName = pageName;
			Lotuseed.onPageViewBegin(currPageName);
			return true;
		} else if (action.equals("onPageViewBegin")) {
			// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 trackPageBegin 配合使用
			String pageName = args.getString(0);
			Lotuseed.onPageViewBegin(pageName);
			currPageName = null;
			return true;
		} else if (action.equals("onRegistration")) {
			// 账号注册事件
			String accountId = args.getString(0);
			Lotuseed.onRegistration(accountId);
			return true;
		} else if (action.equals("onLogin")) {
			// 账号登录事件
			String accountId = args.getString(0);
			Lotuseed.onLogin(accountId);
			return true;
		} else if (action.equals("onLogout")) {
			// 账号登出事件
			String accountId = args.getString(0);
			Lotuseed.onLogout(accountId);
			return true;
		} else if (action.equals("onOrder")) {
			// 订单事件
			String accountId = args.getString(0);
			String orderId = args.getString(1);
			String amount = args.getString(2);
			Lotuseed.onOrder(accountId, orderId, Double.parseDouble(amount));
			return true;
		} else if (action.equals("startWithAppKey")) {
			String appkey = args.getString(0);
			Lotuseed.startWithAppKey(appkey);
		}
		return false;
	}
	
	private Map<String, String> toMap(String jsonStr)
	{
		Map<String, String> result = new HashMap<String, String>();
		try {
			JSONObject jsonObj = new JSONObject(jsonStr);
			Iterator<String> keys = jsonObj.keys();
			String key = null;
			String value = null;
			while (keys.hasNext())
			{
				key = keys.next();
				value = (String)jsonObj.get(key);
				result.put(key, value);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return result;
	}
}
