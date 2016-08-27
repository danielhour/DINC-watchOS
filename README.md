## **WHAT IS DINC?**
DINC is a stand-alone Apple Watch app that helps you track/control your Disposable Income (D.INC) usage.

Here’s a blog post on why I created this app and why I'm "releasing" it on GitHub instead of submitting it to the App Store: [Medium](https://medium.com/@dhour/a-new-strategy-for-how-i-publish-my-apps-8e9de05c7bf1)
<br><br>


## **FEATURES**

*Quick Transaction Entry*
<br>Using that timeless 90's watch calculator layout... quickly enter in your most recent disposable income purchase.
<br>
<img src="https://raw.githubusercontent.com/danielhour/DINC/master/Screenshots/PriceController.gif" width="350">


*Spending Efficiency Rating*
<br>See if you're meeting your DINC goals and if you're setting the appropriate Daily Budget for yourself.
<br>
<img src="https://raw.githubusercontent.com/danielhour/DINC/master/Screenshots/ProjectionController.gif" width="350">

*Monthly Over/Under Projection*
<br>See how much money you can save by acting like Scrooge McDuck or see how much you're out if you decide you want to try and be Johnny Football for a month.
<br>
<img src="https://raw.githubusercontent.com/danielhour/DINC/master/Screenshots/efficiency.png" width="175">

*Complication & Glance Support*
<br>Out-of-sight leads to out-of-mind which is why the DINC app is best utilized with a watch face complication or an easy to access glance. This way you have a constant reminder of what your safe-to-spend DINC number is.
<br>
<img src="https://raw.githubusercontent.com/danielhour/DINC/master/Screenshots/complication.png" width="175">  <img src="https://raw.githubusercontent.com/danielhour/DINC/master/Screenshots/glance.png" width="175">


[YOU CAN FIND THE FULL STORYBOARD LAYOUT HERE](https://github.com/danielhour/DINC/blob/dev/Screenshots/DINC%20storyboard.png)
<br><br>


## **REQUIREMENTS FOR INSTALLATION**
- Xcode 7, Swift 2.2, Apple Watch (Watch OS2)
<br><br>


## **COCOAPODS**
This project uses a few well-known & well-documented 3rd-party libraries from Cocoapods.

- [RealmSwift](https://github.com/realm/realm-cocoa) - for persisting local data
- [Timepiece](https://github.com/naoty/Timepiece) - pre-made NSDate extensions
- [Money](https://github.com/danthorpe/Money) - Swift value types for working with money & currency
<br><br>


## **FAQ**

**Why is the iPhone app just a white screen?**
- Because everything is running on the Apple Watch. LITERALLY everything. I wanted a true stand-alone watch app. If you want to see your transactions on your iPhone… well, I suggest downloading your credit card’s app and looking it up there. I have no interest in reinventing the wheel.

**Why are you doing manual entries for purchases?**
- My original idea was to use the Plaid API but transactions are not fetched/updated immediately. In fact, they’re updated quite infrequently (in sandbox at least) so it would not give the watch wearer an accurate account of their daily budget. When there is an API that fetches transactions in true real-time, I'll definitely integrate it!

**Why does the WatchKit Extension take so long to install?**
- To get a true stand-alone watch app, EVERYTHING has to be on the watch. Which means installing the Cocoapod libraries directly onto the watch.

**How do you use the app in your everyday life?**
So my goal everyday is to spend *LESS* then the daily budget I set. The "unspent" money then helps me make more informed decisions on how much I should save or how much I should spend at social gatherings. And of course in those rare moments... how much should be spent to...
<br>
<img src="https://raw.githubusercontent.com/danielhour/DINC/master/Screenshots/treatyoself.gif" width="350">
<br><br>


## **TODO**
- [ ] Unit Tests
<br><br>


## **DOCUMENTATION**
Created with [Jazzy](https://github.com/realm/jazzy). For best viewing, download/clone the repo and open the index.html file in the `docs` folder
<br><br>




