/*
 Copyright 2010 Microsoft Corp
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <Foundation/Foundation.h>


@interface WATableFetchRequest : NSObject 
{
    NSString* _tableName;
    NSString* _partitionKey;
    NSString* _rowKey;
    NSString* _filter;
    NSInteger _topRows;
}

@property (readonly) NSString* tableName;
@property (copy) NSString* partitionKey;
@property (copy) NSString* rowKey;
@property (copy) NSString* filter;
@property (assign) NSInteger topRows;

+ (WATableFetchRequest*)fetchRequestForTable:(NSString*)tableName;
+ (WATableFetchRequest*)fetchRequestForTable:(NSString*)tableName predicate:(NSPredicate*)predicate error:(NSError**)error;

@end
