//
//  ViewController.m
//  开飞机_代码版
//
//  Created by  chenhanmao on 16/8/28.
//  Copyright © 2016年  chenhanmao. All rights reserved.
//

#import "ViewController.h"
typedef enum{
    HMDirTop = 101,
    HMDirLeft = 102,
    HMDirRight= 103,
    HMDirBottom = 104
}HMDir;

@interface ViewController ()
@property(nonatomic,weak)UIButton *planeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    
}
/**
 * 创建界面
 */
-(void) setupUI{
//       创建图框UIImageView
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.frame = self.view.frame; //图框大小
//    插入背景图片UIImage（定位，大小）
    UIImage *bgImage = [UIImage imageNamed:@"background"];
    bgView.image = bgImage;
    [self.view addSubview:bgView];    //添加到根视图中
    
//    新建飞机按钮，属性，大小，位置
    UIButton *planeButton = [[UIButton alloc]init];
    self.planeButton = planeButton;
    
//    导入图片
    UIImage *planeNorImg = [UIImage imageNamed:@"hero1"];
    [planeButton setImage:planeNorImg forState:UIControlStateNormal];
    
    UIImage *planeHighImg = [UIImage imageNamed:@"hero2"];
    [planeButton setImage:planeHighImg forState:UIControlStateHighlighted];
    
    [planeButton sizeToFit];    //大小调节
    planeButton.center = bgView.center;    //定位
    
    
//    [planeButton addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:planeButton];   //添加到根视图中
    
    
//    新建方向按钮，大小，位置，行为
    CGFloat offsetPoint = 40;
    [self setHMDirTypeWithDir:@"top" andOffset:CGPointMake(0, -offsetPoint) andTag:101];
    [self setHMDirTypeWithDir:@"left" andOffset:CGPointMake(-offsetPoint, 0) andTag:102];
    [self setHMDirTypeWithDir:@"right" andOffset:CGPointMake(offsetPoint, 0) andTag:103];
    [self setHMDirTypeWithDir:@"bottom" andOffset:CGPointMake(0, offsetPoint) andTag:104];

}

-(void)setHMDirTypeWithDir:(NSString *)dir andOffset:(CGPoint)offset andTag:(NSUInteger)tag{
//    方向按钮的参考点
    CGPoint keyPoint = CGPointMake(self.view.center.x, self.view.center.y+200);
    
//    新建一个方法按键
    UIButton *dirButton = [[UIButton alloc]init];
    
//    导入图片
    UIImage *dirNorImg =[UIImage imageNamed:[dir stringByAppendingString:@"_normal"]];
    [dirButton setImage:dirNorImg forState:UIControlStateNormal];
    
    UIImage *dirHighImg =[UIImage imageNamed:[dir stringByAppendingString:@"_highlighted"]];
    [dirButton setImage:dirHighImg forState:UIControlStateHighlighted];
    
    dirButton.frame = CGRectMake(0, 0, 40, 40);   //按钮大小

    dirButton.center = keyPoint;     //按钮位置
    
    dirButton.frame = CGRectOffset(dirButton.frame, offset.x, offset.y); //偏移
    
    dirButton.tag = tag;
    
    
//    添加事件
    [dirButton addTarget:self action:@selector(clickedDirButton:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:dirButton];    //添加到根目录
}

-(void)clickedDirButton:(UIButton *)sender{
    //获得飞机的位置
    CGRect frame = self.planeButton.frame;
    
    //修改飞机的位置
    float offset = 30;
    switch (sender.tag) {
        case HMDirTop:
            frame.origin.y-=offset;
            break;

        case HMDirLeft:
            frame.origin.x-=offset;
            break;
    
        case HMDirRight:
            frame.origin.x+=offset;
            break;
        
        case HMDirBottom:
            frame.origin.y+=offset;
            break;
    }
    //修改后的位置重新赋予飞机
    self.planeButton.frame = frame;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
