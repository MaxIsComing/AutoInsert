//
//  GLabelFrameCalculate.m
//  qwe
//
//  Created by golven on 15/7/22.
//  Copyright (c) 2015年 magicEngineer. All rights reserved.
//

#import "GLabelFrameCalculate.h"

#define MAINSCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation GLabelFrameCalculate{
    NSMutableArray *frameArr;//记录每一行的宽度
}

- (instancetype)init {
    if (self = [super init]) {
        frameArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)returnNewLabelFrameWithText:(NSString *)text
                             textFont:(UIFont *)font
                           limitWidth:(CGFloat)width
                          taskBlcok:(block)taskBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGRect finalRect = CGRectMake(0, 0, 10001, 10001);
        //计算文本内容大小
        CGRect rect = [text boundingRectWithSize:CGSizeMake(MAINSCREEN_SIZE.width, LIMITHEIGHT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];
        if (frameArr.count == 0) {
            //第一个label直接返回
            finalRect = CGRectMake(ORIGINALCOORDINATE_X+LABELSPACING, ORIGINALCOORDINATE_Y, rect.size.width, LIMITHEIGHT);
            //大于屏幕宽度
            if (finalRect.size.width >= MAINSCREEN_SIZE.width - 2*LABELSPACING) {
                finalRect.size.width = MAINSCREEN_SIZE.width - 2*LABELSPACING;
            }
            [frameArr addObject:@(finalRect.size.width)];
        } else {
            for (int i = 0; i < frameArr.count; i++) {
                NSNumber *item = frameArr[i];
                CGFloat occupiedSpace = item.floatValue;//一行被占用宽度
                CGFloat leftSpace = MAINSCREEN_SIZE.width - occupiedSpace - 2*LABELSPACING;//剩余宽度,需要减掉label之间的间隔
                //如果剩余宽度大于或者等于文本宽度,该行能放下
                if (leftSpace >= rect.size.width) {
                    //计算y坐标
                    CGFloat y = ORIGINALCOORDINATE_Y;
                    if (i > 0) {
                        y += i*(LIMITHEIGHT+LINESPACING);
                    }
                    finalRect = CGRectMake(occupiedSpace+2*LABELSPACING, y, rect.size.width, LIMITHEIGHT);
                    [frameArr replaceObjectAtIndex:i withObject:@(finalRect.size.width+occupiedSpace+LABELSPACING)];
                    break;
                }
            }
            //如果已存在的每一行都不足以放置该内容,则重启一行
            //如果该内容比屏幕的宽度,则只返回宽度为屏幕的宽度减去两端流出的间距
            if (finalRect.size.width > 10000 && finalRect.size.height > 10000) {
                //计算y坐标
                CGFloat y = (frameArr.count)*(LINESPACING+LIMITHEIGHT)+ORIGINALCOORDINATE_Y;
                if (rect.size.width >= MAINSCREEN_SIZE.width - 2 * LABELSPACING) {
                    finalRect = CGRectMake(LABELSPACING, y, MAINSCREEN_SIZE.width-2*LABELSPACING, LIMITHEIGHT);
                } else {
                    finalRect = CGRectMake(LABELSPACING, y, rect.size.width, LIMITHEIGHT);
                }
                [frameArr addObject:@(finalRect.size.width)];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           taskBlock(finalRect); 
        });
    });
}

@end
