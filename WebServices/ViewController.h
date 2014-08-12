//
//  ViewController.h
//  WebServices
//
//  Created by Vinay Raj on 11/08/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate>
{
    NSMutableData *dataForAppendingResponse;
}
@property (weak, nonatomic) IBOutlet UITextField *txtinputname;
@property (weak, nonatomic) IBOutlet UITextField *txtinputPassword;
@property (weak, nonatomic) IBOutlet UIButton *lbllogin;
- (IBAction)btnlogin:(id)sender;
@end
