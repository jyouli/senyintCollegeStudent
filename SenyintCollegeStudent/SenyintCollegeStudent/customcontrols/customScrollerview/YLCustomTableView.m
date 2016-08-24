//
//  CustomView.m
//  MingyiMedicalService
//
//  Created by  haole on 15/6/4.
//  Copyright (c) 2015年 haole. All rights reserved.
//

#import "YLCustomTableView.h"
@implementation YLCustomTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollEnabled = NO;
        self.delegate = self;
        self.dataSource = self;
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height/(float)_infoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CGSize size = CGSizeMake(tableView.frame.size.width, tableView.frame.size.height/3);

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIView *v = [[UIView alloc] initWithFrame:cell.bounds];
        v.backgroundColor = self.bgColor;
        cell.backgroundView  = v;
        cell.backgroundColor = self.bgColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.isRTLabel) {
            
            [cell.contentView removeFromSuperview];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
            label.tag = 100;
            [cell addSubview:label];
        } else {
           
            cell.textLabel.font = self.textFont;
            cell.textLabel.textColor = self.textColor;
            cell.textLabel.textAlignment = self.textAlignment;
        }
      
        
    }
    if (self.isRTLabel) {
        UILabel *label = (UILabel *)[cell viewWithTag:100];
        NSDictionary *dic = [_infoArray objectAtIndex:indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@%@",[dic objectForKey:@"info1"],[dic objectForKey:@"info2"],[dic objectForKey:@"info3"]];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size.height - 10],NSForegroundColorAttributeName:[dic objectForKey:@"color1"]} range:[str rangeOfString:[dic objectForKey:@"info1"]]];

        [text addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size.height - 7],NSForegroundColorAttributeName:[dic objectForKey:@"color2"]} range:NSMakeRange([[dic objectForKey:@"info1"] length], [[dic objectForKey:@"info2"] length])];
        
        [text addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size.height - 10],NSForegroundColorAttributeName:[dic objectForKey:@"color3"]} range:NSMakeRange([str length] - [[dic objectForKey:@"info3"] length], [[dic objectForKey:@"info3"] length])];
        label.attributedText = text;

//        label.text = [NSString stringWithFormat:@"<font face=AmericanTypewriter size=%f color='%@'>%@</font><font  size=%f color='%@'>%@</font><font face=AmericanTypewriter size=%f color='%@'>%@</font>",size.height - 10,[dic objectForKey:@"color1"],[dic objectForKey:@"info1"],size.height - 7,[dic objectForKey:@"color2"],[dic objectForKey:@"info2"],size.height - 10,[dic objectForKey:@"color3"],[dic objectForKey:@"info3"]];
    } else {
        
        cell.textLabel.text = [_infoArray objectAtIndex:indexPath.row];

    }
    
    return cell;
   
}
@end
