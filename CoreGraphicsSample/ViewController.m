//
//  ViewController.m
//  CoreGraphicsSample
//
//  Created by pebble8888 on 2015/07/03.
//  Copyright © 2015年 pebble8888. All rights reserved.
//

#import "ViewController.h"
#import "PebbleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PebbleView* view =  [[PebbleView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
}

@end
