//
//  PYTableViewIndexModel.h
//  PYTableViewIndex
//
//  Created by CBCCBC on 16/1/5.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChineseString.h"

@interface PYTableViewIndexModel : NSObject

@property (strong,nonatomic) NSString *nickName;
@property (strong,nonatomic) ChineseString *chineseString;

@end
