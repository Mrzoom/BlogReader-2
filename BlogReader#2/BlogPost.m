//
//  BlogPost.m
//  BlogReader#2
//
//  Created by zoom on 14-3-14.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost
-(id)initWithTitle:(NSString *)title{
    self=[super init];
    if(self){
        self.title=title;
    }
    return self;
}
+(id)blogPostWithTitle:(NSString *)title{
    return [[self alloc] initWithTitle:title];
}
-(NSURL *)returnURL{
    return [NSURL URLWithString:self.thumbnail];
}

-(NSString *)returnDate{
    NSDateFormatter * dataFormatter =[[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    NSDate * time=[dataFormatter dateFromString:self.date];
    [dataFormatter setDateFormat:@"EE MMM,dd"];
    return [dataFormatter stringFromDate:time];
}
		
@end
