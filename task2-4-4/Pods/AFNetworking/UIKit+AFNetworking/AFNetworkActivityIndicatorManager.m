// AFNetworkActivityIndicatorManager.m
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFNetworkActivityIndicatorManager.h"

#if TARGET_OS_IOS
#import "AFURLSessionManager.h"

typedef NS_ENUM(NSInteger, AFNetworkActivityManagerState) {
    AFNetworkActivityManagerStateNotActive,
    AFNetworkActivityManagerStateDelayingStart,
    AFNetworkActivityManagerStateActive,
    AFNetworkActivityManagerStateDelayingEnd
};

static NSTimeInterval const kDefaultAFNetworkActivityManagerActivationDelay = 1.0;
static NSTimeInterval const kDefaultAFNetworkActivityManagerCompletionDelay = 0.17;

static NSURLRequest * AFNetworkRequestFromNotification(NSNotification *notification) {
<<<<<<< HEAD
    if ([notification.object respondsToSelector:@selector(originalRequest)]) {
        return ((NSURLSessionTask *)notification.object).originalRequest;
=======
    if ([[notification object] respondsToSelector:@selector(originalRequest)]) {
        return [(NSURLSessionTask *)[notification object] originalRequest];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
    } else {
        return nil;
    }
}

typedef void (^AFNetworkActivityActionBlock)(BOOL networkActivityIndicatorVisible);

@interface AFNetworkActivityIndicatorManager ()
@property (readwrite, nonatomic, assign) NSInteger activityCount;
@property (readwrite, nonatomic, strong) NSTimer *activationDelayTimer;
@property (readwrite, nonatomic, strong) NSTimer *completionDelayTimer;
@property (readonly, nonatomic, getter = isNetworkActivityOccurring) BOOL networkActivityOccurring;
@property (nonatomic, copy) AFNetworkActivityActionBlock networkActivityActionBlock;
@property (nonatomic, assign) AFNetworkActivityManagerState currentState;
@property (nonatomic, assign, getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible;

- (void)updateCurrentStateForNetworkActivityChange;
@end

@implementation AFNetworkActivityIndicatorManager

<<<<<<< HEAD
+ (AFNetworkActivityIndicatorManager*)sharedManager {
=======
+ (instancetype)sharedManager {
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
    static AFNetworkActivityIndicatorManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });

    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.currentState = AFNetworkActivityManagerStateNotActive;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidStart:) name:AFNetworkingTaskDidResumeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:AFNetworkingTaskDidSuspendNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:AFNetworkingTaskDidCompleteNotification object:nil];
    self.activationDelay = kDefaultAFNetworkActivityManagerActivationDelay;
    self.completionDelay = kDefaultAFNetworkActivityManagerCompletionDelay;

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_activationDelayTimer invalidate];
    [_completionDelayTimer invalidate];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (enabled == NO) {
<<<<<<< HEAD
        self.currentState = AFNetworkActivityManagerStateNotActive;
=======
        [self setCurrentState:AFNetworkActivityManagerStateNotActive];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
    }
}

- (void)setNetworkingActivityActionWithBlock:(void (^)(BOOL networkActivityIndicatorVisible))block {
    self.networkActivityActionBlock = block;
}

- (BOOL)isNetworkActivityOccurring {
    @synchronized(self) {
        return self.activityCount > 0;
    }
}

- (void)setNetworkActivityIndicatorVisible:(BOOL)networkActivityIndicatorVisible {
    if (_networkActivityIndicatorVisible != networkActivityIndicatorVisible) {
        [self willChangeValueForKey:@"networkActivityIndicatorVisible"];
        @synchronized(self) {
             _networkActivityIndicatorVisible = networkActivityIndicatorVisible;
        }
        [self didChangeValueForKey:@"networkActivityIndicatorVisible"];
        if (self.networkActivityActionBlock) {
            self.networkActivityActionBlock(networkActivityIndicatorVisible);
        } else {
<<<<<<< HEAD
            [UIApplication sharedApplication].networkActivityIndicatorVisible = networkActivityIndicatorVisible;
=======
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:networkActivityIndicatorVisible];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
        }
    }
}

- (void)setActivityCount:(NSInteger)activityCount {
<<<<<<< HEAD
    @synchronized(self) {
        _activityCount = activityCount;
    }
=======
	@synchronized(self) {
		_activityCount = activityCount;
	}
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872

    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateCurrentStateForNetworkActivityChange];
    });
}

- (void)incrementActivityCount {
    [self willChangeValueForKey:@"activityCount"];
<<<<<<< HEAD
    @synchronized(self) {
        _activityCount++;
    }
=======
	@synchronized(self) {
		_activityCount++;
	}
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
    [self didChangeValueForKey:@"activityCount"];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateCurrentStateForNetworkActivityChange];
    });
}

- (void)decrementActivityCount {
    [self willChangeValueForKey:@"activityCount"];
<<<<<<< HEAD
    @synchronized(self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
        _activityCount = MAX(_activityCount - 1, 0);
#pragma clang diagnostic pop
    }
=======
	@synchronized(self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
		_activityCount = MAX(_activityCount - 1, 0);
#pragma clang diagnostic pop
	}
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
    [self didChangeValueForKey:@"activityCount"];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateCurrentStateForNetworkActivityChange];
    });
}

- (void)networkRequestDidStart:(NSNotification *)notification {
<<<<<<< HEAD
    if (AFNetworkRequestFromNotification(notification).URL) {
=======
    if ([AFNetworkRequestFromNotification(notification) URL]) {
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
        [self incrementActivityCount];
    }
}

- (void)networkRequestDidFinish:(NSNotification *)notification {
<<<<<<< HEAD
    if (AFNetworkRequestFromNotification(notification).URL) {
=======
    if ([AFNetworkRequestFromNotification(notification) URL]) {
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
        [self decrementActivityCount];
    }
}

#pragma mark - Internal State Management
- (void)setCurrentState:(AFNetworkActivityManagerState)currentState {
    @synchronized(self) {
        if (_currentState != currentState) {
            [self willChangeValueForKey:@"currentState"];
            _currentState = currentState;
            switch (currentState) {
                case AFNetworkActivityManagerStateNotActive:
                    [self cancelActivationDelayTimer];
                    [self cancelCompletionDelayTimer];
                    [self setNetworkActivityIndicatorVisible:NO];
                    break;
                case AFNetworkActivityManagerStateDelayingStart:
                    [self startActivationDelayTimer];
                    break;
                case AFNetworkActivityManagerStateActive:
                    [self cancelCompletionDelayTimer];
                    [self setNetworkActivityIndicatorVisible:YES];
                    break;
                case AFNetworkActivityManagerStateDelayingEnd:
                    [self startCompletionDelayTimer];
                    break;
            }
        }
        [self didChangeValueForKey:@"currentState"];
    }
}

- (void)updateCurrentStateForNetworkActivityChange {
    if (self.enabled) {
        switch (self.currentState) {
            case AFNetworkActivityManagerStateNotActive:
                if (self.isNetworkActivityOccurring) {
<<<<<<< HEAD
                    self.currentState = AFNetworkActivityManagerStateDelayingStart;
=======
                    [self setCurrentState:AFNetworkActivityManagerStateDelayingStart];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
                }
                break;
            case AFNetworkActivityManagerStateDelayingStart:
                //No op. Let the delay timer finish out.
                break;
            case AFNetworkActivityManagerStateActive:
                if (!self.isNetworkActivityOccurring) {
<<<<<<< HEAD
                    self.currentState = AFNetworkActivityManagerStateDelayingEnd;
=======
                    [self setCurrentState:AFNetworkActivityManagerStateDelayingEnd];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
                }
                break;
            case AFNetworkActivityManagerStateDelayingEnd:
                if (self.isNetworkActivityOccurring) {
<<<<<<< HEAD
                    self.currentState = AFNetworkActivityManagerStateActive;
=======
                    [self setCurrentState:AFNetworkActivityManagerStateActive];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
                }
                break;
        }
    }
}

- (void)startActivationDelayTimer {
    self.activationDelayTimer = [NSTimer
                                 timerWithTimeInterval:self.activationDelay target:self selector:@selector(activationDelayTimerFired) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.activationDelayTimer forMode:NSRunLoopCommonModes];
}

- (void)activationDelayTimerFired {
    if (self.networkActivityOccurring) {
<<<<<<< HEAD
        self.currentState = AFNetworkActivityManagerStateActive;
    } else {
        self.currentState = AFNetworkActivityManagerStateNotActive;
=======
        [self setCurrentState:AFNetworkActivityManagerStateActive];
    } else {
        [self setCurrentState:AFNetworkActivityManagerStateNotActive];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
    }
}

- (void)startCompletionDelayTimer {
    [self.completionDelayTimer invalidate];
    self.completionDelayTimer = [NSTimer timerWithTimeInterval:self.completionDelay target:self selector:@selector(completionDelayTimerFired) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.completionDelayTimer forMode:NSRunLoopCommonModes];
}

- (void)completionDelayTimerFired {
<<<<<<< HEAD
    self.currentState = AFNetworkActivityManagerStateNotActive;
=======
    [self setCurrentState:AFNetworkActivityManagerStateNotActive];
>>>>>>> 6c1d934d20d1af0ad8897bf48a19ede60fce5872
}

- (void)cancelActivationDelayTimer {
    [self.activationDelayTimer invalidate];
}

- (void)cancelCompletionDelayTimer {
    [self.completionDelayTimer invalidate];
}

@end

#endif
