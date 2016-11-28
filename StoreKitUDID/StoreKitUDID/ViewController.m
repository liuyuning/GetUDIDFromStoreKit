//
//  ViewController.m
//  StoreKitUDID
//
//  Created by liuyuning on 16/11/26.
//  Copyright © 2016年 liuyuning. All rights reserved.
//

#import "ViewController.h"
@import StoreKit;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)UDIDFromReceiptData:(NSData *)receiptData{
    
    NSDictionary *receiptDict = [NSPropertyListSerialization propertyListWithData:receiptData options:NSPropertyListImmutable format:NULL error:NULL];
    
    NSString *purchaseInfo = receiptDict[@"purchase-info"];
    NSData *purchaseData = [[NSData alloc] initWithBase64EncodedString:purchaseInfo options:0];
    NSDictionary *purchaseDict = [NSPropertyListSerialization propertyListWithData:purchaseData options:NSPropertyListImmutable format:NULL error:NULL];
    //NSLog(@"purchaseDict:%@",purchaseDict);
    
    NSString *UDID = purchaseDict[@"unique-identifier"];
    //NSLog(@"UDID:%@",UDID);
    
    return UDID;
}

//Test
- (void)testData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"transactionReceipt" ofType:nil];
    NSData *receiptData = [NSData dataWithContentsOfFile:path];
    
    NSString *UDID = [self UDIDFromReceiptData:receiptData];
    NSLog(@"UDID:%@",UDID);
}

//Example
#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    
    for (SKPaymentTransaction *transaction in transactions) {
        
        if (SKPaymentTransactionStatePurchased == transaction.transactionState) {
            
            //-[SKPaymentTransaction transactionReceipt] deprecated after iOS7 but it still works on iOS7-10.
            //-[NSBundle appStoreReceiptURL] dose not contain purchase-info.
            NSData *receiptData = transaction.transactionReceipt;
            NSString *UDID = [self UDIDFromReceiptData:receiptData];
            NSLog(@"UDID:%@",UDID);
            
        }
    }
    
}

@end

