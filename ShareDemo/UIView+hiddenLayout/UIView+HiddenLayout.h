//
//  UIView+HiddenLayout.h
//  ShareDemo
//
//  Created by 孙威风 on 2018/2/3.
//  Copyright © 2018年 孙威风的book. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HiddenLayoutVerticalAligent ) {
    HiddenLayoutVerticalAligent_top,//default
    HiddenLayoutVerticalAligent_bottom
};

typedef NS_ENUM(NSInteger,HiddenLayoutHorizontalAligent) {
    HiddenLayoutHorizontalAligent_lelf,//default
    HiddenLayoutHorizontalAligent_right
};


@interface NSLayoutConstraint (st_constant)

/**
 store the default constant value for reback the orginal constant
 */
@property (nonatomic,assign) CGFloat  st_Constant;

@end



@interface UIView (HiddenLayout)

/**
 default 'NO' ， if 'YES' the view's constraints with superview  will be auto update by a reasonable style , example when the view's size be {0,0} or need to be hidden .
 */
@property (nonatomic,assign) BOOL  hiddenLayout;


/**
 example label text is nil ,or imageview's image is nil
 */
@property (nonatomic,assign) BOOL  autoHiddenLayout;


/**
 default left  aligent
 */
@property (nonatomic,assign) HiddenLayoutHorizontalAligent horizontalAligent;


/**
 default top aligent
 */
@property (nonatomic,assign) HiddenLayoutVerticalAligent  verticalAligent;


/**
 store the default layout constraints
 */
@property (nonatomic,copy) IBOutletCollection(NSLayoutConstraint)  NSMutableArray<NSLayoutConstraint*> * hiddenLayoutConstants;



@end
