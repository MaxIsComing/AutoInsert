//
//  GLabelFrameCalculate.h
//  qwe
//
//  Created by golven on 15/7/22.
//  Copyright (c) 2015年 magicEngineer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LIMITHEIGHT 30              //label的高度
#define LABELSPACING 15              //每个label之间的间距
#define LINESPACING 10              //每一行之间的距离
#define ORIGINALCOORDINATE_X 0      //第一个label的x坐标
#define ORIGINALCOORDINATE_Y 100    //第一个label的y坐标

typedef void(^block)(CGRect rect);

@interface GLabelFrameCalculate : NSObject

- (void)returnNewLabelFrameWithText:(NSString *)text
                             textFont:(UIFont *)font
                         limitWidth:(CGFloat)width
                          taskBlcok:(block)taskBlock;

@end
