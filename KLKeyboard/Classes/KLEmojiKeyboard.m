//
//  KLEmojiKeyboard.m
//  KLKeyboard
//
//  Created by Kalan on 2019/12/21.
//

#import "KLEmojiKeyboard.h"
@import KLCategory;
@import Masonry;

@interface KLEmojiPackageCell : UICollectionViewCell

@property (strong, nonatomic) UIButton *item;

@end

@implementation KLEmojiPackageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.item = [UIButton buttonWithType:UIButtonTypeCustom];
        self.item.userInteractionEnabled = NO;
        [self.item setBackgroundImage:KLImageColor(UIColor.clearColor) forState:UIControlStateNormal];
        [self.item setBackgroundImage:KLImageColor(UIColor.whiteColor) forState:UIControlStateSelected];
        self.item.layer.cornerRadius = 5;
        self.item.layer.masksToBounds = YES;
        [self.contentView addSubview:self.item];
        [self.item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }
    return self;
}

@end

@interface KLEmojiKeyboard () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSIndexPath *currentIndex;

@end

@implementation KLEmojiKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.kl_keyboardHeight = 300;
        
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.alloc.init;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        self.collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(self.collectionView.mas_width).multipliedBy(1/7.5);
        }];
        [self.collectionView registerClass:KLEmojiPackageCell.class forCellWithReuseIdentifier:KLEmojiPackageCell.description];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLEmojiPackageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLEmojiPackageCell.description forIndexPath:indexPath];
    [cell.item setImage:[UIImage imageNamed:@"kl_emoji"] forState:UIControlStateNormal];
    if (self.currentIndex) {
        cell.item.selected = indexPath.row == self.currentIndex.row;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat temp = collectionView.bounds.size.width / 7.5;
    return CGSizeMake(temp, temp);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    if (indexPath.row < 5) {
        // 固定功能
        switch (indexPath.row) {
            case 0:
                NSLog(@"设置");
                break;
            case 1:
                NSLog(@"添加");
                break;

            case 2:
                NSLog(@"emoji");
                break;

            case 3:
                NSLog(@"收藏");
                break;
                   
            default:
                NSLog(@"自拍");
                break;
        }
    } else {
        // 选择表情包
        KLEmojiPackageCell *cell1 = (KLEmojiPackageCell *)[collectionView cellForItemAtIndexPath:self.currentIndex];
        cell1.item.selected = NO;
        KLEmojiPackageCell *cell2 = (KLEmojiPackageCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell2.item.selected = YES;
        self.currentIndex = indexPath;
        [collectionView reloadData];
    }
}

@end
