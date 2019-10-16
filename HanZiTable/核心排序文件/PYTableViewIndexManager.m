//
//  PYTableViewIndexManager.m
//  PYTableViewIndex
//
//  Created by CBCCBC on 16/1/5.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "PYTableViewIndexManager.h"
#import "PYTableViewIndexModel.h"
#import "pinyin.h"

@implementation PYTableViewIndexManager

+ (NSArray *)archiveNumbers:(NSArray *)originalArray {

    NSMutableArray *stringsToSort = [[NSMutableArray alloc] initWithArray:originalArray];

    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    
    for(NSInteger i = 0; i < [stringsToSort count]; i++) {
        PYTableViewIndexModel *model = stringsToSort[i];
        
        model.chineseString = [[ChineseString alloc] init];
        model.chineseString.string = model.nickName;
        
        if(model.chineseString.string == nil) {
            model.chineseString.string = @"";
        }
        
        if(![model.chineseString.string isEqualToString:@""]){
            NSString *pinYinResult = [NSString string];
            
            for(NSInteger j = 0; j < model.chineseString.string.length; j++){
                
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c", pinyinFirstLetter([model.chineseString.string characterAtIndex:j])] uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            model.chineseString.pinYin=pinYinResult;
            
        }else{
            model.chineseString.pinYin = @"";
        }
        [chineseStringsArray addObject:model];
    }
    
    NSArray *letters = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    NSArray *numbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for (int i = 0; i < 27; i++) {
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [datas addObject:arr];
    }
    
    for (int i = 0; i < chineseStringsArray.count; i++) {
        
        PYTableViewIndexModel *model = chineseStringsArray[i];
        
        for (int j = 0; j < letters.count; j++) {
            
            if ([[model.chineseString.pinYin substringToIndex:1] isEqualToString:letters[j]]) {
                
                [datas[j] insertObject:model atIndex:0];
                break;
            }
            
            for (int k = 0; k < numbers.count; k++) {
                
                if ([[model.chineseString.pinYin substringToIndex:1] isEqualToString:numbers[k]]) {
                    
                    [datas[26] insertObject:model atIndex:0];
                    break;
                }
            }
        }
    }
    
    return datas;
}

@end
