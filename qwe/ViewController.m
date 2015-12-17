//
//  ViewController.m
//  qwe
//
//  Created by golven on 15/7/22.
//  Copyright (c) 2015年 magicEngineer. All rights reserved.
//

#import "ViewController.h"
#import "GLabelFrameCalculate.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation ViewController
{
    GLabelFrameCalculate *tool;
    NSUInteger totallyHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tool = [[GLabelFrameCalculate alloc] init];
    totallyHeight = 0;
}

- (IBAction)addLabel:(UIButton *)sender {
        [tool returnNewLabelFrameWithText:_textField.text textFont:[UIFont systemFontOfSize:14] limitWidth:10000 taskBlcok:^(CGRect rect) {
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            label.backgroundColor = [UIColor lightGrayColor];
            label.text = _textField.text;
            label.font = [UIFont systemFontOfSize:14];
            [self.view addSubview:label];
            _textField.text = nil;
        }];
}



@end
