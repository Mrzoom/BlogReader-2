//
//  BlogPost.h
//  BlogReader#2
//
//  Created by zoom on 14-3-14.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject
@property(nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * author;
@property (nonatomic,strong)NSString *thumbnail;
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSURL * url;
-(id) initWithTitle:(NSString *)title;
+(id) blogPostWithTitle:(NSString *)title;
-(NSURL *)returnURL;
-(NSString *)returnDate;

@end
