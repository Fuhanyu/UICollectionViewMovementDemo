# UICollectionViewMovementDemo
UICollectionView重排功能的DEMO

# 普通UICollectionView重排功能的OC实现
先上DEMO地址：[UICollectionView简单重排的实现](https://github.com/Fuhanyu/UICollectionViewMovementDemo)

参考链接：[UICollectionViews Now Have Easy Reordering](http://nshint.io/blog/2015/07/16/uicollectionviews-now-have-easy-reordering/)
译文连接：[现在，UICollectionViews有了简单的重排功能](http://www.cocoachina.com/ios/20150911/13418.html)

文中使用Swift实现的，项目中运行的是OC版本，就写了个OC版本的DEMO供大家参考使用（现在还没有做出瀑布流的重排功能会在后续补上）

UICollectionView的重排是在iOS9之后进行提供的一个小功能,只有在iOS9之后才可以支持。

## 一.我们首先需要为UICollectionView添加一个长按手势
        - (void)setUpMovement{
        UILongPressGestureRecognizer *longPressGestureRecognizer =             [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [self.collectionView addGestureRecognizer:longPressGestureRecognizer];
        }


## 二.在长按手势的触发方法中执行方法
- (void)longPressAction:(UIGestureRecognizer *)gesture{
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
        switch (gesture.state) {
            case UIGestureRecognizerStateBegan:{
//当长按手势刚开始时，开始执行移动操作
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                break;
            }
            case UIGestureRecognizerStateChanged:{
//当长按手势改变位置时，执行移动的操作 
//下面两个状态，方法和意思相同
                [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
                break;
            }
            case UIGestureRecognizerStateEnded:{
                [self.collectionView endInteractiveMovement];
                break;
                }
            default:
                [self.collectionView cancelInteractiveMovement];
                break;
        }
}

## 三.还需要重写UICollectionViewDataSource的代理方法

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
        NSString *temp = [_dataArray objectAtIndex:sourceIndexPath.row];
        [_dataArray removeObjectAtIndex:sourceIndexPath.row];
        [_dataArray insertObject:temp atIndex:destinationIndexPath.row];
}

# 效果图

![collectionViewGif.gif](http://upload-images.jianshu.io/upload_images/1195084-76977fa2382bc0b0.gif?imageMogr2/auto-orient/strip)
#To do
瀑布流的重排功能OC实现