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

#import "WAContainerParser.h"
#import "WABlobContainer.h"
#import "WAXMLHelper.h"

@interface WABlobContainer (Private)

- (id)initContainerWithName:(NSString *)name URL:(NSString *)URL metadata:(NSString *)metadata;

@end

@implementation WAContainerParser

+ (NSArray *)loadContainers:(xmlDocPtr)doc {
    
    if (doc == nil) 
    { 
		return nil; 
	}
	
    NSMutableArray *containers = [NSMutableArray arrayWithCapacity:30];
    
    [WAXMLHelper performXPath:@"/EnumerationResults/Containers/Container" 
                 onDocument:doc 
                      block:^(xmlNodePtr node)
     {
         NSString *name = [WAXMLHelper getElementValue:node name:@"Name"];
         NSString *url = [WAXMLHelper getElementValue:node name:@"Url"];
         NSString *metadata = [WAXMLHelper getElementValue:node name:@"Metadata"];

         WABlobContainer *container = [[WABlobContainer alloc] initContainerWithName:name URL:url metadata:metadata];
         [containers addObject:container];
         [container release];
     }];
    
    return [[containers copy] autorelease];
}

+ (NSArray *)loadContainersForProxy:(xmlDocPtr)doc {
    
    if (doc == nil) 
    { 
		return nil; 
	}
	
    NSString* containerURI = [WAXMLHelper getElementValue:(xmlNodePtr)doc name:@"anyURI"];
    WABlobContainer *container = [[WABlobContainer alloc] initContainerWithName:@"$root" URL:containerURI metadata:nil];
    NSArray* containers = [NSArray arrayWithObject:container];
    
    [container release];
    
    return containers;
}

@end
