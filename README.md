# GetUDIDFromStoreKit
Get UDID(Unique Device Identifier) From StoreKit

After iOS5, Developer can't use "uniqueIdentifier" like this "[UIDevice currentDevice] uniqueIdentifier]".

The property is deprecated, and rplaced by "identifierForVendor".

Also we can use OpenUDID or SecureUDID, working with NSUserDefaults and Keychain.


```objc
NS_CLASS_AVAILABLE_IOS(2_0) @interface UIDevice : NSObject 
...

@property(nonatomic,readonly,retain) NSString    *uniqueIdentifier  NS_DEPRECATED_IOS(2_0, 5_0);  // a string unique to each device based on various hardware info.

@property(nonatomic,readonly,retain) NSUUID      *identifierForVendor NS_AVAILABLE_IOS(6_0);      // a UUID that may be used to uniquely identify the device, same across apps from a single vendor.

....
@end
```

## Now, if you App has some purchase item using StoreKit, we can find UDID from receipt.
