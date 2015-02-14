# KeyChainHelper
iOS KeyChain Helper - iOS 8 / Object-C. Simple class to help Insert, Update, Retrieve and Delete items from the KeyChain

Initialize the Helper, give it something unique like your bundle id

[KeyChainHelper initWithServiceName:@"com.tomjay.test"];

Save Some Data

NSData* value = [@"secret stuff2" dataUsingEncoding:NSUTF8StringEncoding];
[[KeyChainHelper sharedKeyChainHelper] setKeyChainDataValueForAttribute:@"testitem2" value:value];

Save and Update is the same call

Get Data from KeyChain

 NSData *retValue = [[KeyChainHelper sharedKeyChainHelper] keyChainDataValueForAttribute:@"testitem2"];

Delete Item from KeyChain

[[KeyChainHelper sharedKeyChainHelper] keyChainDeleteValueForAttribute:@"testitem"];




API

// Get Singleton of KeyChainHelper
+(KeyChainHelper *) sharedKeyChainHelper;

// Init KeyChainHelper - pass in service name (com.tomjay.test) - something like your bundle id that is unique to your app
+(void) initWithServiceName:(NSString*) serviceName;


// Store or Update a Value in KeyChain
-(BOOL) setKeyChainDataValueForAttribute:(NSString*) attribute value:(NSData*)value;
-(BOOL) setKeyChainStringValueForAttribute:(NSString*) attribute value:(NSString*)value;


// Get a Value from KeyChain
-(NSData*) keyChainDataValueForAttribute:(NSString*) attribute;
-(NSString*) keyChainStringValueForAttribute:(NSString*) attribute;


// Delete item from KeyChain
-(void) keyChainDeleteValueForAttribute:(NSString*) attribute;





// Note: Add the Security.framework to the project




