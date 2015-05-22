//
//  YBImageModel.m
//  YBImageShow
//
//  Created by 杨彬 on 15/5/11.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBImageModel.h"


@interface YBImageModel ()



@end

@implementation YBImageModel

-(void)setCurrent_view:(UIView *)current_view{
    _current_view = current_view;
    
    _super_view = [current_view superview];
    
}


@end
