//
//  OCExplorationViewController.m
//  OCExploration
//
//  Created by hj B on 2021/9/7.
//  

#import "RuntimeExplorationViewController.h"
#import <objc/runtime.h>
#import "RPerson.h"
#import "RStudent.h"

@interface RuntimeExplorationViewController ()

@end

@implementation RuntimeExplorationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RPerson *person = [[RPerson alloc]init];
    RStudent *student = [[RStudent alloc]init];
    
    [student say];
}

#pragma mark - 动态方法解析
+(BOOL)resolveInstanceMethod:(SEL)selector{
    
    return  [super resolveInstanceMethod:selector];
}


+(BOOL)resolveClassMethod:(SEL)selector{
    
    return  [super resolveClassMethod:selector];
}





@end
