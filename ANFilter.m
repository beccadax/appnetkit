//
//  ANFilter.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANFilter.h"

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

