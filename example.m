#import <UIKit/UIKit.h>

@interface HiWindow : UIWindow
@end

@implementation HiWindow {
    CGPoint initialTouchPoint;
}

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(100, 100, 120, 50)];
    if (self) {
        self.windowLevel = UIWindowLevelAlert + 1;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = NO;

        UIButton *hiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        hiButton.frame = self.bounds;
        [hiButton setTitle:@"Hi" forState:UIControlStateNormal];
        hiButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        hiButton.layer.cornerRadius = 10;
        [self addSubview:hiButton];

        [self makeKeyAndVisible];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    initialTouchPoint = [[touches anyObject] locationInWindow];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentPoint = [[touches anyObject] locationInWindow];
    CGPoint offset = CGPointMake(currentPoint.x - initialTouchPoint.x, currentPoint.y - initialTouchPoint.y);
    CGRect frame = self.frame;
    frame.origin.x += offset.x;
    frame.origin.y += offset.y;
    self.frame = frame;
}
@end

__attribute__((constructor))
static void showHi() {
    dispatch_async(dispatch_get_main_queue(), ^{
        HiWindow *window = [[HiWindow alloc] init];
    });
}
