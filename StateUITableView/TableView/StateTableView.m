//
//  StateTableView.m
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

#import "StateTableView.h"
#import "StateTableView+ErrorMessages.h"

@interface StateTableView () <UITableViewDataSource>

@property (nonatomic) SeparatorStyle currSeparatorStyle;

@end

@implementation StateTableView

// MARK: Lifecycle Methods

- (id)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.currentState = TableViewStateEmpty;
    
    _useDefaultErrors = YES;
    [self addObserver:self
           forKeyPath:@"separatorStyle"
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"separatorStyle"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"separatorStyle"]
        && self.currentState != TableViewStateLoaded
        && self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        SeparatorStyle style = (SeparatorStyle)change[NSKeyValueChangeNewKey];
        _currSeparatorStyle = style;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

// MARK: Custom Setter Methods

// set data source when delegate is set
- (void)setStateDelegate:(id<StateTableViewProtocol>)stateDelegate {
    _stateDelegate = stateDelegate;
    _currSeparatorStyle = self.separatorStyle;
    self.dataSource = self;
    [self reloadTableData];
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
