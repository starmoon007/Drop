//
//  YBImageOriginalCell.m
//  YBImageShow
//
//  Created by 杨彬 on 15/5/11.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBImageOriginalCell.h"

#import "YBImageModel.h"

#import "UIImageView+WebCache.h"


@interface YBImageOriginalCell ()




@end

@implementation YBImageOriginalCell


-(void)setImage_model:(YBImageModel *)image_model{
    _image_model = image_model;
    
    UIImage *original_image = nil;
    if (_image_model.original_image != nil){
        original_image = _image_model.original_image;
    }else if (_image_model.original_local_path != nil){
        original_image = [UIImage imageWithContentsOfFile:_image_model.original_local_path];
    }else if (_image_model.original_url != nil){
        [self.original_imageView setImageWithURL:[NSURL URLWithString:_image_model.original_url] placeholderImage:nil];
        original_image = self.original_imageView.image;
    }
    
    if (original_image != nil){
        self.original_imageView.image = original_image;
    }else{
        // 做自己的网络请求。。。 （很多下载图片的方式是不能用SDWebImage 的 ）
        self.original_imageView.image = _image_model.thumbnail_image;
    }
    
}

- (void)awakeFromNib {
    self.original_imageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
