//
//  augenAudioUnit.h
//  augen
//
//  Created by otavio on 17/12/20.
//

#import <AudioToolbox/AudioToolbox.h>
#import "augenDSPKernelAdapter.h"

// Define parameter addresses.
extern const AudioUnitParameterID myParam1;

@interface augenAudioUnit : AUAudioUnit

@property (nonatomic, readonly) augenDSPKernelAdapter *kernelAdapter;
- (void)setupAudioBuses;
- (void)setupParameterTree;
- (void)setupParameterCallbacks;
@end
