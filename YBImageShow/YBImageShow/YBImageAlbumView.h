//
//  YBImageAlbumView.h
//  YBImageShow
//
//  Created by 杨彬 on 15/5/11.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YBImageAlbumViewDelegate <NSObject>



@end

@interface YBImageAlbumView : UIView

@property (assign, nonatomic) id <YBImageAlbumViewDelegate>delegate;

- (void)showImageWithImage_model_array:(NSArray *)image_model_array andIndex:(NSInteger)index;

@end
