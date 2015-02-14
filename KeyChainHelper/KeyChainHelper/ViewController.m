//
//  ViewController.m
//  KeyChainHelper
//
//  Created by Tom Jay on 2/13/15.
//  Copyright (c) 2015 Tom Jay. All rights reserved.
//

#import "ViewController.h"
#import "KeyChainHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Setup the Helper with a service name
    // You only havce to do this one in the app, maybe in the app delegate
    [KeyChainHelper initWithServiceName:@"com.tomjay.test"];
    
    // Get something to set
//    NSData* value = [@"secret stuff2" dataUsingEncoding:NSUTF8StringEncoding];
//    
//    // Actually store it in the keychain
//    [[KeyChainHelper sharedKeyChainHelper] setKeyChainDataValueForAttribute:@"testitem2" value:value];
    
    // Get out what you stored.
    NSData *retValue = [[KeyChainHelper sharedKeyChainHelper] keyChainDataValueForAttribute:@"testitem2"];

    if (retValue) {
        NSString *password = [[NSString alloc] initWithData:retValue encoding:NSUTF8StringEncoding];
        NSLog(@"secret=%@", password);
    }
    else {
        NSLog(@"Nothing found");
    }
    
//    [[KeyChainHelper sharedKeyChainHelper] keyChainDeleteValueForAttribute:@"testitem"];
    
    // Value is stored in a secure fashion not clear text like the user prefs.
    // If you using the emulator you will have to "Reset" and clear all values not just remove the app to test.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
