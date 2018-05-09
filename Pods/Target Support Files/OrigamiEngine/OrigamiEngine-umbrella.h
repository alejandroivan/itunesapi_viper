#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ORGMAudioUnit.h"
#import "ORGMCommonProtocols.h"
#import "ORGMConverter.h"
#import "ORGMEngine.h"
#import "ORGMInputUnit.h"
#import "ORGMOutputUnit.h"
#import "ORGMPluginManager.h"
#import "ORGMQueues.h"
#import "CoreAudioDecoder.h"
#import "CueSheet.h"
#import "CueSheetContainer.h"
#import "CueSheetDecoder.h"
#import "CueSheetTrack.h"
#import "FileSource.h"
#import "HTTPSource.h"
#import "M3uContainer.h"

FOUNDATION_EXPORT double OrigamiEngineVersionNumber;
FOUNDATION_EXPORT const unsigned char OrigamiEngineVersionString[];

