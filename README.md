
# KIDOZ_ADMOB_ADAPTER_iOS
Kidoz AdMob mediation adapter for Version 1.6  
Kidoz iOS SDK version 8.9.0
Built and tested with Google Mobile Ads SDK 7.58.0
</br>

**Prerequisits:**
* To use the Kidoz SDK adapter for AdMob you should make sure you have:
1. Google Mobile Ads SDK 7.42.2 or higher integrated in your project as explained [HERE](https://developers.google.com/admob/ios/quick-start):
2. A fully functional AdMob ad placement.
3. Kidoz SDK built with your project.
* Please make sure you have a set up Kidoz publisher account.
* The plugin itself is an iOS static library written in Objective C.

***This SDK version was verified not to contain the Advertiser Identifier (IDFA) as required by Apple App Store regulation for apps of Kids category.***


</br>

**Integration Steps:**

* Drag and drop the `libKidozSDK.a` and the `libKidozAdMobAdapter.a` from the sample app to your project.
* Select your target in the project navigator, select the “Build Settings” tab, search for “Other Linker Flags”, click on the “+” and type -ObjC  `Other Linker Flags -ObjC`  .
<a href="url"><img src="https://cdn.kidoz.net/sdk/ios/KidozSdkSampleApp3.png" align="center"  ></a>

* In the  `info.plist`  add  `NSAppTransportSecurity`  exception with  `NSAllowsArbitraryLoads`exception  
`<key>NSAppTransportSecurity</key>`  
`<dict>`  
`<key>NSAllowsArbitraryLoads</key>`  
`<true/>`  
`</dict>`
<a href="url"><img src="https://cdn.kidoz.net/sdk/ios/KidozSdkSampleApp2.png" align="center"  ></a>

* Define Kidoz Interstitial and/or Rewarded Video Custom events as explained [HERE](https://support.google.com/admob/answer/3083407):
* Set your Kidoz PublisherId & PublisherToken by setting  a Custom Events settings in the `Parameter` field:
```
For Banner:
 {"AppID":"your_publisher_id", "Token":"your_publisher_token"}

 For Interstitial:
 {"AppID":"your_publisher_id", "Token":"your_publisher_token"}

 For Rewarded Video:
 {"AppID":"your_publisher_id", "Token":"your_publisher_token"}
```
 
### KIDOZ Interstitial Adapter:
* Set the following in the `Class Name` field: </br>
KidozAdMobMediationInterstitialAdapter

### KIDOZ Rewarded Video Adapter:
* Set the following in the `Class Name` field: </br>
KidozAdMobMediationRewardedAdapter

    ```
    Note: for Google Mobile Ads SDK lower than 7.42.2 
      Set the full path in the Class Name field:  
      KidozAdMobMediationRewardedLegacyAdapter
    ```

### KIDOZ Banner Adapter:
* Set the following in the `Class Name` field: </br>
KidozAdMobMediationBannerAdapter</br>

 

License
--------

    Copyright 2015 KIDOZ, Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    