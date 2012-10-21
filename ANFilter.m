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
