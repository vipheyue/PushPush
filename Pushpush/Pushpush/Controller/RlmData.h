//
//  RlmData.h
//  Pushpush
//
//  Created by YC X on 2021/5/16.
//

#import "RLMObject.h"
#import <Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface RlmData : RLMObject

@property (nonatomic, copy) NSString *acceptTime;    // 接受时间
@property (nonatomic, copy) NSString *contentMsg;       // 内容

@end

NS_ASSUME_NONNULL_END
