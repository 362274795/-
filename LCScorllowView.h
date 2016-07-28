//
//  LCScorllowView.h
//  轮播封装
//
//  Created by lc on 16/7/26.
//  Copyright © 2016年 lcnicky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCScorllowView : UIView

/**背景颜色*/
@property (nonatomic,strong)UIColor *backgroundColor;

/**前景颜色*/
@property (nonatomic,strong)UIColor *foregroundColor;

/**图片数组*/
@property (nonatomic,strong)NSMutableArray *imageArray ;

/**轮播高度*/
@property (nonatomic,assign)NSUInteger *scrollowHeight;

/**轮播的时间间隔*/
@property (nonatomic,assign)NSTimeInterval timeInterval;


/**初始化方法*/
- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)images ;

/**添加点击响应时间*/
- (void)addTarget:(id)target action:(SEL)action;
@end
