//
//  KeyChainHelper.h
//  KeyChainHelper
//
//  Created by Tom Jay on 2/13/15.
//  Copyright (c) 2015 Tom Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainHelper : NSObject


// Note: Add the Security.framework to the project

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




@end
