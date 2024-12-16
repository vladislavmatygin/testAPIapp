#import <Foundation/Foundation.h>


inline static NSError* tryExpection(void (NS_NOESCAPE ^tryBlock)(void)) {
    NSError *error;
    @try {
        tryBlock();
    }
    @catch (NSException *exception) {
        error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];

    }
    return error;
}
