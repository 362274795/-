//
//  LCScorllowView.m
//  轮播封装
//
//  Created by lc on 16/7/26.
//  Copyright © 2016年 lcnicky. All rights reserved.
//

#import "LCScorllowView.h"
#define LC_WIDTH self.frame.size.width

@interface LCScorllowView()<UIScrollViewDelegate>{
    id _target;
    SEL _action;
}
/**滚轮*/
@property (nonatomic,strong)UIScrollView *scrollowView;
/**分页控制器*/
@property (nonatomic,strong)UIPageControl *pageController;
/**当前页码数*/
@property (nonatomic,assign)NSInteger currentPage;
/**定时器*/
@property (nonatomic,strong)NSTimer *timer;
/**图片的数量*/
@property (nonatomic,assign)NSInteger count ;

@end

@implementation LCScorllowView
#pragma mark - 懒加载
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(go) userInfo:nil repeats:YES];
        //获取当前的runloop
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        //设置优先级
        [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return _timer ;
}
#pragma mark - 重写set方法
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    if (timeInterval <= 0) {
        return;
    }
    _timeInterval = timeInterval;
    // 销毁上一次的定时器
    [self.timer invalidate];
    self.timer = nil;
    // 开启新的定时器
    [self timer];
}
//MARK:设置背景颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor ;
    self.pageController.pageIndicatorTintColor = _backgroundColor ;
}
//MARK:设置前景颜色
- (void)setForegroundColor:(UIColor *)foregroundColor{
    _foregroundColor = foregroundColor ;
    self.pageController.currentPageIndicatorTintColor = foregroundColor ;
}
//MARK:设置当前页
- (void)setCurrentPage:(NSInteger)currentPage{
    
    if (currentPage < 0 || currentPage >= self.count) {
        return ;
    }
    _currentPage = currentPage ;
    self.pageController.currentPage = currentPage;
    self.scrollowView.contentOffset = CGPointMake(LC_WIDTH * (self.currentPage + 1), 0);
}

#pragma mark - 定时器里面的方法
- (void)go{
    NSInteger page = self.pageController.currentPage + 1 ;
    [self.scrollowView setContentOffset:CGPointMake(page * LC_WIDTH + LC_WIDTH, 0) animated:YES];
}
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)images{
    if (self = [super initWithFrame:frame]) {
        //实例化轮播
        self.scrollowView = [[UIScrollView alloc]initWithFrame:frame];
        //关闭弹簧效果
        _scrollowView.bounces = NO ;
        //每次滑动一页
        _scrollowView.pagingEnabled = YES ;
        //当前页面
        _currentPage = 0 ;
        _imageArray = images ;
        _count = images.count ;
        //设置代理
        _scrollowView.delegate = self ;
        _scrollowView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollowView] ;
        //实例化分页控制器
        _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollowView.frame.size.height - 20, LC_WIDTH, 20)] ;
        _pageController.alpha = 1 ;
        _pageController.numberOfPages = _count ;
        _scrollowView.userInteractionEnabled = YES ;
        _pageController.userInteractionEnabled = YES ;
        [self addSubview:_pageController] ;
      
    }
    return self;
}

/**
 *  给ScrollowView增加照片
 */
- (void)addImageView{
    //移除每个视图
    for (UIView *view in self.scrollowView.subviews) {
        [view removeFromSuperview];
    }
    
    //设置滑动边距
    _scrollowView.contentSize = CGSizeMake((self.count + 2) * LC_WIDTH, _scrollowView.frame.size.height);
    //设置ScrollowView偏移到指定的位置去
    _scrollowView.contentOffset = CGPointMake((self.currentPage + 1) * LC_WIDTH , 0);
    CGFloat imageW = self.scrollowView.frame.size.width ;
    CGFloat imageH = self.scrollowView.frame.size.height ;
    for (int i = 0 ; i < self.count + 2; i ++ ) {
        
        CGFloat imageX = i * LC_WIDTH ;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, 0, imageW, imageH)];
        imageView.userInteractionEnabled = YES ;
        if (i == 0) {
            [imageView setImage:[UIImage imageNamed:[self.imageArray lastObject]] ] ;
        } else if (i == self.count + 1){
            [imageView setImage:[UIImage imageNamed:[self.imageArray firstObject]] ];
        } else {
            [imageView setImage:[UIImage imageNamed:self.imageArray[i - 1]] ];
        }

        //增加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick)];
        [imageView addGestureRecognizer:tap];
        [self.scrollowView addSubview:imageView ];
     
    }
}
#pragma mark - 自定义方法
- (void) addTarget:(id)target action:(SEL)action
{
    _action = action;
    _target = target;
}
- (void)onClick{
    [_target performSelector:_action withObject:self ];
}


#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [self addImageView];
}

#pragma mark - 滚动协议

/**
 *  非拖拽滚动结束调用：判断是否为循环页
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == (self.count + 1) * LC_WIDTH) {
        scrollView.contentOffset = CGPointMake(LC_WIDTH, 0);
    }else if(scrollView.contentOffset.x == 0){
        scrollView.contentOffset = CGPointMake(LC_WIDTH * self.count , 0);
    }
    //更新pageControl的页码
    double index = self.scrollowView.contentOffset.x / LC_WIDTH;
    self.pageController.currentPage = index - 1;
    // 当前显示的页标
    self.currentPage = self.pageController.currentPage;
    
}

/**
 *  开始拖拽时销毁定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.timer invalidate ];
    self.timer = nil ;
}


/**
 *  拖拽滚动结束
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollowView.contentOffset.x == LC_WIDTH * (self.count + 1)) {
        self.scrollowView.contentOffset = CGPointMake(LC_WIDTH, 0);
    } else if (self.scrollowView.contentOffset.x == 0) {
        self.scrollowView.contentOffset = CGPointMake(LC_WIDTH * self.count, 0);
    }
    
    // 更新pageControl的页码
    double index = scrollView.contentOffset.x / LC_WIDTH;
    self.pageController.currentPage = index - 1;
    
    // 当前显示的页标
    self.currentPage = self.pageController.currentPage;
    // 实例化定时器
    [self timer];
}


/**
 *  拖拽滚动过程中实时更新pageControl的页码（采用四舍五入）
 */

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    double index = scrollView.contentOffset.x / LC_WIDTH;
//    NSInteger page = (index + 0.5) - 1 ;
//    if (page < 0) {
//        page = self.count ;
//    }else if (page < self.count - 1){
//        page = 0  ;
//    }
//    self.pageController.currentPage = page ;
//}


@end
