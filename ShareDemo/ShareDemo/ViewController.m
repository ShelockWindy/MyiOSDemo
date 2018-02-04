//
//  ViewController.m
//  ShareDemo
//
//  Created by 孙威风的book on 2017/1/3.
//  Copyright © 2017年 孙威风的book. All rights reserved.
//

#import "ViewController.h"
#import "ShareDemo.h"
#import "Masonry.h"
#import "UIView+HiddenLayout.h"

static dispatch_queue_t queue2;

@interface ViewController ()
{
    struct test
     {
         
    
       };
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIToolbar * toolBar ;
    
    [[ShareDemo shareInstacne]getSmoeThing:@"tom,this is dog!"];
    [[ShareDemo shareInstacne]getSmoeThing:@"tom,this is cat!"];

    
    //[self test];
    
    [self addSubView];
}


-(void)addSubView
{
    
    UILabel * testV1 = [UILabel new];
    testV1.numberOfLines = 0;
    testV1.text = @"也是最棒的一次人生经历。”﻿ ﻿ 执导第一部电影《爱与黑暗的故事》时，波特曼也处于“无经验”状态。那是一部对白全是希伯来语的片子，她既要出演，又要担任编剧。她说自，要么就让它帮你";
    testV1.backgroundColor = [UIColor redColor];
    [self.view addSubview:testV1];
    
    UIImageView * testV2 = [UIImageView new];
    testV2.backgroundColor = [UIColor blueColor];
    testV2.image = [UIImage imageNamed:@"33"];
    testV2.tag = 100;
    [self.view addSubview:testV2];
    
    UIImageView * testV4 = [UIImageView new];
    testV4.backgroundColor = [UIColor blueColor];
//    testV4.image = [UIImage imageNamed:@"33"];
    testV4.tag = 110;
    [self.view addSubview:testV4];
    
    
    UILabel * testV3 = [UILabel new];
    testV3.numberOfLines = 0;
    testV3.text = @" 她要说的是：“你的无经验是一笔财富，会让你用最本能、最不受局限的方式来思考问题。每当着手新事物时，你要么让这种无经验将你领上他人走过的道路，要么就让它帮你";
    testV3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:testV3];
    
    testV1.hiddenLayout = NO;
    testV2.hiddenLayout = YES;
    testV2.verticalAligent = HiddenLayoutVerticalAligent_bottomAligent;
    testV2.horizontalAligent = HiddenLayoutHorizontalAligent_right;
    
    
    //layout
    
    [testV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@50);
    }];
    
    
    [testV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(testV1);
        make.top.equalTo(testV1.mas_bottom).offset(5);
    
    }];
    
    [testV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(testV1);
        make.width.equalTo(testV1);
        make.top.equalTo(testV2.mas_bottom).offset(45);
    }];
    
    
    [testV4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(testV2.mas_right).offset(20);
        make.top.equalTo(testV2);
        make.width.and.height.equalTo(@100);
        
    }];
    
    NSArray * layouts = self.view.constraints;
    
    for (NSLayoutConstraint *  layout in layouts) {
        
        //NSLog(@"firstitem --- %@, seconditem ----- %@",layout.firstItem,layout.secondItem);
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            

            //testV1.hiddenLayout = YES;
            testV2.hiddenLayout = NO;
            //[testV1 updateConstraints];
            [testV2 updateConstraints];
            
            //[testV1 layoutIfNeeded];
            [testV1 layoutIfNeeded];
            [testV2 layoutIfNeeded];

        } completion:nil];
        
       
    });
}





-(void)test{
    
    // self 是当前实例指针，a2 对应方法选择器，a3 对应方法参数 option; a4 对应方法参数 isForce; a5 对应方法参数 extraInfo;
    // a6 对应方法参数 completionHandler; a7 对应方法参数 cancelationHandler; a8 对应方法参数 request

    dispatch_queue_t queue = dispatch_queue_create("com.sunwf.hello", DISPATCH_QUEUE_CONCURRENT);
    
    queue = dispatch_queue_create("com.swf.cc", nil);
    
    //queue = dispatch_get_global_queue(0, 0);
    
      queue2 = dispatch_queue_create("com.swf.cc2", nil);
//    dispatch_async(queue, ^ {
//        NSLog(@"xxoo0");
//
//        NSLog(@"xxoo2");
//
//        dispatch_sync(queue, ^ {
//            NSLog(@"xxoo1");
//
//        });
//
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            dispatch_sync(queue, ^ {
//                NSLog(@"xxoo1");
//
//            });
//        });
//
//
//
//    });

 
    dispatch_async(queue2, ^{
       
        [[ShareDemo shareInstacne]test_donnnn:queue2];
        
    });
    
    
    
    
//        dispatch_sync(dispatch_get_main_queue(), ^ {
//            NSLog(@"xxoo1");
//
//
//
//        });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
