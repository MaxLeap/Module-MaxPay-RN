package com.demo;

import android.os.Bundle;

import com.facebook.react.ReactActivity;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.maxleap.MaxLeap;
import com.maxleap.TestUtils;
import com.maxleap.reactnative.MLPayReactPackage;

import java.util.Arrays;
import java.util.List;

public class MainActivity extends ReactActivity {

    private String APP_ID = "564d6a6153e70e00012cf262";
    private String API_KEY = "UnBxUVJScDBFQ3FBZG4zaHlPenZ3UQ";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        TestUtils.debug();
        TestUtils.useCnUatEnv();

        MaxLeap.initialize(this, APP_ID, API_KEY, MaxLeap.REGION_CN);
        super.onCreate(savedInstanceState);
    }

    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "demo";
    }

    /**
     * Returns whether dev mode should be enabled.
     * This enables e.g. the dev menu.
     */
    @Override
    protected boolean getUseDeveloperSupport() {
        return BuildConfig.DEBUG;
    }

    /**
     * A list of packages used by the app. If the app uses additional views
     * or modules besides the default ones, add more packages here.
     */
    @Override
    protected List<ReactPackage> getPackages() {
        return Arrays.<ReactPackage>asList(
                new MainReactPackage(),
                new MLPayReactPackage()
        );
    }
}
