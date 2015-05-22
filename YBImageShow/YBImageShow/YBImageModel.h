//
//  YBImageModel.h
//  YBImageShow
//
//  Created by 杨彬 on 15/5/11.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YBImageModel : NSObject

@property (strong, nonatomic) UIImage * thumbnail_image;

@property (strong, nonatomic) UIImage * original_image;


@property (copy, nonatomic) NSString * thumbmail_url;

@property (copy, nonatomic) NSString * original_url;


@property (copy, nonatomic) NSString * thumbmail_local_path;

@property (copy, nonatomic) NSString * original_local_path;


@property (strong, nonatomic,readonly) UIView * super_view;

@property (strong, nonatomic) UIView * current_view;


@property (assign, nonatomic) CGRect thumbmail_frame;



@end
