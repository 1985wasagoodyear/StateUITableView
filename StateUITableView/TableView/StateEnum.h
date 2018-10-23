//
//  StateEnum.h
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

// https://nshipster.com/swift-documentation/

#ifndef StateEnum_h
#define StateEnum_h

/// Defines state of current tableView.
typedef NS_ENUM(NSInteger, TableViewState) {
    TableViewStateLoading,
    TableViewStateError,
    TableViewStateEmpty,
    TableViewStateLoaded
};

#endif /* StateEnum_h */
