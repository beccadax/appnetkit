//
//  ANFilter.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANIdentifiedResource.h"
#import "ANCompletions.h"

@class ANDraftFilter;
@class ANDraftFilterClause;

typedef enum {
    ANFilterMatchPolicyIncludeAny,
    ANFilterMatchPolicyIncludeAll,
    ANFilterMatchPolicyExcludeAny,
    ANFilterMatchPolicyExcludeAll
} ANFilterMatchPolicy;

extern NSString * ANStringFromFilterMatchPolicy(ANFilterMatchPolicy matchPolicy);
extern ANFilterMatchPolicy ANFilterMatchPolicyFromString(NSString * string);

@interface ANFilter : ANIdentifiedResource

@property (nonatomic,readonly) NSString * name;

@property (nonatomic,readonly) NSArray * clauses;
@property (nonatomic,readonly) NSArray * clauseRepresentations;

@property (nonatomic,readonly) ANFilterMatchPolicy matchPolicy;
@property (nonatomic,readonly) NSString * matchPolicyRepresentation;

- (void)deleteWithCompletion:(ANFilterRequestCompletion)completion;
- (void)updateFromDraft:(ANDraftFilter*)draftFilter completion:(ANFilterRequestCompletion)completion;

- (ANDraftFilter*)draftFilter;

@end

typedef enum {
    ANFilterClauseObjectTypePost,
    ANFilterClauseObjectTypeStar,
    ANFilterClauseObjectTypeUserFollow
} ANFilterClauseObjectType;

extern NSString * ANStringFromFilterClauseObjectType(ANFilterClauseObjectType objectType);
extern ANFilterClauseObjectType ANFilterClauseObjectTypeFromString(NSString * string);

typedef enum {
    ANFilterClauseOperatorEquals,
    ANFilterClauseOperatorMatches,
    ANFilterClauseOperatorLess,
    ANFilterClauseOperatorLessOrEquals,
    ANFilterClauseOperatorGreater,
    ANFilterClauseOperatorGreaterOrEquals,
    ANFilterClauseOperatorOneOf
} ANFilterClauseOperator;

extern NSString * ANStringFromFilterClauseOperator(ANFilterClauseOperator operator);
extern ANFilterClauseOperator ANFilterClauseOperatorFromString(NSString * string);

@interface ANFilterClause : ANResource

@property (nonatomic,readonly) ANFilterClauseObjectType objectType;
@property (nonatomic,readonly) NSString * objectTypeRepresentation;

@property (nonatomic,readonly) ANFilterClauseOperator operator;
@property (nonatomic,readonly) NSString * operatorRepresentation;

@property (nonatomic,readonly) NSString * field;
@property (nonatomic,readonly) id value;

- (ANDraftFilterClause*)draftFilterClause;

@end

@interface ANDraftFilter : NSObject

@property (nonatomic,readwrite) NSString * name;
@property (nonatomic,readonly) NSMutableArray * clauses;
@property (nonatomic,readwrite) ANFilterMatchPolicy matchPolicy;

@property (nonatomic,copy) NSDictionary * representation;

- (void)createFilterViaSession:(ANSession*)session completion:(ANFilterRequestCompletion)completion;

@end

@interface ANDraftFilterClause : NSObject

@property (nonatomic,assign) ANFilterClauseObjectType objectType;
@property (nonatomic,assign) ANFilterClauseOperator operator;
@property (nonatomic,strong) NSString * field;
@property (nonatomic,strong) id value;

@property (nonatomic,copy) NSDictionary * representation;

@end
