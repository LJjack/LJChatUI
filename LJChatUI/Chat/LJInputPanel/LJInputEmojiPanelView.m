//
//  LJInputEmojiPanelView.m
//  LJChatUI
//
//  Created by 刘俊杰 on 2016/11/29.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LJInputEmojiPanelView.h"
#import "LJInputEmojiPanelPageView.h"
#import "UIImage+LJColor.h"
#import <Masonry/Masonry.h>

@interface LJInputEmojiPanelView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, strong) UIScrollView *bottomScrollView;

@property (nonatomic, strong) UIButton *sendButton;

//@property (nonatomic,strong)GJGCChatInputExpandEmojiPanelMenuBar *menuBar;

@property (nonatomic,assign)BOOL isFinishLoadEmoji;

@end

@implementation LJInputEmojiPanelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    UIView *topSeprateLine = [[UIView alloc]init];
    topSeprateLine.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
    [self addSubview:topSeprateLine];
    
    UIView *bottomSeprateLine = [[UIView alloc]init];
    bottomSeprateLine.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
    [self addSubview:bottomSeprateLine];
    
    [self addSubview:self.bottomScrollView];
    [self addSubview:self.sendButton];
    
    __weak __typeof(self) weakSelf = self;
    
    [topSeprateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.width.mas_equalTo(weakSelf);
        make.height.mas_equalTo(@0.5);
    }];
    [bottomSeprateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bottomScrollView);
        make.width.mas_equalTo(weakSelf);
        make.height.mas_equalTo(@0.5);
    }];
    [self scrollViewAddAllEmojis];
    
    [self setupLayout];
}

- (void)setupLayout {
    __weak __typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf);
        make.trailing.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.sendButton.mas_top);
    }];

    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf);
        make.height.mas_equalTo(@37);
        make.bottom.mas_equalTo(weakSelf.scrollView);
    }];
    
    [self.bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf);
        make.trailing.mas_equalTo(weakSelf.sendButton.mas_leading);
        make.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(weakSelf.sendButton);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf);
        make.trailing.mas_equalTo(weakSelf);
        make.height.mas_equalTo(@40.5);
        make.width.mas_equalTo(@72);
    }];
    
}

- (void)scrollViewAddAllEmojis {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
    NSArray *emojiArray = [NSArray arrayWithContentsOfFile:path];
    
    NSInteger pageItemCount = 20;
    
    /* 分割页面 */
    NSMutableArray *pagesArray = [NSMutableArray array];
    
    self.pageCount = emojiArray.count % pageItemCount == 0 ? emojiArray.count/pageItemCount:emojiArray.count/pageItemCount+1;
    self.pageControl.numberOfPages = self.pageCount;
    NSInteger pageLastCount = emojiArray.count%pageItemCount;
    
    for (int i = 0; i < self.pageCount; i++) {
        NSMutableArray *pageItemArray = [NSMutableArray array];
        if (i != self.pageCount - 1) {
            
            [pageItemArray addObjectsFromArray:[emojiArray subarrayWithRange:NSMakeRange(i*pageItemCount,pageItemCount)]];
            [pageItemArray addObject:@{@"删除":@"删除"}];
        }else{
            [pageItemArray addObjectsFromArray:[emojiArray subarrayWithRange:NSMakeRange(i*pageItemCount, pageLastCount)]];
        }
        [pagesArray addObject:pageItemArray];
    }
    
    /* 创建 */
    for (int i = 0; i < pagesArray.count ; i++) {
        NSArray *pageNamesArray = [pagesArray objectAtIndex:i];
        
        LJInputEmojiPanelPageView *pageItem = [[LJInputEmojiPanelPageView alloc] initWithEmojiNames:pageNamesArray];
//        pageItem.panelIdentifier = self.panelIdentifier;
        
//        pageItem.tag = GJGCChatInputExpandEmojiPanelPageTag + i;
        
        [self.scrollView addSubview:pageItem];
    }
    
//    self.scrollView.contentSize = CGSizeMake(self.pageCount * [UIScreen mainScreen].bounds.size.width, self.scrollView.gjcf_height);
}

#pragma mark - Actions

- (void)pageIndexChange:(UIPageControl *)sender {
//    CGRect visiableRect = CGRectMake(self.scrollView.gjcf_width * self.pageControl.currentPage, 0, self.scrollView.gjcf_width, self.scrollView.gjcf_height);
//    [self.scrollView scrollRectToVisible:visiableRect animated:YES];
}

- (void)sendEmojiAction {
//    NSString *formateNoti = [GJGCChatInputConst panelNoti:GJGCChatInputExpandEmojiPanelChooseSendNoti formateWithIdentifier:self.panelIdentifier];
//    [[NSNotificationCenter defaultCenter] postNotificationName:formateNoti object:nil];
}

#pragma mark - Getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageIndexChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] init];
        _bottomScrollView.delegate = self;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.pagingEnabled = YES;
    }
    return _bottomScrollView;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendButton setBackgroundImage:[UIImage lj_imageWithColor:[UIColor colorWithRed:90/255.0 green:208/255.0 blue:252/255.0 alpha:1.0]] forState:UIControlStateNormal];
        
        [_sendButton addTarget:self action:@selector(sendEmojiAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

@end
