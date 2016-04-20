
platform :ios, '9.0'
use_frameworks!
link_with 'DINC', 'DINC Watch Extension'

#COCOAPODS_DISABLE_DETERMINISTIC_UUIDS=YES pod install

def shared_pods
    pod 'RealmSwift'
    pod 'Timepiece'
    pod 'Money'
end


target 'DINC' do

pod 'Alamofire'
pod 'SwiftyJSON'
shared_pods

end

target 'DINCTests' do

end

target 'DINCUITests' do

end

target 'DINC WatchKit App' do

end


target 'DINC WatchKit Extension' do
platform :watchos, '2.0'
shared_pods

end

