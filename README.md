# MaxPay RN [![npm version](https://badge.fury.io/js/maxpay-react-native.svg)](http://badge.fury.io/js/maxpay-react-native)

支付组件，支持微信，支付宝和银联支付。

## 集成 SDK

### 集成 iOS 环境

1. **重要：**先安装 `maxleap-react-native`, 参照 [MaxLeap RN 开发文档](http://badge.fury.io/js/maxleap-react-native)

2. 安装 `maxpay-react-native`

	```bash
	npm install --save maxpay-react-native
	```

3. 打开 Finder，找到本项目的根目录，使用 Xcode 打开 iOS 工程（双击 .xcodeproj 文件即可），然后导航到 `/node_modules/maxpay-react-native/ios/lib` 目录，把该目录下的 frameworks 都拖到 Xcode 工程中

4. 此外，使用个平台进行支付还需要配置 Xcode 项目，请参阅支付文档的[`手动安装`第4步以后的部分](https://maxleap.cn/s/web/zh_cn/guide/devguide/ios.html#移动支付)

### 集成 Android 环境

1. 按照 [MaxLeap 文档](https://maxleap.cn/s/web/zh_cn/guide/devguide/android.html#移动支付) 添加项目依赖。

1. 修改父工程目录下的 `build.gradle` 文件（与 `settings.gradle` 位于同级目录）。

    ```groovy
    repositories {
        flatDir{
            dirs '../../node_modules/maxpay-react-native/dist/android'
        }
    }
    ```

2. 修改应用目录下的 `build.gradle` 文件，添加以下依赖

    ```groovy
    dependencies {
        compile(name:'maxpay-react-native', ext:'aar')
    }
    ```

3. 修改工程的主 Activity 文件。

    ```java
     @Override
    protected void onCreate(Bundle savedInstanceState) {
        MaxLeap.initialize(this, APP_ID, API_KEY, MaxLeap.REGION_CN);
        super.onCreate(savedInstanceState);
    }

    @Override
    protected List<ReactPackage> getPackages() {
        return Arrays.<ReactPackage>asList(
                new MainReactPackage(),
                new MLPayReactPackage()
        );
    }
    ```
