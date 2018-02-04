//
//  UIView+HiddenLayout.m
//  ShareDemo
//
//  Created by 孙威风 on 2018/2/3.
//  Copyright © 2018年 孙威风的book. All rights reserved.
//

#import "UIView+HiddenLayout.h"
#import <objc/runtime.h>


@implementation NSLayoutConstraint (HiddenLayout)

#pragma mark- Dynamic Property

-(void)setSt_Constant:(CGFloat)st_Constant
{
    objc_setAssociatedObject(self, @selector(st_Constant), @(st_Constant), OBJC_ASSOCIATION_ASSIGN);
    
}

-(CGFloat)st_Constant
{
    return  [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end



@implementation UIView (HiddenLayout)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //hook update constrains
        // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
        Method fromMethod = class_getInstanceMethod([self class], @selector(updateConstraints));
        Method toMethod = class_getInstanceMethod([self class], @selector(hl_updateConstraints));
        
        if (!class_addMethod([self class], @selector(hl_updateConstraints), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
            method_exchangeImplementations(fromMethod, toMethod);
        }
        
    
        
    });
}

-(void)hl_updateConstraints
{
    [self hl_updateConstraints];
    
    NSArray * layouts = self.constraints;
    if (![self isKindOfClass:[NSClassFromString(@"_UILayoutGuide") class]]) {
        //NSLog(@"***********\n%@",layouts);
        
        BOOL hiddenLayout ;
        // "Absent" means this view doesn't have an intrinsic content size, {-1, -1} actually.
        const CGSize absentIntrinsicContentSize = CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
        
        // Calculated intrinsic content size
        const CGSize contentSize = [self intrinsicContentSize];
        
        // When this view doesn't have one, or has no intrinsic content size after calculating,
        // it going to be collapsed.
        if (CGSizeEqualToSize(contentSize, absentIntrinsicContentSize) ||
            CGSizeEqualToSize(contentSize, CGSizeZero)) {
            hiddenLayout = YES;
        } else {
            hiddenLayout = NO;
        }
        
        if (self.hiddenLayout) {
            
            NSLayoutConstraint  * left=nil ,*right=nil , *top = nil, *bottom = nil;

            for (NSLayoutConstraint  * layout in layouts) {
                layout.st_Constant = layout.constant>0?layout.constant:layout.st_Constant;
                layout.constant = 0 ;
                
                //NSLog(@"edglayouts------%@",superlayouts);
            }
            
            NSArray  * superlayouts = self.superview.constraints;
            
            NSMutableArray * edgslayouts = [NSMutableArray array];
            NSMutableArray * hiddenlayoutContraints = [NSMutableArray array];
            [hiddenlayoutContraints addObjectsFromArray:layouts];
            for (NSLayoutConstraint * suplayout in superlayouts) {
                suplayout.st_Constant = suplayout.constant>0?suplayout.constant:suplayout.st_Constant;
                if (suplayout.firstItem== self||suplayout.secondItem==self) {
                    [edgslayouts addObject:suplayout];
                    
                    if (suplayout.firstItem== self) {
                        
                        if (suplayout.firstAttribute == NSLayoutAttributeTop) {
                            top = suplayout;
                        }
                        
                        if (suplayout.firstAttribute == NSLayoutAttributeRight) {
                            right = suplayout;
                        }
                        
                        if (suplayout.firstAttribute == NSLayoutAttributeLeft) {
                            left = suplayout;
                        }
                        
                        if (suplayout.firstAttribute == NSLayoutAttributeBottom) {
                            bottom = suplayout;
                        }
                        
                    }else
                    {
                        if (suplayout.secondAttribute == NSLayoutAttributeTop) {
                            top = suplayout;
                        }
                        
                        if (suplayout.secondAttribute == NSLayoutAttributeRight) {
                            right = suplayout;
                        }
                        
                        if (suplayout.secondAttribute == NSLayoutAttributeLeft) {
                            left = suplayout;
                        }
                        
                        if (suplayout.secondAttribute == NSLayoutAttributeBottom) {
                            bottom = suplayout;
                        }
                    }
                    
                }
                
                if (top&&bottom) {
            if(self.verticalAligent==HiddenLayoutVerticalAligent_topAligent&&bottom.st_Constant>0) {
                    [hiddenlayoutContraints addObject:bottom];
                    bottom.constant = 0;

                }else if (top.st_Constant>0)
                {
                    [hiddenlayoutContraints addObject:top];
                    top.constant = 0;
                }
                    
                    
             }
                
                if (left&&right) {
                    
                    if (self.horizontalAligent == HiddenLayoutHorizontalAligent_lelf&&right.st_Constant>0) {
                        
                        [hiddenlayoutContraints addObject:right];
                        right.constant = 0;
                    }else if (left.st_Constant>0){
                        
                        [hiddenlayoutContraints addObject:left];
                        left.constant = 0;
                        
                    }
                    
                }
                
            }
            
            self.hiddenLayoutConstants = hiddenlayoutContraints;
            
            
        }else
        {
            
            for (NSLayoutConstraint * defalut   in  self.hiddenLayoutConstants) {
                defalut.constant = defalut.st_Constant;
            }
            
            
         }
    }
    
}


#pragma mark- Dynamic Property

-(void)setHiddenLayout:(BOOL)hiddenLayout
{
    
    objc_setAssociatedObject(self, @selector(hiddenLayout), @(hiddenLayout), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)hiddenLayout
{
    return  [objc_getAssociatedObject(self, _cmd) boolValue];
}


-(void)setHiddenLayoutConstants:(NSMutableArray<NSLayoutConstraint *> *)hiddenLayoutConstants
{
    objc_setAssociatedObject(self, @selector(hiddenLayoutConstants),hiddenLayoutConstants, OBJC_ASSOCIATION_COPY);
}

-(NSMutableArray<NSLayoutConstraint *> *)hiddenLayoutConstants
{
    return objc_getAssociatedObject(self, _cmd);
}


-(HiddenLayoutHorizontalAligent)horizontalAligent
{
  return   [objc_getAssociatedObject(self, _cmd) integerValue];
}


-(void)setHorizontalAligent:(HiddenLayoutHorizontalAligent)horizontalAligent
{
    objc_setAssociatedObject(self, @selector(horizontalAligent), @(horizontalAligent), OBJC_ASSOCIATION_ASSIGN);
}

-(HiddenLayoutVerticalAligent)verticalAligent
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setVerticalAligent:(HiddenLayoutVerticalAligent)verticalAligent
{
    objc_setAssociatedObject(self, @selector(verticalAligent), @(verticalAligent), OBJC_ASSOCIATION_ASSIGN);
}


@end
