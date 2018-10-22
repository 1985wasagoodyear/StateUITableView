//
//  StateTableView.m
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

#import "StateTableView.h"

#define currentStateKeyPath @"currentState"

@interface StateTableView () <UITableViewDataSource>

@end

@implementation StateTableView

- (id)init {
    if (self = [super init])  {
        self.currentState = TableViewStateEmpty;
        self.dataSource = self;
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:currentStateKeyPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

// MARK: KVO Implementation for simple binding to tableView's state changes

- (void)setStateDelegate:(id<StateTableViewProtocol>)stateDelegate {
    [self addObserver:self
           forKeyPath:currentStateKeyPath
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:currentStateKeyPath] == YES) {
        [self reloadData];
    }
}

- (void)reloadData {
    switch (self.currentState) {
        case TableViewStateLoading:
            [self showEmptyMessage:@"Loading"];
            break;
        case TableViewStateError:
            [self showEmptyMessage:@"Error"];
            break;
        case TableViewStateEmpty:
            [self showEmptyMessage:@"Empty"];
            break;
        default:
            [self hideSpecialMessage];
            break;
    }
    [super reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger num = 0;
    switch (self.currentState) {
        case TableViewStateLoading:
        case TableViewStateError:
        case TableViewStateEmpty:
            // show some error here
            break;
        default: // TableViewStateLoaded:
            num = [self.stateDelegate numberOfSectionsInTableView:tableView];
            break;
    }
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 0;
    switch (self.currentState) {
        case TableViewStateLoading:
        case TableViewStateError:
        case TableViewStateEmpty:
            // show some error here
            break;
        default: // TableViewStateLoaded:
            num = [self.stateDelegate tableView:tableView numberOfRowsInSection:section];
            break;
    }
    return num;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.stateDelegate tableView:self cellForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.stateDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

// https://stackoverflow.com/questions/15746745/handling-an-empty-uitableview-print-a-friendly-message
- (void)showEmptyMessage:(NSString *)string {
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:rect];
    messageLabel.text = string;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:12.0]; //UIFont(name: "TrebuchetMS", size: 15)
    [messageLabel sizeToFit];
    
    self.backgroundView = messageLabel;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)hideSpecialMessage {
    self.backgroundView = nil;
    self.separatorStyle = self.stateDelegate.separatorStyle;
}

@end
