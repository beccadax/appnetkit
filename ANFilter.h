//
//  ANFilter.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANIdentifiedResource.h"

//@class ANDraftFilter;

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

//- (ANDraftFilter*)draftFilter;

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

@end
