## **WHAT IS DINC?**
DINC is an Apple Watch app that helps you track/control your Disposable Income usage.
<br><br>


## **FEATURES**

Complication Support<br>
<img src="https://github.com/danielhour/DINC/raw/dev/Screenshots/complication.png" width="150">
<br><br>

## **OVERVIEW**
Here’s a blog post on why I created it: [Medium](http://www.templink.com)

Here’s the same blog post on why I am posting it on GitHub and NOT submitting it to the App Store: [Medium](http://www.templink.com)
<br><br>


## **COCOAPODS**
This project uses a few well-known & well-documented 3rd-party libraries from Cocoapods.

- [RealmSwift](https://github.com/realm/realm-cocoa) - for persisting local data
- [Timepiece](https://github.com/naoty/Timepiece) - pre-made NSDate extensions
- [Money](https://github.com/danthorpe/Money) - Swift value types for working with money & currency
<br><br>


## **DOCUMENTATION**
Created with [Jazzy](https://github.com/realm/jazzy). For best viewing, download/clone the repo and open the index.html file in the `Docs Folder`
<br><br>


## **FAQ**

**Why is the iPhone app just a white screen?**
- Because everything runs on the Watch. LITERALLY everything. I wanted a true stand-alone watch app. If you want to see your purchasing stats on your iPhone… well then, I suggest downloading your credit card’s app and looking it up there. I have no interest in reinventing the wheel.

**Why are you doing manual entries for purchases?**
- My original idea was to use the Plaid API but transactions are not fetched/updated immediately. In fact, they’re updated quite infrequently (in sandbox at least) so it would not give the watch wearer an accurate account of their daily budget. When there is an API that fetches transactions in true real-time, I'll definitely integrate it!

**Why does the WatchKit Extension take so long to install?**
- To get a true stand-alone watch app, EVERYTHING has to be on the watch. Which means installing the Cocoapod libraries directly onto the watch.
<br><br>




End