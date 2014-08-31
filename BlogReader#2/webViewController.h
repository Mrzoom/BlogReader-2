//
//  webViewController.h
//  BlogReader#2
//
//  Created by zoom on 14-3-15.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController
@property(nonatomic,strong)NSURL *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
