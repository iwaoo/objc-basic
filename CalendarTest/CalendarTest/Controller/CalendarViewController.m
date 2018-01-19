//
//  CalendarViewController.m
//  CalendarTest
//
//  Created by 新井岩生 on 2018/01/19.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "CalendarViewController.h"
#import "DayCell.h"

@implementation NSDate (Extension)

/**
 * １ヶ月前のカレンダーデータ
 */
- (NSDate *)monthAgoDate
{
    NSInteger addValue = -1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

/**
 *  １ヶ月後のカレンダーデータ
 */
- (NSDate *)monthLaterDate
{
    NSInteger addValue = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

@end



@interface CalendarViewController ()

/**
 *  カレンダーから選んだDate
 */
@property (nonatomic) NSDate *selectedDate;

@end

static NSString * const ReuseIdentifier = @"Cell";

static NSUInteger const DaysPerWeek = 7;

static NSInteger const numberOfMargin = 8;

static CGFloat const CellMargin = 2.0f;

@implementation CalendarViewController

#pragma mark - LifeCycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedDate = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Action methods


- (IBAction)didTapPrevButton:(id)sender
{
    self.selectedDate = [self.selectedDate monthAgoDate];
    
    [self.collectionView reloadData];
}

- (IBAction)didTapNextButton:(id)sender
{
    self.selectedDate = [self.selectedDate monthLaterDate];
    
    [self.collectionView reloadData];
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
 *  最初は現在の月を表示
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
 *  return date for specified indexPath
 *
 *  @param indexPath cell's indexPath
 *
 *  @return date
 */
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    // calculate the ordinal number of first day
    NSInteger ordinalityOfFirstDay = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                                                             inUnit:NSCalendarUnitWeekOfMonth
                                                                            forDate:self.firstDateOfMonth];
    
    // calculate the difference between "day number of cell at indexPath" and "day number of first day"
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = indexPath.item - (ordinalityOfFirstDay - 1);
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                                 toDate:self.firstDateOfMonth
                                                                options:0];
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
    NSArray *weekDays = @[@"日", @"月", @"火",@"水", @"木", @"金" ,@"土"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"d";
    
    if (indexPath.row < DaysPerWeek) {
        cell.weekLabel.text = weekDays[indexPath.row];
    } else {
        cell.weekLabel.text = @"";
    }
    cell.dayLabel.text = [formatter stringFromDate:[self dateForCellAtIndexPath:indexPath]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
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
