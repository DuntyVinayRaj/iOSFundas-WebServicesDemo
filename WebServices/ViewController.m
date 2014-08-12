//
//  ViewController.m
//  WebServices
//
//  Created by Vinay Raj on 11/08/14.
//  Copyright (c) 2014 Vinay Raj. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    // Web service request for login made here
    
    //DoWS0Q08mLKADdEY7cBVMRHzqogSmMJebJQM8g
    

    
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Log : Connection failed - %@", error);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:error.localizedDescription delegate:self cancelButtonTitle:@"ok"otherButtonTitles:nil, nil];
    [alert show];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataForAppendingResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   // NSString *response = [[NSString alloc]initWithData:dataForAppendingResponse encoding:NSUTF8StringEncoding];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:dataForAppendingResponse
                          
                          options:kNilOptions
                          error:&error];
    
    
    
    
    ((AppDelegate*)[UIApplication sharedApplication].delegate).userName = json[@"name"];
    [self performSegueWithIdentifier:@"loginsegue" sender:self];
    NSLog(@"Resonse: %@", json);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnlogin:(id)sender {
   // [self performSegueWithIdentifier:@"loginsegue" sender:self];
    
    
    dataForAppendingResponse = [[NSMutableData alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://ec2-54-187-207-54.us-west-2.compute.amazonaws.com:3000/users/login"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    
    
    NSDictionary *reqBody = @{@"user":
                                  @{
                                      @"email" : self.txtinputname.text,
                                      @"password" : self.txtinputPassword.text
                                      }
                              };
    
    NSError *error;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:reqBody
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [req setHTTPBody:jsondata];
    
    NSLog(@"Log : Request being sent is - %@", req);
    NSURLConnection *con = [NSURLConnection connectionWithRequest:req delegate:self];
    [con start];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
