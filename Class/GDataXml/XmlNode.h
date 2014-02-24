//
//  XmlNode.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-23.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlNode : NSObject
@property(nonatomic,retain) NSDictionary *Attributes;
@property(nonatomic,retain) NSArray *ChildNodes;
@property(nonatomic,readonly) XmlNode *FirstChild;
@property(nonatomic,readonly) BOOL HasChildNodes;
@property(nonatomic,copy) NSString *InnerText;
@property(nonatomic,copy) NSString *InnerXml;
@property(nonatomic,readonly) XmlNode *LastChild;
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,retain) XmlNode *NextSibling;
@property(nonatomic,copy) NSString *OuterXml;
@property(nonatomic,retain) XmlNode *ParentNode;
@property(nonatomic,retain) XmlNode *PreviousSibling;
@property(nonatomic,copy) NSString *Value;
@end
