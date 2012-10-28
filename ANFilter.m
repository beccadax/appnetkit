//
//  ANFilter.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANFilter.h"
#import "ANSession+Requests.h"

@implementation ANFilter

@dynamic name;
@dynamic clauseRepresentations;
@dynamic matchPolicyRepresentation;

+ (NSSet*)keyPathsForValuesAffectingClauses {
    return [NSSet setWithObject:@"clauseRepresentations"];
}

- (NSArray *)clauses {
    NSMutableArray * array = [NSMutableArray new];
    
    for(NSDictionary * rep in self.clauseRepresentations) {
        [array addObject:[[ANFilterClause alloc] initWithRepresentation:rep session:self.session]];
    }
    
    return array;
}

+ (NSSet *)keyPathsForValuesAffectingMatchPolicy {
    return [NSSet setWithObject:@"matchPolicyRepresentation"];
}

- (ANFilterMatchPolicy)matchPolicy {
    return ANFilterMatchPolicyFromString(self.matchPolicyRepresentation);
}

- (ANDraftFilter *)draftFilter {
    ANDraftFilter * draft = [ANDraftFilter new];
    draft.representation = self.representation;
    return draft;
}

- (void)updateFromDraft:(ANDraftFilter *)draftFilter completion:(ANFilterRequestCompletion)completion {
    [self.session updateFilterWithID:self.ID fromDraft:draftFilter completion:completion];
}

- (void)deleteWithCompletion:(ANFilterRequestCompletion)completion {
    [self.session deleteFilterWithID:self.ID completion:completion];
}

@end

@implementation ANFilterClause

@dynamic objectTypeRepresentation;
@dynamic operatorRepresentation;
@dynamic field;
@dynamic value;

+ (NSSet *)keyPathsForValuesAffectingObjectType {
    return [NSSet setWithObject:@"objectTypeRepresentation"];
}

- (ANFilterClauseObjectType)objectType {
    return ANFilterClauseObjectTypeFromString(self.objectTypeRepresentation);
}

+ (NSSet *)keyPathsForValuesAffectingOperator {
    return [NSSet setWithObject:@"operatorRepresentation"];
}

- (ANFilterClauseOperator)operator {
    return ANFilterClauseOperatorFromString(self.operatorRepresentation);
}

- (ANDraftFilterClause *)draftFilterClause {
    ANDraftFilterClause * draftClause = [ANDraftFilterClause new];
    draftClause.representation = self.representation;
    return draftClause;
}

@end

@implementation ANDraftFilter

- (id)init {
    if((self = [super init])) {
        _clauses = [NSMutableArray new];
    }
    return self;
}

- (NSDictionary *)representation {
    return @{
    @"name": self.name,
    @"clauses": [self.clauses valueForKey:@"representation"],
    @"match_policy": ANStringFromFilterMatchPolicy(self.matchPolicy),
    };
}

- (void)setRepresentation:(NSDictionary *)representation {
    self.name = representation[@"name"];
    self.matchPolicy = ANFilterMatchPolicyFromString(representation[@"match_policy"]);
    
    [self.clauses removeAllObjects];
    for(NSDictionary * clauseRep in representation[@"clauses"]) {
        ANDraftFilterClause * clause = [ANDraftFilterClause new];
        clause.representation = clauseRep;
        [self.clauses addObject:clause];
    }
}

- (void)createFilterViaSession:(ANSession *)session completion:(ANFilterRequestCompletion)completion {
    [session createFilterFromDraft:self completion:completion];
}

@end

@implementation ANDraftFilterClause

- (NSDictionary *)representation {
    return @{
    @"object_type": ANStringFromFilterClauseObjectType(self.objectType),
    @"operator": ANStringFromFilterClauseOperator(self.operator),
    @"field": self.field,
    @"value": self.value
    };
}

- (void)setRepresentation:(NSDictionary *)representation {
    self.objectType = ANFilterClauseObjectTypeFromString(representation[@"object_type"]);
    self.operator = ANFilterClauseOperatorFromString(representation[@"operator"]);
    self.field = representation[@"field"];
    self.value = representation[@"value"];
}

@end

NSString * ANStringFromFilterMatchPolicy(ANFilterMatchPolicy matchPolicy) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @(ANFilterMatchPolicyIncludeAll): @"include_all",
        @(ANFilterMatchPolicyIncludeAny): @"include_any",
        @(ANFilterMatchPolicyExcludeAll): @"exclude_all",
        @(ANFilterMatchPolicyExcludeAny): @"exclude_any",
        };
    });
    
    return table[@(matchPolicy)];
}

ANFilterMatchPolicy ANFilterMatchPolicyFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @"include_all": @(ANFilterMatchPolicyIncludeAll),
        @"include_any": @(ANFilterMatchPolicyIncludeAny),
        @"exclude_all": @(ANFilterMatchPolicyExcludeAll),
        @"exclude_any": @(ANFilterMatchPolicyExcludeAny),
        };
    });
    
    return [table[string] integerValue];
}

NSString * ANStringFromFilterClauseObjectType(ANFilterClauseObjectType objectType) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @(ANFilterClauseObjectTypePost): @"post",
        @(ANFilterClauseObjectTypeStar): @"star",
        @(ANFilterClauseObjectTypeUserFollow): @"user_follow",
        };
    });
    
    return table[@(objectType)];
}

ANFilterClauseObjectType ANFilterClauseObjectTypeFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @"post": @(ANFilterClauseObjectTypePost),
        @"star": @(ANFilterClauseObjectTypeStar),
        @"user_follow": @(ANFilterClauseObjectTypeUserFollow),
        };
    });
    
    return [table[string] integerValue];
}


NSString * ANStringFromFilterClauseOperator(ANFilterClauseOperator operator) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @(ANFilterClauseOperatorEquals): @"equals",
        @(ANFilterClauseOperatorGreater): @"gt",
        @(ANFilterClauseOperatorGreaterOrEquals): @"ge",
        @(ANFilterClauseOperatorLess): @"lt",
        @(ANFilterClauseOperatorLessOrEquals): @"le",
        @(ANFilterClauseOperatorMatches): @"matches",
        @(ANFilterClauseOperatorOneOf): @"one_of",
        };
    });
    
    return table[@(operator)];
}

ANFilterClauseOperator ANFilterClauseOperatorFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @"equals": @(ANFilterClauseOperatorEquals),
        @"gt": @(ANFilterClauseOperatorGreater),
        @"ge": @(ANFilterClauseOperatorGreaterOrEquals),
        @"lt": @(ANFilterClauseOperatorLess),
        @"le": @(ANFilterClauseOperatorLessOrEquals),
        @"matches": @(ANFilterClauseOperatorMatches),
        @"one_of": @(ANFilterClauseOperatorOneOf),
        };
    });
    
    return [table[string] integerValue];
}

