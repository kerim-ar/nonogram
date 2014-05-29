//
//  NViewControllerNonagram.m
//  Nonagram
//
//  Created by Student on 28.03.14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "NViewControllerNonagram.h"
#import "NCollectionViewNonagram.h"

NSInteger const emptyCell = 0;
NSInteger const fullCell = 1;
NSInteger const crossCell = 2;
NSInteger const collectionViewWidth = 300;
NSInteger const collectionViewHeight = 319;
NSInteger const cellWidth = 20;
NSInteger const minimumZoomScale = 0.5;
NSInteger const maximumZoomScale = 5.0;



@interface NViewControllerNonagram ()


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionViewNonagram;

@property (weak, nonatomic) IBOutlet UIButton *fillButton;
@property (weak, nonatomic) IBOutlet UIButton *crossButton;
@property (weak, nonatomic) IBOutlet UIButton *emptyButton;

@property (nonatomic, assign) NSInteger emptyFieldWidth;
@property (nonatomic, assign) NSInteger emptyFieldHeight;
@property (nonatomic, strong) NSArray *topMetric;
@property (nonatomic, strong) NSArray *leftMetric;
@property (nonatomic, assign) NSInteger topMetricWidth;
@property (nonatomic, assign) NSInteger leftMetricWidth;
@property (nonatomic, strong) NSArray *rightField;
@property (nonatomic, strong) NSMutableArray *userField;

@property (nonatomic, assign) int instrument;

@property (nonatomic, strong) UIColor *fullCellColor;
@property (nonatomic, strong) UIColor *emptyCellColor;
@property (nonatomic, strong) UIColor *wrongCellColor;

@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation NViewControllerNonagram


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.instrument = fullCell;
    self.fillButton.selected = YES;
    
    self.emptyFieldWidth = [self.field.width integerValue];
    self.emptyFieldHeight = [self.field.height integerValue];
    self.topMetricWidth = [self.field.top_metric_width integerValue];
    self.leftMetricWidth = [self.field.left_metric_width integerValue];
    
    self.topMetric = [self.field.top_metric componentsSeparatedByString:@" " ];
    self.leftMetric = [self.field.left_metric componentsSeparatedByString:@" "];
    self.rightField = [self.field.field componentsSeparatedByString:@" "];
    self.userField = [[self.field.user_field componentsSeparatedByString:@" "] mutableCopy];
    
    self.scrollView.minimumZoomScale = minimumZoomScale;
    self.scrollView.maximumZoomScale = maximumZoomScale;
    
    self.fullCellColor = [UIColor colorWithRed:220/256.0 green:144/256.0 blue:120/256.0 alpha:1.0];
    self.emptyCellColor = [UIColor whiteColor];
    self.wrongCellColor = [UIColor colorWithRed:237/256.0 green:133/256.0 blue:47/256.0 alpha:1.0];
    
    [self placeFieldAndSetup];
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkProgress) userInfo:nil repeats:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    if ([self.myTimer isValid]) {
        [self.myTimer invalidate];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self checkAndLightUncorrectCels:self.collectionViewNonagram];
}

-(void)checkAndLightUncorrectCels:(UICollectionView *)collectionView
{
    for(int i = self.leftMetricWidth; i < (self.leftMetricWidth + self.emptyFieldWidth); ++i)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.topMetricWidth];
        NSMutableArray *metricColumnArrayWithoutZero = [self getTopColumnMetric:indexPath];
        [self collectionView:collectionView checkNonagram:indexPath metricArray:metricColumnArrayWithoutZero newRowMetricArray:[self countMetric:indexPath start:0 end:self.emptyFieldHeight isTop:YES] metricWidth:self.topMetricWidth isTop:YES];
    }
    for(int i = self.topMetricWidth; i < (self.topMetricWidth + self.emptyFieldHeight); ++i)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.leftMetricWidth inSection:i];
        NSMutableArray *metricRowArrayWithoutZero = [self getLeftRowMetric:indexPath];
        int start = (indexPath.section - self.topMetricWidth) * self.emptyFieldWidth;
        [self collectionView:collectionView checkNonagram:indexPath metricArray:metricRowArrayWithoutZero newRowMetricArray:[self countMetric:indexPath start:start end:(start + self.emptyFieldWidth) isTop:NO] metricWidth:self.leftMetricWidth isTop:NO];
    }
}

-(void) placeFieldAndSetup
{
    [self.collectionViewNonagram setAutoresizingMask:UIViewAutoresizingNone];
    self.collectionViewNonagram.frame = CGRectMake(self.collectionViewNonagram.frame.origin.x, self.collectionViewNonagram.frame.origin.y, cellWidth * (self.emptyFieldWidth + self.leftMetricWidth), cellWidth * (self.emptyFieldHeight + self.topMetricWidth));
    
    if ((self.collectionViewNonagram.frame.size.width < collectionViewWidth) || (self.collectionViewNonagram.frame.size.height < collectionViewHeight))
    {
        float x = (collectionViewWidth - self.collectionViewNonagram.frame.size.width) / 2;
        float y = (collectionViewHeight - self.collectionViewNonagram.frame.size.height) / 2;
        
        self.collectionViewNonagram.frame = CGRectMake(x, y, self.collectionViewNonagram.frame.size.width, self.collectionViewNonagram.frame.size.height);
        self.scrollView.minimumZoomScale = 1.0;
        self.scrollView.maximumZoomScale = 1.0;
        self.scrollView.scrollEnabled = NO;
        self.subView.frame = CGRectMake(x, y, self.subView.frame.size.width, self.subView.frame.size.height);
        
    }
    else
    {
        self.subView = [[UIView alloc] init];
        [self.subView addSubview:self.collectionViewNonagram];
        self.subView.frame = CGRectMake(0, 0, self.collectionViewNonagram.frame.size.width, self.collectionViewNonagram.frame.size.height);
        [self.scrollView addSubview:self.subView];
        self.scrollView.contentSize = self.subView.frame.size;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.subView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return (self.emptyFieldHeight + self.topMetricWidth);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.emptyFieldWidth + self.leftMetricWidth);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NCollectionViewNonagram *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIColor *borderColor = [UIColor colorWithRed:93/256.0 green:66/256.0 blue:54/256.0 alpha:1.0];
    cell.contentView.layer.borderWidth = 1;
    cell.contentView.layer.borderColor = [borderColor CGColor];
    
    if (indexPath.section < self.topMetricWidth)
    {
        if (indexPath.row >= self.leftMetricWidth)
        {
            int item = indexPath.row - self.leftMetricWidth + indexPath.section * self.emptyFieldWidth;
            cell.labelMetric.text = ([self.topMetric[item] integerValue] != 0) ? self.topMetric[item] : @"";
        }
        else
        {
            cell.contentView.layer.borderColor = [[UIColor whiteColor] CGColor];
        }
    }
    else
    {
        if (indexPath.row < self.leftMetricWidth)
        {
            int item = (indexPath.section - self.topMetricWidth) * self.leftMetricWidth + indexPath.row;
            cell.labelMetric.text = ([self.leftMetric[item] integerValue] != 0) ? self.leftMetric[item] : @"";
        }
        else
        {
            int item = (indexPath.section - self.topMetricWidth) * self.emptyFieldWidth + indexPath.row - self.leftMetricWidth;
            
            cell.backgroundColor = ([self.userField[item] integerValue] == fullCell) ? self.fullCellColor : self.emptyCellColor;
            
            cell.backgroundView = ([self.userField[item] integerValue] == crossCell) ? [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-tool-cross-it-disabled.png"]] : nil;
        }
        
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isCellChanged = false;
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    
    if ((indexPath.section >= self.topMetricWidth) && (indexPath.row >= self.leftMetricWidth))
    {
        int item = (indexPath.section - self.topMetricWidth) * self.emptyFieldWidth + indexPath.row - self.leftMetricWidth;
        
        switch (self.instrument)
        {
            case emptyCell:
            {
                if ((![datasetCell.backgroundColor isEqual:self.emptyCellColor]) || (datasetCell.backgroundView != nil))
                {
                    isCellChanged = true;
                    [self.userField replaceObjectAtIndex:item withObject:[NSNumber numberWithInteger: emptyCell]];
                    datasetCell.backgroundColor = self.emptyCellColor;
                    datasetCell.backgroundView = nil;
                }
                
                break;
            }
            case fullCell:
            {
                if ((![datasetCell.backgroundColor isEqual:self.fullCellColor]) || (datasetCell.backgroundView != nil))
                {
                    isCellChanged = true;
                    [self.userField replaceObjectAtIndex:item withObject:[NSNumber numberWithInteger: fullCell]];
                    datasetCell.backgroundColor = self.fullCellColor;
                    datasetCell.backgroundView = nil;
                }
                break;
            }
            case crossCell:
            {
                if ((![datasetCell.backgroundColor isEqual:self.emptyCellColor]) || (datasetCell.backgroundView == nil))
                {
                    isCellChanged = true;
                    [self.userField replaceObjectAtIndex:item withObject:[NSNumber numberWithInteger: crossCell]];
                    datasetCell.backgroundColor = self.emptyCellColor;
                    datasetCell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-tool-cross-it-disabled.png"]];
                }
                break;
            }
            
            default:
            {
                break;
            }
        }
        
        if (isCellChanged)
        {
            self.field.user_field = [self.userField componentsJoinedByString:@" "];
            [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
            [self collectionView:collectionView checkNonagramForCorrect:indexPath];
            [self checkNonagramForWin:self.field.user_field];
        }
    }
}

-(void) checkNonagramForWin:(NSString *)userField
{
    userField = [userField stringByReplacingOccurrencesOfString:@"2" withString:@"0"];
    
    if ([userField isEqualToString:self.field.field])
    {
        self.field.progress = @"1.0";
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        [self performSegueWithIdentifier:@"EndGame" sender:self];
    }
}

-(void)collectionView:(UICollectionView *)collectionView checkNonagramForCorrect:(NSIndexPath *)indexPath
{
    NSMutableArray *metricColumnArrayWithoutZero = [self getTopColumnMetric:indexPath];
    [self collectionView:collectionView checkNonagram:indexPath metricArray:metricColumnArrayWithoutZero newRowMetricArray:[self countMetric:indexPath start:0 end:self.emptyFieldHeight isTop:YES] metricWidth:self.topMetricWidth isTop:YES];
    
    NSMutableArray *metricRowArrayWithoutZero = [self getLeftRowMetric:indexPath];
    int start = (indexPath.section - self.topMetricWidth) * self.emptyFieldWidth;
    [self collectionView:collectionView checkNonagram:indexPath metricArray:metricRowArrayWithoutZero newRowMetricArray:[self countMetric:indexPath start:start end:(start + self.emptyFieldWidth) isTop:NO] metricWidth:self.leftMetricWidth isTop:NO];
}

-(NSMutableArray *) countMetric:(NSIndexPath *)indexPath start:(NSInteger)start end:(NSInteger)end isTop:(BOOL)isTop
{
    NSMutableArray *metric = [[NSMutableArray alloc] init];
    int index = indexPath.row - self.leftMetricWidth;
    int count = 0;
    for (int i = start; i < end; ++i)
    {
        int fieldVal = isTop ? [self.userField[index] integerValue] : [self.userField[i] integerValue];
        if(fieldVal == 1)
        {
            ++count;
        }
        else if (count != 0)
        {
            [metric addObject:[NSNumber numberWithInteger: count]];
            count = 0;
        }
        index += self.emptyFieldWidth;
    }
    
    if (count != 0)
    {
        [metric addObject:[NSNumber numberWithInteger: count]];
    }
    
    return metric;
}

-(NSMutableArray *) getLeftRowMetric:(NSIndexPath *)indexPath
{
    NSUInteger start = (indexPath.section - self.topMetricWidth) * self.leftMetricWidth;
    NSMutableArray *metricRowArray = [[NSMutableArray alloc] initWithArray:[self.leftMetric subarrayWithRange: NSMakeRange(start, self.leftMetricWidth)]];
    NSMutableArray *metricRowArrayWithoutZero = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [metricRowArray count]; i++)
    {
        if ([metricRowArray[i] integerValue] != 0)
        {
            [metricRowArrayWithoutZero addObject:metricRowArray[i]];
        }
    }
    return metricRowArrayWithoutZero;
}

-(NSMutableArray *) getTopColumnMetric:(NSIndexPath *)indexPath
{
    NSMutableArray *metricColumnArrayWithoutZero = [[NSMutableArray alloc] init];
    int index = indexPath.row - self.leftMetricWidth;
    for(int i = 0; i < self.topMetricWidth; ++i)
    {
        if ([self.topMetric[index] integerValue] != 0)
        {
            [metricColumnArrayWithoutZero addObject:self.topMetric[index]];
        }
        index += self.emptyFieldWidth;
    }
    return metricColumnArrayWithoutZero;
}

-(void)collectionView:(UICollectionView *)collectionView checkNonagram:(NSIndexPath *)indexPath metricArray:(NSMutableArray *)metricRowArray newRowMetricArray:(NSArray *)newRowMetricArray metricWidth:(NSInteger)metricWidth isTop:(BOOL)isTop
{
    if ([metricRowArray count] < [newRowMetricArray count])
    {
        for(int i = 0; i < metricWidth; ++i)
        {
            UICollectionViewCell *cell = isTop ? [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:i]] : [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
            cell.backgroundColor = self.wrongCellColor;
        }
    }
    else if ([metricRowArray count] == [newRowMetricArray count])
    {
        int delta = metricWidth - [metricRowArray count];
        if ([metricRowArray count] < metricWidth)
        {
            for(int i = 0; i < delta; ++i)
            {
                UICollectionViewCell *cell = isTop ? [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:i]] : [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
                cell.backgroundColor = self.emptyCellColor;
            }
        }
        for(int i = 0; i < [metricRowArray count]; ++i)
        {
            UICollectionViewCell *cell = isTop ? [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:i + delta]] : [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i + delta inSection:indexPath.section]];
            
            cell.backgroundColor = ([metricRowArray[i] integerValue] != [newRowMetricArray[i] integerValue]) ? self.wrongCellColor : self.emptyCellColor;
        }
    }
    else
    {
        BOOL wrongNumbers = (([newRowMetricArray count] == 1) && (([newRowMetricArray[0] integerValue] == (self.emptyFieldWidth - 1)) || ([newRowMetricArray[0] integerValue] == (self.emptyFieldWidth))));
        UIColor *color = wrongNumbers ? self.wrongCellColor : self.emptyCellColor;
        
        for(int i = 0; i < metricWidth; ++i)
        {
            UICollectionViewCell *cell = isTop ? [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:i]] : [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
            cell.backgroundColor = color;
        }
    }
}

-(void)checkProgress
{
    float userCount = 0.0;
    float allFieldCount = 0.0;
    for(int i = 0; i < [self.rightField count]; ++i)
    {
        int userCellValue = ([self.userField[i] integerValue] == 2) ? 0 : (([self.userField[i] integerValue] == 1) ? 1 : 0);
        if ([self.rightField[i] integerValue] == 1)
        {
            if ([self.rightField[i] integerValue] == userCellValue)
            {
                ++userCount;
            }
            ++allFieldCount;
        }
    }
    float progress = userCount / allFieldCount;
    self.field.progress = [NSString stringWithFormat:@"%f", progress];
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
}

- (IBAction)buttonTapped:(UIButton *)sender
{
    self.instrument = 1;
    sender.selected = YES;
    self.crossButton.selected = NO;
    self.emptyButton.selected = NO;
}

- (IBAction)buttonTappedCross:(UIButton *)sender
{
    self.instrument = 2;
    sender.selected = YES;
    self.fillButton.selected = NO;
    self.emptyButton.selected = NO;
}

- (IBAction)buttonTappedEmpty:(UIButton *)sender
{
    self.instrument = 0;
    sender.selected = YES;
    self.crossButton.selected = NO;
    self.fillButton.selected = NO;
}

@end;