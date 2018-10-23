//
//  StateTableView.m
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

#import "StateTableView.h"
#import "StateTableView+ErrorMessages.h"

#define currentStateKeyPath @"currentState"

@interface StateTableView () <UITableViewDataSource>

@property (nonatomic) UITableViewCellSeparatorStyle currSeparatorStyle;

@end

@implementation StateTableView

// MARK: Lifecycle Methods

- (id)init {
    if (self = [super init]) {
        self.currentState = TableViewStateEmpty;
        self.useDefaultErrors = YES;
    }
    return self;
}
/*
- (void)dealloc {
    [self removeObserver:self forKeyPath:currentStateKeyPath];
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
}


// MARK: Custom Setter Methods

// set data source when delegate is set
- (void)setStateDelegate:(id<StateTableViewProtocol>)stateDelegate {
    _stateDelegate = stateDelegate;
    _currSeparatorStyle = self.separatorStyle;
    self.dataSource = self;
}

// update the table each time the state changes
- (void)setCurrentState:(TableViewState)currentState {
    _currentState = currentState;
    [self reloadTableData];
}

// MARK: UITableView Data Source Methods

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.stateDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

@end
