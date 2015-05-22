//
//  YBImageAlbumView.m
//  YBImageShow
//
//  Created by 杨彬 on 15/5/11.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBImageAlbumView.h"

#import "YBImageModel.h"

#import "YBImageOriginalCell.h"


@interface YBImageAlbumView ()<UICollectionViewDataSource, UICollectionViewDelegate>


@property (strong, nonatomic) UICollectionView * image_collectionView;

@property (strong, nonatomic) NSArray * image_model_array;



@end

@implementation YBImageAlbumView

- (void)showImageWithImage_model_array:(NSArray *)image_model_array andIndex:(NSInteger)index{
    self.image_model_array = image_model_array;
    
    YBImageModel *image_model = image_model_array[index];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:self];
    
    self.image_collectionView.contentOffset = CGPointMake(window.bounds.size.width * index , 0);
    self.alpha = 0;
    self.image_collectionView.hidden = YES;
    
    
    UIImageView *view = (UIImageView *)image_model.current_view;
    
    CGRect rect = [window convertRect:view.frame fromView:view.superview];
    
    UIImageView *shadow_view = [[UIImageView alloc]initWithFrame:rect];
    shadow_view.image = view.image;
    [window addSubview:shadow_view];
    view.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        shadow_view.contentMode = UIViewContentModeScaleAspectFit;
        shadow_view.frame = CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height);
        shadow_view.center = window.center;
    }completion:^(BOOL finished) {
        self.image_collectionView.hidden = NO;
        [shadow_view removeFromSuperview];
        view.hidden = NO;
    }];
}




- (void)uiConfig{
    self.backgroundColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    UICollectionView *collection_view = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collection_view.dataSource = self;
    collection_view.delegate = self;
    collection_view.backgroundColor = [UIColor blackColor];
    collection_view.collectionViewLayout = layout;
    collection_view.pagingEnabled = YES;
    collection_view.alwaysBounceHorizontal = YES;
    collection_view.showsHorizontalScrollIndicator = NO;
    [collection_view registerNib:[UINib nibWithNibName:@"YBImageOriginalCell" bundle:nil] forCellWithReuseIdentifier:@"YBImageOriginalCell"];
    [self addSubview:collection_view];
    self.image_collectionView = collection_view;
}






#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YBImageOriginalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YBImageOriginalCell" forIndexPath:indexPath];
    YBImageModel *image_model = self.image_model_array[indexPath.row];
    cell.image_model = image_model;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.image_model_array.count;
}


#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YBImageOriginalCell *cell = (YBImageOriginalCell *)[collectionView cellForItemAtIndexPath:indexPath];
    YBImageModel *image_model = self.image_model_array[indexPath.row];
    
    
    UIImageView *current_imageView = cell.original_imageView;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [window convertRect:current_imageView.frame fromView:current_imageView.superview];
    
    UIImageView *shadow_view = [[UIImageView alloc]initWithFrame:rect];
    shadow_view.contentMode = current_imageView.contentMode;
    shadow_view.image = current_imageView.image;
    [window addSubview:shadow_view];
    
    self.image_collectionView.hidden = YES;
    image_model.current_view.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        shadow_view.frame = image_model.thumbmail_frame;
        self.alpha = 0;
        
    }completion:^(BOOL finished) {
        image_model.current_view.hidden = NO;
        [shadow_view removeFromSuperview];
        self.alpha = 1;
        self.image_collectionView.hidden = NO;
        [self removeFromSuperview];
    }];
    
    
}




-(void)setImage_model_array:(NSArray *)image_model_array{
    _image_model_array = image_model_array;
    
    
    
    
    [self.image_collectionView reloadData];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self uiConfig];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self uiConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiConfig];
    }
    return self;
}


@end
