//
//  VSAViewController.m
//  VSAPageControl
//
//  Created by alvin on 15/9/10.
//  Copyright (c) 2015年 alvin. All rights reserved.
//  仿锤子手机分页按钮

#import "VSAViewController.h"

#define interDis 20
#define pageCount 4

@interface VSAViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIView *moveView;
@property (nonatomic, weak) UIView *firstView;
@end

@implementation VSAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, 375, 500);
    scrollView.backgroundColor = [UIColor whiteColor];
    
    for (int i=0; i<pageCount; i++) {
        UIView *view = [[UIView alloc] init];
        UIColor *color = [UIColor lightGrayColor];

        view.backgroundColor = color;
        [scrollView addSubview:view];
        
        view.frame = CGRectMake(i * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
    }
    
    scrollView.contentSize = CGSizeMake(pageCount * scrollView.bounds.size.width, scrollView.bounds.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    [self.view addSubview:scrollView];
    
    CGFloat startX = (self.view.bounds.size.width - interDis * (pageCount * 2 -1)) / 2;
    for (int i = 0; i<pageCount * 2; i++) {
        UIView *view;
        if (i % 2 == 0) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            CGRect rect = view.frame;
            rect.origin.x = startX + i * interDis;
            rect.origin.y = 280;
            view.frame = rect;
            
            view.backgroundColor = [UIColor greenColor];
            [self.view insertSubview:view atIndex:1];
        }
        
        
        if (i == 0) {
            self.firstView = view;
            
            UIView *moveView = [[UIView alloc] init];
            moveView.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.bounds.size.width, view.bounds.size.height);
            moveView.backgroundColor = [UIColor blackColor];
            
            self.moveView = moveView;
            [self.view addSubview:moveView];
        }
        
        if (i % 2 == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            CGRect rect = view.frame;
            rect.origin.x = startX + i * interDis;
            rect.origin.y = 280;
            view.frame = rect;
            
            view.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:view];
        }
    }
    
    //添加第一个前边的方框
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    CGRect rect = view.frame;
    rect.origin.x = startX - interDis;
    rect.origin.y = 280;
    view.frame = rect;
    
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat percent = offsetX / 375.0;
    
    CGRect rect = self.moveView.frame;
    CGFloat originX = self.firstView.frame.origin.x;
    rect.origin.x = originX + interDis * 2 * percent;
    self.moveView.frame = rect;
    NSLog(@"%f", percent);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
