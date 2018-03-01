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
    objc_setAssociatedObject(self, @selector(st_Constant), @(st_Constant), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
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
        [self hook_Method:@selector(updateConstraints) newMethod:@selector(my_updateConstraints)];
        
        [self hook_Method:@selector(addConstraint:) newMethod:@selector(hl_addConstraint:)];
        
        
    });
}

+(void)hook_Method:(SEL)orign newMethod:(SEL)new
{
    Method fromMethod = class_getInstanceMethod([self class], orign);
    Method toMethod = class_getInstanceMethod([self class], new);
    
    if (!class_addMethod([self class], new, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}

-(void)hl_addConstraint:(NSLayoutConstraint *)constraint
{
    [self hl_addConstraint:constraint];
    
    UIView * firstV = constraint.firstItem;
    UIView * secondV = constraint.secondItem;
    
    
    //vertical

    if (constraint.firstAttribute==NSLayoutAttributeTop) {
        
        if (![firstV isEqual:self]) {
            
            if (firstV.hiddenLayoutConstants==nil) {
                firstV.hiddenLayoutConstants = [NSMutableArray array];
            }
            constraint.st_Constant = constraint.constant;
            [firstV.hiddenLayoutConstants addObject:constraint];
            
        }
        
    }
    
    if (constraint.secondAttribute==NSLayoutAttributeTop) {
        
        if (![secondV isEqual:self]) {
            
            if (secondV.hiddenLayoutConstants==nil) {
                secondV.hiddenLayoutConstants = [NSMutableArray array];
            }
            constraint.st_Constant = constraint.constant;
            [secondV.hiddenLayoutConstants addObject:constraint];
            
        }
        
    }
    
    
    if (constraint.firstAttribute==NSLayoutAttributeHeight) {
        
        if ([firstV isEqual:self]&&![self isKindOfClass:[UILabel class]]) {
            
            if (firstV.hiddenLayoutConstants==nil) {
                firstV.hiddenLayoutConstants = [NSMutableArray array];
            }
            constraint.st_Constant = constraint.constant;
            [firstV.hiddenLayoutConstants addObject:constraint];
            
        }
        
    }
    
    
    if (constraint.secondAttribute==NSLayoutAttributeHeight) {
        
        if ([secondV isEqual:self]&&![self isKindOfClass:[UILabel class]]) {
            if (secondV.hiddenLayoutConstants==nil) {
                secondV.hiddenLayoutConstants = [NSMutableArray array];
            }
            
            constraint.st_Constant = constraint.constant;

            [secondV.hiddenLayoutConstants addObject:constraint];
            
        }
        
    }
    
//horizonta
    
    if (constraint.firstAttribute==NSLayoutAttributeLeft||constraint.firstAttribute==NSLayoutAttributeLeading) {
        
        if (![firstV isEqual:self]) {
        
            if (firstV.hiddenLayoutConstants==nil) {
                firstV.hiddenLayoutConstants = [NSMutableArray array];
            }
            constraint.st_Constant = constraint.constant;
            [firstV.hiddenLayoutConstants addObject:constraint];
        
        }
        
    }
    
    if (constraint.firstAttribute==NSLayoutAttributeLeft||constraint.firstAttribute==NSLayoutAttributeLeading) {

        if (![secondV isEqual:self]) {
            
            if (secondV.hiddenLayoutConstants==nil) {
                secondV.hiddenLayoutConstants = [NSMutableArray array];
            }
            constraint.st_Constant = constraint.constant;
            [secondV.hiddenLayoutConstants addObject:constraint];
            
        }
        
    }
    
    
    if (constraint.firstAttribute==NSLayoutAttributeWidth) {
        
        if ([firstV isEqual:self]&&![self isKindOfClass:[UILabel class]]) {
            
            if (firstV.hiddenLayoutConstants==nil) {
                firstV.hiddenLayoutConstants = [NSMutableArray array];
            }
            constraint.st_Constant = constraint.constant;
            [firstV.hiddenLayoutConstants addObject:constraint];
            
        }
        
    }
    
    
    if (constraint.secondAttribute==NSLayoutAttributeWidth) {
        
        if ([secondV isEqual:self]&&![self isKindOfClass:[UILabel class]]) {
            if (secondV.hiddenLayoutConstants==nil) {
                secondV.hiddenLayoutConstants = [NSMutableArray array];
            }
            
            constraint.st_Constant = constraint.constant;
            
            [secondV.hiddenLayoutConstants addObject:constraint];
            
        }
        
    }
    
    
}


-(void)my_updateConstraints
{
    [self my_updateConstraints];
    
    if (self.autoHiddenLayout && self.hiddenLayoutConstants.count > 0) {
        
        // "Absent" means this view doesn't have an intrinsic content size, {-1, -1} actually.
        const CGSize absentIntrinsicContentSize = CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
        
        // Calculated intrinsic content size
        const CGSize contentSize = [self intrinsicContentSize];
        
        // When this view doesn't have one, or has no intrinsic content size after calculating,
        // it going to be collapsed.
        if (CGSizeEqualToSize(contentSize, absentIntrinsicContentSize) ||
            CGSizeEqualToSize(contentSize, CGSizeZero)) {
            self.hiddenLayout = YES;
        } else {
            self.hiddenLayout = NO;
        }
    }

}


-(void)getHiddenLayoutConstants
{
    NSArray * layouts = self.superview.constraints;
    NSLayoutConstraint * left, * right, * top, * bottom;
    for (NSLayoutConstraint * layout in layouts) {
        
        if ((layout.firstItem==self&&layout.firstAttribute==NSLayoutAttributeLeft)||(layout.secondItem==self&&layout.secondAttribute==NSLayoutAttributeLeft)) {
            left = layout;
        }
        
        if ((layout.firstItem==self&&layout.firstAttribute==NSLayoutAttributeRight)||(layout.secondItem==self&&layout.secondAttribute==NSLayoutAttributeRight)) {
            right = layout;
        }
        
        if ((layout.firstItem==self&&layout.firstAttribute==NSLayoutAttributeTop)||(layout.secondItem==self&&layout.secondAttribute==NSLayoutAttributeTop)) {
            top = layout;
        }
        
        if ((layout.firstItem==self&&layout.firstAttribute==NSLayoutAttributeBottom)||(layout.secondItem==self&&layout.secondAttribute==NSLayoutAttributeBottom)) {
            bottom = layout;
        }
        
        NSMutableArray * array = [NSMutableArray array];
        if (self.horizontalAligent==HiddenLayoutHorizontalAligent_lelf) {
            
            if (right) {
                right.st_Constant = right.constant;
                [array addObject:right];
            }
        }else
        {
            if (left) {
                left.st_Constant = left.constant;
                [array addObject:left];
            }
        }
        
        if (self.verticalAligent==HiddenLayoutVerticalAligent_top) {
            
            if (bottom) {
                bottom.st_Constant = bottom.constant;
                [array addObject:bottom];
            }
        }else
        {
            if (top) {
                top.st_Constant = top.constant;
                [array addObject:top];
            }
        }
        
        self.hiddenLayoutConstants = array;
        
    }
    
    
}


#pragma mark- Dynamic Property

-(void)setHiddenLayout:(BOOL)hiddenLayout
{
    
    NSLog(@"%@,,,,",self.hiddenLayoutConstants);
    [self.hiddenLayoutConstants enumerateObjectsUsingBlock:
     ^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
         if (hiddenLayout) {
             constraint.constant = 0;
         } else {
             constraint.constant = constraint.st_Constant;
         }
     }];

    objc_setAssociatedObject(self, @selector(hiddenLayout), @(hiddenLayout), OBJC_ASSOCIATION_ASSIGN);
    self.hidden = hiddenLayout;
}

-(BOOL)hiddenLayout
{
    return  [objc_getAssociatedObject(self, _cmd) boolValue];
}


-(void)setAutoHiddenLayout:(BOOL)autoHiddenLayout
{
    objc_setAssociatedObject(self, @selector(autoHiddenLayout), @(autoHiddenLayout), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    
    self.hiddenLayout = autoHiddenLayout;
}

-(BOOL)autoHiddenLayout
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}



-(void)setHiddenLayoutConstants:(NSMutableArray<NSLayoutConstraint *> *)hiddenLayoutConstants
{
    // Hook assignments to our custom `fd_collapsibleConstraints` property.
    NSMutableArray *constraints = (NSMutableArray *)self.hiddenLayoutConstants;
    
    [hiddenLayoutConstants enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        // Store original constant value
        constraint.st_Constant = constraint.constant;
        [constraints addObject:constraint];
    }];
    
}

-(NSMutableArray<NSLayoutConstraint *> *)hiddenLayoutConstants
{
    NSMutableArray *constraints = objc_getAssociatedObject(self, _cmd);

    if (!constraints) {
        constraints = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, constraints, OBJC_ASSOCIATION_RETAIN);
    }
    
    return constraints;
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
