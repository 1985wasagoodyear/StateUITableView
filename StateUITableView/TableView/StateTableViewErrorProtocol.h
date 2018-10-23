//
//  StateTableViewErrorProtocol.h
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

#ifndef StateTableViewErrorProtocol_h
#define StateTableViewErrorProtocol_h

/// Protocol for a Delegate to handle Loading, Error, and Empty cases
@protocol StateTableViewErrorProtocol <NSObject>

@optional
- (UIView *)loadingMessageForStateTableRect:(CGRect)rect;
- (UIView *)errorMessageForStateTableRect:(CGRect)rect;
- (UIView *)emptyMessageForStateTableRect:(CGRect)rect;

@end

#endif /* StateTableViewErrorProtocol_h */
