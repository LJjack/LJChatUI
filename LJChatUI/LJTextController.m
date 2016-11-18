//
//  LJTextController.m
//  LJChatView
//
//  Created by 刘俊杰 on 2016/11/17.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJTextController.h"
#import "LJShowImageController.h"
#import "LJMapController.h"

#import "LJTextElemCell.h"

@interface LJTextController ()<LJElemCellDelegate>

@property (nonatomic, copy) NSArray *listData;

@end

@implementation LJTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listData = @[@"senderTextElemCell",@"receiverTextElemCell",
                      @"senderImageElemCell",@"receiverImageElemCell",
                      @"senderSoundElemCell",@"receiverSoundElemCell",
                      @"senderLocationElemCell",@"receiverLocationElemCell",
                      @"senderVideoElemCell",@"receiverVideoElemCell"];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = self.listData[indexPath.row];
    LJElemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                           forIndexPath:indexPath];
    cell.delegate = self;
    if ([identifier containsString:@"TextElemCell"]) {
        [(LJTextElemCell *)cell setText:[[NSAttributedString alloc] initWithString:@"is发撒开发商打离开房间爱是否是打发大家撒放空间撒飞机，撒酒疯洒落的法律；发，爱上了；fjasfs.dfk是大风蓝色方面是否考虑啥地方第三方拉舒服死了大佛的麻烦啥地方是范德萨"]];

    }
    cell.isSelfBubble = indexPath.row % 2 == 0;
    
    return cell;
}

#pragma mark - LJElemCellDelegate

- (void)elemCell:(LJElemCell *)cell didTapBubbleIndexPath:(NSIndexPath *)indexPath {
    
}

@end
