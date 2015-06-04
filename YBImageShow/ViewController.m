//
//  ViewController.m
//  YBImageShow
//
//  Created by 杨彬 on 15/5/8.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "ViewController.h"

#import "YBImageShowView.h"




@interface ViewController ()


@property (weak, nonatomic) IBOutlet YBImageShowView *imageShowView;

@property (strong, nonatomic) NSMutableArray * image_model_array;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageShowView.image_model_array = self.image_model_array;
    
}



-(NSMutableArray *)image_model_array{
    
    if (_image_model_array == nil){
        _image_model_array = [[NSMutableArray alloc]init];
        for (int i=0; i<14; i++) {
            YBImageModel *model = [[YBImageModel alloc]init];
//            NSString *imagePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%d",i+1] ofType:@"png"];
//            model.thumbnail_image = [UIImage imageWithContentsOfFile:imagePath];
            NSString *imageName = [NSString stringWithFormat:@"%d",i%3+1];
            model.thumbnail_image = [UIImage imageNamed:imageName];
            [_image_model_array addObject:model];
        }
    }
    return _image_model_array;
}


@end
