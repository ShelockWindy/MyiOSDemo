//
//  ShareDemo.m
//  ShareDemo
//
//  Created by 孙威风的book on 2017/1/3.
//  Copyright © 2017年 孙威风的book. All rights reserved.
//

#import "ShareDemo.h"
#import <UIKit/UIKit.h>

@interface ShareDemo()
{
    
}
@property (nonatomic,copy) NSString * something;

@end


@implementation ShareDemo

+(ShareDemo*)shareInstacne
{
    static ShareDemo * shareDemo;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken,^(void){
        shareDemo = [[ShareDemo alloc]init];
    });
    return shareDemo;
}

-(void)getSmoeThing:(NSString*)something
{
    NSString * theThing ;
    theThing = something;
    _something = something;
    static dispatch_once_t  onceToken2;

    dispatch_once(&onceToken2,^(void){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"something--%@",_something);
        });
    });
}


-(void)test_donnnn:(dispatch_queue_t)queue2
{
    queue2  = dispatch_queue_create("sun.hello.01", nil);
    
    dispatch_sync(queue2, ^ {
        NSLog(@"11111111");
        
        dispatch_async(queue2, ^ {
            NSLog(@"11111111_0");
            
            dispatch_async(queue2, ^ {
                NSLog(@"11111111_1");
                
                
                
            });
            
        });
        
    });
    
    dispatch_async(queue2, ^ {
        NSLog(@"2222222");
        
        
        
    });
    
    
    dispatch_async(queue2, ^ {
        NSLog(@"33333333");
        
        
        
    });
    
    
    dispatch_async(queue2, ^ {
        NSLog(@"44444444");
        
        
        
    });
    
    
    
    dispatch_async(queue2, ^ {
        NSLog(@"555555555");
        
        
        
    });
    
    
    
    
    
//    dispatch_sync(queue2, ^ {
//        NSLog(@"3333333");
//
//
//
//    });
    
    
    
    
}




@end
