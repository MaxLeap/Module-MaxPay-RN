package com.maxleap.reactnative;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.maxleap.MLIapTransaction;
import com.maxleap.MLOrder;
import com.maxleap.MLPayManager;
import com.maxleap.MLPayParam;
import com.maxleap.PayCallback;
import com.maxleap.QueryOrderCallback;
import com.maxleap.exception.MLException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by SidneyXu on 2016/05/11.
 */
public class MLPayNativeModule extends ReactContextBaseJavaModule {

    private static final String LIBRARY_NAME = "MaxLeapPay";

    public MLPayNativeModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return LIBRARY_NAME;
    }

    private Map<String, String> convertMap(ReadableMap readableMap) {
        if (readableMap == null) return null;
        Map<String, String> map = new HashMap<String, String>();
        ReadableMapKeySetIterator iterator = readableMap.keySetIterator();
        while (iterator.hasNextKey()) {
            String key = iterator.nextKey();
            map.put(key, optString(readableMap, key));
        }
        return map;
    }

    private String optString(ReadableMap map, String key) {
        if (map.hasKey(key)) {
            return map.getString(key);
        }
        return null;
    }

    private int optInt(ReadableMap map, String key) {
        if (map.hasKey(key)) {
            return map.getInt(key);
        }
        return 0;
    }

    private ReadableMap optMap(ReadableMap map, String key) {
        if (map.hasKey(key)) {
            return map.getMap(key);
        }
        return null;
    }

    @ReactMethod
    public void startPayment(ReadableMap map, final Promise promise) {
        MLPayParam.Channel channel = mapChannel(map.getString("channel"));
        String subject = optString(map, "subject");
        String billNum = map.getString("billNo");
        int fee = map.getInt("totalFee");
        ReadableMap extraAttrs = optMap(map, "extraAttrs");
        Map<String, String> extras = convertMap(extraAttrs);

        MLPayParam payParam = new MLPayParam();
        payParam.setChannel(channel);
        payParam.setSubject(subject);
        payParam.setBillNum(billNum);
        payParam.setTotalFee(fee);
        payParam.setExtras(extras);
        MLPayManager.doPayInBackground(getCurrentActivity(),
                payParam, new PayCallback() {
                    @Override
                    public void done(String s, MLException e) {
                        if (e != null) {
                            promise.reject("" + e.getCode(), e.getMessage());
                        } else {
                            promise.resolve(s);
                        }
                    }
                });
    }

    @ReactMethod
    public void findOrder(ReadableMap map, final Promise promise) {
        String billNo = map.getString("billNo");
        MLPayManager.queryOrderInBackground(billNo, new QueryOrderCallback() {
            @Override
            public void done(List<MLOrder> list, MLException e) {
                if (e != null) {
                    promise.reject("" + e.getCode(), e.getMessage());
                } else {
                    promise.resolve("" + MLOrder.toJSONArray(list));
                }
            }
        });
    }

    private MLPayParam.Channel mapChannel(String ch) {
        if (ch == null) return null;
        if (MLIapTransaction.PaySource.ALIPAY_APP.get().equalsIgnoreCase(ch)) {
            return MLPayParam.Channel.ALIPAY_APP;
        } else if (MLIapTransaction.PaySource.UNIPAY_APP.get().equalsIgnoreCase(ch)) {
            return MLPayParam.Channel.UNION_APP;
        } else if (MLIapTransaction.PaySource.WECHAT_APP.get().equalsIgnoreCase(ch)) {
            return MLPayParam.Channel.WECHAT_APP;
        }
        return MLPayParam.Channel.AUTOMATIC;
    }
}
