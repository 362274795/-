
//
//  FLMeViewController.m
//  Go travel
//
//  Created by 千锋 on 16/5/30.
//  Copyright © 2016年 Fingersfive. All rights reserved.
//

#import "FLMeViewController.h"

#import "FLSettingViewController.h"//设置界面

@interface FLMeViewController ()<UITableViewDataSource , UITableViewDelegate>
/**用户图标*/
@property (weak, nonatomic) IBOutlet FLImageView *userIcon;
/**用户姓名*/
@property (weak, nonatomic) IBOutlet UILabel *userName;
/**无用的图片*/
@property (weak, nonatomic) IBOutlet UIView *view1;
/**无用的图片*/
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (strong, nonatomic) IBOutlet UITableView *meTableView;

@end

@implementation FLMeViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:daytimeColor];
    
    //对界面上的一些设置
    [self settingView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - 对界面上的视图的一些设置
-(void) settingView{

    //切圆角
    [_userIcon.layer setCornerRadius:50];
    [_userIcon.layer setMasksToBounds:YES];
    
    
    //设置按无用图片的背景色
    [_view1 setBackgroundColor:daytimeColor];
    [_view2 setBackgroundColor:daytimeColor];
    
    
    
    //给图片添加点击
    [_userIcon addTarget:self Selecter:@selector(onclick)];
    
    
    
    
    
}

#pragma mark - 界面跳转
-(void)onclick{

    //界面跳转

}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) { //实现该界面按钮的点击
        case 2:{ //我的说说
            
            
            break;
        }
        case 3:{ //我的收藏
            
            
            break;
        }
        case 4:{ //个性签名
            
            
            break;
        }
        case 7:{ //意见反馈
            
            
            break;
        }
        case 8:{ //设置界面
            
            //先获取storyboard
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            //通过ID创建视图
            FLSettingViewController * setting = [sb instantiateViewControllerWithIdentifier:@"FLSettingViewController"];
            
            //跳转
            [self.navigationController presentViewController:setting animated:YES completion:^{
                
            }];
            
            
            
            break;
        }
        default:
            break;
    }

}







@end
