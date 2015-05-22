//
//  YBImageThumbnailCell.m
//  YBImageShow
//
//  Created by 杨彬 on 15/5/11.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBImageThumbnailCell.h"

#import "YBImageModel.h"
#import "UIImageView+WebCache.h"



@interface YBImageThumbnailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail_imageView;



@end

@implementation YBImageThumbnailCell



-(void)setImage_model:(YBImageModel *)image_model{
    _image_model = image_model;
    
    UIImage *thumbnail_image = nil;
    if (_image_model.thumbnail_image != nil){
        thumbnail_image = _image_model.thumbnail_image;
    }else if (_image_model.thumbmail_local_path != nil){
        thumbnail_image = [UIImage imageWithContentsOfFile:_image_model.thumbmail_local_path];
    }else if (_image_model.thumbmail_url != nil){
        [self.thumbnail_imageView setImageWithURL:[NSURL URLWithString:_image_model.thumbmail_url] placeholderImage:nil];
        thumbnail_image = self.thumbnail_imageView.image;
    }
    
    if (thumbnail_image != nil){
        self.thumbnail_imageView.image = thumbnail_image;
    }else{
        // 做自己的网络请求。。。 （很多下载图片的方式是不能用SDWebImage 的 ）
        
    }
    
    _image_model.current_view = self.thumbnail_imageView;
    

}


- (void)awakeFromNib {
    
}

@end
