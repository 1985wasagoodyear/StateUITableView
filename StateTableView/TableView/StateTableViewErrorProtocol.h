//
//  StateTableViewErrorProtocol.h
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

#ifndef StateTableViewErrorProtocol_h
#define StateTableViewErrorProtocol_h

@protocol StateTableViewErrorProtocol <NSObject>

- (UIView *)loadingMessageForStateTableRect:(CGRect)rect;
- (UIView *)errorMessageForStateTableRect:(CGRect)rect;
- (UIView *)emptyMessageForStateTableRect:(CGRect)rect;

@end

#endif /* StateTableViewErrorProtocol_h */
