//
//  wbNewFeatureController.m
//  weibo
//
//  Created by 王涛 on 2016/10/26.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "wbNewFeatureController.h"
#import "wbNewFeatureCell.h"

@interface wbNewFeatureController ()

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation wbNewFeatureController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[wbNewFeatureCell class] forCellWithReuseIdentifier:ID];

    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self setupPageControl];
}

-(void)setupPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.9);
    _pageControl = pageControl;
    
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollView代理，只要一滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    _pageControl.currentPage = page;
}

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    wbNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
