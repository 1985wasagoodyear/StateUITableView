//
//  StateTableView+ErrorMessages.m
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

#import "StateTableView+ErrorMessages.h"

#define currSeparatorStyleKeyPath @"currSeparatorStyle"

@implementation StateTableView (ErrorMessages)

// helper method for updating the table
- (void)reloadTableData {
    switch (self.currentState) {
        case TableViewStateLoading:
            [self showLoadingMessage];
            break;
        case TableViewStateError:
            [self showErrorMessage:@"Error"];
            break;
        case TableViewStateEmpty:
            [self showEmptyMessage:@"Empty"];
            break;
        default:
            [self hideSpecialMessage];
            break;
    }
    [self reloadData];
}

// MARK: Special Messages

- (void)showErrorView:(UIView *)view {
    self.backgroundView = view;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

// https://stackoverflow.com/questions/15746745/handling-an-empty-uitableview-print-a-friendly-message
- (UIView *)defaultErrorMessage:(NSString *)string {
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:rect];
    messageLabel.text = string;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:12.0]; //UIFont(name: "TrebuchetMS", size: 15)
    [messageLabel sizeToFit];
    return messageLabel;
}

- (void)showLoadingMessage {
    UIView *loadingView = nil;
    if (self.errorDelegate != nil
        && [self.errorDelegate respondsToSelector:@selector(loadingMessageForStateTableRect:)]) {
        loadingView = [self.errorDelegate loadingMessageForStateTableRect:self.frame];
    }
    else {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:self.frame];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        activityIndicator.color = [UIColor grayColor];
        [activityIndicator startAnimating];
        loadingView = activityIndicator;
    }
    [self showErrorView:loadingView];
}

- (void)showErrorMessage:(NSString *)string {
    UIView *errorMessage = nil;
    if (self.errorDelegate != nil
        && [self.errorDelegate respondsToSelector:@selector(errorMessageForStateTableRect:)]) {
        errorMessage = [self.errorDelegate errorMessageForStateTableRect:self.frame];
    }
    else {
        errorMessage = [self defaultErrorMessage:@"Error"];
    }
    
    [self showErrorView:errorMessage];
}

- (void)showEmptyMessage:(NSString *)string {
    UIView *emptyMessage = nil;
    if (self.errorDelegate != nil
        && [self.errorDelegate respondsToSelector:@selector(emptyMessageForStateTableRect:)]) {
        emptyMessage = [self.errorDelegate emptyMessageForStateTableRect:self.frame];
    }
    else {
        emptyMessage = [self defaultErrorMessage:@"Empty"];
    }
    [self showErrorView:emptyMessage];
}

- (void)hideSpecialMessage {
    self.backgroundView = nil;
    self.separatorStyle = (UITableViewCellSeparatorStyle)[self valueForKey:currSeparatorStyleKeyPath];  // cheeky KVC
}

@end
