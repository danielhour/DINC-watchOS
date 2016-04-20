## **FEATURES**




## **OVERVIEW**

DINC is a watch app that helps you track/control your Disposable Income usage.

Here’s a blog post on why I created it: 

Here’s the same blog post on why I am not submitting it to the App Store and am instead just posting it on GitHub: [](http://www.yolo.com)


## **COCOAPODS**
This project uses a few well-known & well-documented 3rd-party libraries from Cocoapods.

- [RealmSwift](https://github.com/realm/realm-cocoa) - for persisting local data
- [Timepiece](https://github.com/naoty/Timepiece) - pre-made NSDate extensions
- [Money](https://github.com/danthorpe/Money) - Swift value types for working with money & currency
<br><br>


## **FAQ**

Why is the iPhone app just a white screen?
- Because everything runs on the Watch. LITERALLY everything. I wanted a true stand-alone watch app. If you want to see your purchases on your iPhone… then well, download your credit card’s app and look it up there. I have no interest in reinventing the wheel.

Why are you doing manual entries for purchases?
- My original idea was to use the Plaid API but transactions are not fetched/updated immediately. In fact, they’re updated quite infrequently (in sandbox at least) so it would not give the watch wearer an accurate account of their daily budget

Why does the WatchKit Extension take so long to install?
- EVERYTHING is on the watch. in fact, this app really doesn’t need the iPhone. However, this means the Cocoapod libraries I’m using are taking awhile to install
<br><br>


## **DOCUMENTATION**
Documentation is created with [Jazzy](https://github.com/realm/jazzy).
<br><br>



End