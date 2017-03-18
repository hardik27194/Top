//
//  ViewController.m
//  Top
//
//  Created by Jacopo Pappalettera on 18/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "ViewController.h"
#import "Backendless.h"
#import "StickersManager.h"
#import "CCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSArray *stickers;
@property (nonatomic,weak) UICollectionView *collection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataSource];

//    UIButton *reload = [UIButton buttonWithType:UIButtonTypeCustom];
//    reload.frame = CGRectMake(0, 20, self.view.bounds.size.width, 50);
//    [reload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [reload addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
//    [reload setTitle:@"reload" forState:UIControlStateNormal];
//    [self.view addSubview:reload];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;

    UICollectionView  *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    self.collection = collectionView;
    UINib *nib = [UINib nibWithNibName:@"CCell" bundle:[NSBundle mainBundle]];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
}
-(void)reloadAction{
    [self loadDataSource];
    [self.collection reloadData];
}
-(void)loadDataSource{
    StickersManager *sManager = [[StickersManager alloc]init];
    self.stickers = [sManager loadAllStickers];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Sticker *sticker = self.stickers[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:240.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1];
    cell.title.text = sticker.title;
    cell.desc.text = sticker.desc;
    cell.number.text = [NSString stringWithFormat:@"%i",(int)sticker.number];
    cell.image.image = [UIImage imageNamed:@"placeholder"];
    dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);
    dispatch_async(imageQueue, ^{
        NSURL *url = [NSURL URLWithString:sticker.image];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.image.image = [[UIImage alloc] initWithData:data];
        });
    });
    cell.layer.cornerRadius = 5;
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.stickers.count;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(40, 10, 10, 10);
}
#pragma mark - responder

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
