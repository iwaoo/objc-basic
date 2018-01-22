//
//  CalendarViewController.m
//  CalendarTest20180122
//
//  Created by 新井岩生 on 2018/01/22.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "CalendarViewController.h"
#import "DayCell.h"
#import "CalendaNsdate.h"

static NSString * const ReuseIdentifier = @"Cell";
static NSUInteger const DaysPerWeek = 7;
static CGFloat const CellMargin = 2.0f;

@interface CalendarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;

@property (nonatomic, setter=setSelectedDate:) NSDate *selectedDate;
@property CalendaNsdate *calendaNsdate;

typedef void (^checkthedateCall)(BOOL checkthedate); //ブロック型宣言

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedDate = [NSDate date];
    self.calendaNsdate = [CalendaNsdate new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapPrevButton:(UIBarButtonItem *)sender {
    self.selectedDate = [self.selectedDate monthAgoDate];
    [self.calendarCollectionView reloadData];
}

- (IBAction)didTapNextButton:(UIBarButtonItem *)sender {
    self.selectedDate = [self.selectedDate monthLaterDate];
    [self.calendarCollectionView reloadData];
}

#pragma mark - private methods



- (void)setSelectedDate:(NSDate *)selectedDate
{
    _selectedDate = selectedDate;
    
    // update title text
    NSDateFormatter *yearFormatter = [NSDateFormatter new];
    NSDateFormatter *monthFormatter = [NSDateFormatter new];
    yearFormatter.dateFormat = @"yyyy";
    monthFormatter.dateFormat = @"M";
    
    NSString *titleYear = [yearFormatter stringFromDate:selectedDate];
    NSString *titleMonth = [monthFormatter stringFromDate:selectedDate];
    
    self.title = [NSString stringWithFormat:@"%@年%@月",titleYear,titleMonth];
}


/**
 * 月の初日は何曜日
 */
- (NSDate *)firstDateOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                   fromDate:self.selectedDate];
    components.day = 1;
    
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return firstDateMonth;
}

/**
 *  該当月のカレンダー上必要な日を取る
 */
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath recall:(checkthedateCall)recall
{

    // 月の初日が週の何日目
    NSInteger ordinalityOfFirstDay = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                                                             inUnit:NSCalendarUnitWeekOfMonth
                                                                            forDate:self.firstDateOfMonth];
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    // 月の初日から数えた日数
    dateComponents.day = indexPath.item - (ordinalityOfFirstDay - 1);
    //該当月のカレンダー上が必要な日を取る
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                                 toDate:self.firstDateOfMonth
                                                                options:0];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"d";
    
    // 非活生状態処理　コールバック
    NSCalendar *calendarValue = [NSCalendar currentCalendar];
    NSDateComponents *originComponents = [calendarValue components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                          fromDate:self.selectedDate];
    NSDateComponents *elementComponents = [calendarValue components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                           fromDate:date];
    if(originComponents.month == elementComponents.month){
        recall(YES);
    } else {
        recall(NO);
    }
    return date;
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    // calculate number of weeks
    NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                              inUnit:NSCalendarUnitMonth
                                                             forDate:self.firstDateOfMonth];
    NSUInteger numberOfWeeks = rangeOfWeeks.length;
    NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
    
    return numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier
                                                              forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"d";
    
    cell.dayLabel.text = [formatter stringFromDate:[self dateForCellAtIndexPath:indexPath recall:^(BOOL checkthedate) {
        cell.dayLabel.textColor = checkthedate ? [UIColor blackColor] : [UIColor grayColor];
        if (checkthedate) {
            if (indexPath.row % DaysPerWeek == 0) {
                cell.dayLabel.textColor =  [UIColor redColor];
            } else if (indexPath.row % DaysPerWeek == 6) {
                cell.dayLabel.textColor =  [UIColor blueColor];
            }
        }
    }]];
    
    NSArray *weekDays = @[@"日", @"月", @"火",@"水", @"木", @"金" ,@"土"];
    if (indexPath.row < DaysPerWeek) {
        cell.weekLabel.text = weekDays[indexPath.row];
        if (indexPath.row == 0) {
            cell.weekLabel.textColor = [UIColor redColor];
        } else if(indexPath.row == 6) {
            cell.weekLabel.textColor = [UIColor blueColor];
        } else {
            cell.weekLabel.textColor = [UIColor blackColor];
        }
    } else {
        cell.weekLabel.text = @"";
    }
    return cell;
}



#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfMargin = 8;
    CGFloat width = floorf((collectionView.frame.size.width - CellMargin * numberOfMargin) / DaysPerWeek);
    CGFloat height = width * 1.5f;
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

@end
