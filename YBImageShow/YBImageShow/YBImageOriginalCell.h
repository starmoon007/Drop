//
//  YBImageOriginalCell.h
//  YBImageShow
//
//  Created by 杨彬 on 15/5/11.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBImageModel;

@interface YBImageOriginalCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *original_imageView;

@property (strong, nonatomic) YBImageModel * image_model;

@end
