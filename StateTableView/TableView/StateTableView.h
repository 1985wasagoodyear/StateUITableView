//
//  StateTableView.h
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateEnum.h"
#import "StateTableViewProtocol.h"
#import "StateTableViewErrorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/// Tableview with handling for different states
@interface StateTableView : UITableView

/// Superview should change this to display different states of tableView.
@property (nonatomic) TableViewState currentState;

/// Set YES to use faults, set NO when implementing StateTableViewErrorProtocol methods.
@property BOOL useDefaultErrors;

@property (nonatomic, weak) id<StateTableViewProtocol> stateDelegate;
@property (nonatomic, weak) id<StateTableViewErrorProtocol> errorDelegate;

@end

NS_ASSUME_NONNULL_END
