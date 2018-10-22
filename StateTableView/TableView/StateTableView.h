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

NS_ASSUME_NONNULL_BEGIN

@interface StateTableView : UITableView

@property (nonatomic) TableViewState currentState;

@property (nonatomic, weak) id<StateTableViewProtocol> stateDelegate;

@end

NS_ASSUME_NONNULL_END
