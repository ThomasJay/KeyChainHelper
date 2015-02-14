//
//  KeyChainHelper.m
//  KeyChainHelper
//
//  Created by Tom Jay on 2/13/15.
//  Copyright (c) 2015 Tom Jay. All rights reserved.
//

#import "KeyChainHelper.h"
#import <Security/Security.h>

@interface KeyChainHelper() {

}

@property (strong, nonatomic) NSString *serviceName;


@end


@implementation KeyChainHelper



+(KeyChainHelper *) sharedKeyChainHelper {
    
    static dispatch_once_t once;
    
    static KeyChainHelper *instance;
    
    dispatch_once(&once, ^{
        instance = [[KeyChainHelper alloc] init];
    });
    
    return instance;
}

//***************************************************************
// init - pass in service name (com.tomjay.test) - something like your bundle id that is unique to your app
+(void) initWithServiceName:(NSString*) serviceNameParam {
    [KeyChainHelper sharedKeyChainHelper].serviceName = serviceNameParam;
}



//***************************************************************
// Store or Update a Value in KeyChain (NSData)
-(BOOL) setKeyChainDataValueForAttribute:(NSString*) attribute value:(NSData*)value {
    
    
    if (attribute == nil) {
        return NO;
    }
    
    if (value == nil) {
        return NO;
    }
    
    
    OSStatus status;
    
    // Check to see if it exists (Add or update check)
    if ([self keyChainDataValueForAttribute:attribute] == nil) {
        
        // Process Add
        NSMutableDictionary *addDictionary = [[NSMutableDictionary alloc] init];
    
        [addDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
        NSData *encodedIdentifier = [attribute dataUsingEncoding:NSUTF8StringEncoding];
        [addDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
        [addDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
        [addDictionary setObject:self.serviceName forKey:(__bridge id)kSecAttrService];

    
        [addDictionary setObject:value forKey:(__bridge id)kSecValueData];
    
        status = SecItemAdd((__bridge CFDictionaryRef)addDictionary, NULL);

        
    }
    else {
        
        // Process Update
        NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
        
        [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        
        NSData *encodedIdentifier = [attribute dataUsingEncoding:NSUTF8StringEncoding];
        [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
        [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
        [searchDictionary setObject:self.serviceName forKey:(__bridge id)kSecAttrService];
        

        NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
        
        [updateDictionary setObject:value forKey:(__bridge id)kSecValueData];
        
        status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary, (__bridge CFDictionaryRef)updateDictionary);

    }
    
    if (status == errSecSuccess)
        return YES;
    
    else
        return NO;
    
}


//***************************************************************
// Store or Update a Value in KeyChain (NSString)
-(BOOL) setKeyChainStringValueForAttribute:(NSString*) attribute value:(NSString*)value {
    
    if (attribute == nil) {
        return NO;
    }
    
    if (value == nil) {
        return NO;
    }
    
    NSData* dataValue = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self setKeyChainDataValueForAttribute:attribute value:dataValue];
    
    
}


//***************************************************************
// Get a Value from KeyChain (NSData)
-(NSData*) keyChainDataValueForAttribute:(NSString*) attribute {
    
    if (attribute == nil) {
        return nil;
    }


    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedIdentifier = [attribute dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:self.serviceName forKey:(__bridge id)kSecAttrService];

    
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];

    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFDataRef cfrefAttributes;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, (CFTypeRef *)&cfrefAttributes);
    
    if (cfrefAttributes) {
        NSData *result = (__bridge_transfer NSData *)cfrefAttributes;
    
        NSLog(@"keyChainDataValueForAttribute completed Found Item");

        return result;}
    else {
        
        NSLog(@"keyChainDataValueForAttribute completed Did Not Find Item");

        return nil;
    }


}


//***************************************************************
// Get a Value from KeyChain (NSString)
-(NSString*) keyChainStringValueForAttribute:(NSString*) attribute {
    
    NSData *dataValue = [self keyChainDataValueForAttribute:attribute];
    
    if (dataValue != nil) {
        return [[NSString alloc] initWithData:dataValue encoding:NSUTF8StringEncoding];
    }
    else {
        return nil;
    }
    
    
    
}

//***************************************************************
// Delete item from KeyChain
-(void) keyChainDeleteValueForAttribute:(NSString*) attribute {
    
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedIdentifier = [attribute dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:self.serviceName forKey:(__bridge id)kSecAttrService];

    SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
}




@end
