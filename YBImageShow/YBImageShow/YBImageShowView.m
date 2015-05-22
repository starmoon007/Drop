//
//  YBImageShowView.m
//  YBImageShow
//
//  Created by 杨彬 on 15/5/8.
//  Copyright (c) 2015年 macbook air. All rights reserved.
//

#import "YBImageShowView.h"

#import "YBImageThumbnailCell.h"
#import "YBImageThumbnailLayout.h"

#import "YBImageAlbumView.h"


@interface YBImageShowView ()<UICollectionViewDataSource,UICollectionViewDelegate,YBImageAlbumViewDelegate>

@property (weak, nonatomic) UICollectionView * image_collectionView;


@property (strong, nonatomic)  NSLayoutConstraint *image_collectionView_height ;


@property (strong, nonatomic) YBImageThumbnailLayout * layout;


@property (strong, nonatomic) YBImageAlbumView * album_view;



@end

@implementation YBImageShowView










- (void)uiConfig{
    self.layout = [[YBImageThumbnailLayout alloc]init];
    self.layout.itemSize = CGSizeMake(70, 70);
    self.layout.section_Spacing = 5;
    self.layout.row_Spacing = 5;
//    self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView * image_collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.layout];
    image_collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    image_collectionView.dataSource = self;
    image_collectionView.delegate = self;
    image_collectionView.backgroundColor = [UIColor whiteColor];
    
    
    [image_collectionView registerNib:[UINib nibWithNibName:@"YBImageThumbnailCell" bundle:nil] forCellWithReuseIdentifier:@"YBImageThumbnailCell"];
    image_collectionView.collectionViewLayout = self.layout;
    
    [self addSubview:image_collectionView];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:image_collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    [self addConstraint:leading];
    
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:image_collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self addConstraint:top];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:image_collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self addConstraint:width];
    
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:image_collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:100];
    [image_collectionView addConstraint:height];
    self.image_collectionView_height = height;
    
    self.image_collectionView = image_collectionView;
    
}


#pragma mark - UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YBImageThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YBImageThumbnailCell" forIndexPath:indexPath];
    
    YBImageModel *image_model = self.image_model_array[indexPath.row];
    
    cell.image_model = image_model;
    
    if (indexPath.row == 0){
        CGSize size = self.image_collectionView.contentSize;
        if (size.height != self.image_collectionView_height.constant && size.height != 0){
            self.image_collectionView_height.constant = size.height;
            if (self.frame.size.height < size.height){
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height);
            }
        }
    }
    
    return cell;
}




-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.image_model_array.count;
}



#pragma mark - UICollectionViewDelegate


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.album_view showImageWithImage_model_array:self.image_model_array andIndex:indexPath.row];
    return;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    YBImageModel *image_model = self.image_model_array[indexPath.row];
    
    UIView *view = image_model.current_view;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect rect = [window convertRect:view.frame fromView:view.superview];
    image_model.thumbmail_frame = CGRectMake(rect.origin.x, rect.origin.y, self.layout.itemSize.width, self.layout.itemSize.height);
}



-(void)setImage_model_array:(NSMutableArray *)image_model_array{
    _image_model_array = image_model_array;
    
    [self.image_collectionView reloadData];
    
}


-(YBImageAlbumView *)album_view{
    
    if (_album_view == nil){
        _album_view = [[YBImageAlbumView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _album_view.delegate = self;
    }
    
    return _album_view;
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



@end
