//
//  ViewController.m
//  TblRelayout
//
//  Created by Cindy on 2018/12/28.
//  Copyright © 2018年 Cindy. All rights reserved.
//

#import "ViewController.h"
#import "TTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ViewController()
{
    NSMutableArray *urlList;
    NSMutableDictionary *sizeMap;
    int defaultH;
}
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
     
    [self.tableView registerNib:[UINib nibWithNibName:@"TTableCell" bundle:nil] forCellReuseIdentifier:@"TTableCell"];
    
    urlList = [NSMutableArray new];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/vjsvhwljobezz20/27216462-square-wallpapers.jpg"];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/lcwjp9fwocofg2u/1483393900304.jpg"];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/2qbxqnr1l8q7mia/oie_8IWPRCm-16x40.jpg"];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/v5ukpp8lmphbg2o/w2izN1600x1700.jpg"];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/pc48489vipxmxgh/giphy-7.gif"];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/xz34okugp614lpk/oceanside-cliffs-of-ireland_925x.jpg"];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/4v34f8ycxvqfm14/dropbox_vlg_arch_01_05_interiordeco_bedroom01.png"];
    [urlList addObject:@"https://dl.dropboxusercontent.com/s/27th3kbv343issp/giphy-1.gif"];
    
    sizeMap = [NSMutableDictionary new];
    
    defaultH = 124;
    
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [sizeMap objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
    if (obj)
    {
        CGSize size = [obj CGSizeValue];
        return size.height;
    }
    return defaultH;
}

#pragma mark - TableViewDataSource
- (void)configHeight:(NSInteger)index Img:(UIImage*)image
{
    float ratio = image.size.height / image.size.width;
    CGSize size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width * ratio);
    [sizeMap setObject:[NSValue valueWithCGSize:size] forKey:[NSString stringWithFormat:@"%ld", index]];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return urlList.count;
}
    
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    __block NSInteger row = indexPath.row;
    __weak ViewController* wself = self;
    TTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TTableCell"];
    NSURL *url = [NSURL URLWithString:[urlList objectAtIndex:indexPath.row]];
    [cell.imgView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image)
        {
            [wself configHeight:row Img:image];
        }
    }];
    return cell;
}
@end
