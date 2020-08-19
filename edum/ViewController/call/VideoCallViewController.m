//
//  VideoCallViewController.m
//  edum
//
//  Created by Md Chen on 7/7/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "VideoCallViewController.h"

#define button_top 30
#define button_width 60
#define button_padding (APPScreenWidth - (button_width * 4)) / 5

NSString *const appID = @"5cba18dd4f67419f9f18093415d9714d";
NSString *const token = @"";

@interface VideoCallViewController ()

@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
@property (strong, nonatomic) UIView *localVideo;
@property (strong, nonatomic) UIView *remoteVideo;
@property (strong, nonatomic) UIView *controlButtons;
@property (strong, nonatomic) UIImageView *remoteVideoMutedIndicator;
@property (strong, nonatomic) UIImageView *localVideoMutedBg;
@property (strong, nonatomic) UIImageView *localVideoMutedIndicator;

@property (strong, nonatomic) UIButton *videoMuteButton;
@property (strong, nonatomic) UIButton *muteButton;
@property (strong, nonatomic) UIButton *switchCameraButton;
@property (strong, nonatomic) UIButton *hangUpButton;

@end

@implementation VideoCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = __color_gray_background;
//    [self.view addSubview:self.remoteVideoMutedIndicator];
    
    [self setupViews];
    
    [self setupButtons];
    [self hideVideoMuted];
    [self initializeAgoraEngine];
    [self setupVideo];
    [self setupLocalVideo];
    [self joinChannel];
}

- (void)setupViews
{
    [self.view addSubview:self.remoteVideo];
    [self.view addSubview:self.remoteVideoMutedIndicator];
    [self.view addSubview:self.localVideo];
    [self.view addSubview:self.localVideoMutedBg];
    [self.view addSubview:self.controlButtons];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (UIView *)localVideo
{
    if (!_localVideo) {
        _localVideo = [[UIView alloc] initWithFrame:CGRectMake(APPScreenWidth - 110, 50, 90, 120)];
    }
    return _localVideo;
}

- (UIImageView *)localVideoMutedBg
{
    if (!_localVideoMutedBg) {
        _localVideoMutedBg = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 90 - 20, 50, 90, 120)];
        _localVideoMutedBg.image = ImageNamed(@"cameramute");
        [_localVideoMutedBg addSubview:self.localVideoMutedIndicator];
    }
    return _localVideoMutedBg;
}

- (UIImageView *)localVideoMutedIndicator
{
    if (!_localVideoMutedIndicator) {
        _localVideoMutedIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(30, 45, 30, 30)];
        _localVideoMutedIndicator.image = ImageNamed(@"cameraofflocal");
    }
    return _localVideoMutedIndicator;
}

- (UIView *)remoteVideo
{
    if (!_remoteVideo) {
        _remoteVideo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight)];
        _remoteVideo.backgroundColor = __color_gray_separator;
        [_remoteVideo addSubview:self.remoteVideoMutedIndicator];
        
    }
    return _remoteVideo;
}

- (UIImageView *)remoteVideoMutedIndicator
{
    if (!_remoteVideoMutedIndicator) {
        _remoteVideoMutedIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _remoteVideoMutedIndicator.center = self.view.center;
        _remoteVideoMutedIndicator.image = ImageNamed(@"cameraoffremote");
    }
    return _remoteVideoMutedIndicator;
}

- (UIView *)controlButtons
{
    if (!_controlButtons) {
        _controlButtons = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 120, APPScreenWidth, 120)];
        [_controlButtons addSubview:self.videoMuteButton];
        [_controlButtons addSubview:self.muteButton];
        [_controlButtons addSubview:self.switchCameraButton];
        [_controlButtons addSubview:self.hangUpButton];
    }
    return _controlButtons;
}

- (UIButton *)videoMuteButton
{
    if (!_videoMuteButton) {
        _videoMuteButton = [[UIButton alloc] initWithFrame:CGRectMake(button_padding, button_top, button_width, button_width)];
        [_videoMuteButton setImage:ImageNamed(@"cameraon") forState:UIControlStateSelected];
        [_videoMuteButton setImage:ImageNamed(@"cameraoff") forState:UIControlStateNormal];
        [_videoMuteButton addTarget:self action:@selector(didClickVideoMuteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoMuteButton;
}

- (UIButton *)muteButton
{
    if (!_muteButton) {
        _muteButton = [[UIButton alloc] initWithFrame:CGRectMake(button_padding * 2 + button_width, button_top, button_width, button_width)];
        [_muteButton setImage:ImageNamed(@"unmute") forState:UIControlStateSelected];
        [_muteButton setImage:ImageNamed(@"mute") forState:UIControlStateNormal];
        [_muteButton addTarget:self action:@selector(didClickMuteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _muteButton;
}

- (UIButton *)switchCameraButton
{
    if (!_switchCameraButton) {
        _switchCameraButton = [[UIButton alloc] initWithFrame:CGRectMake(button_padding * 3 + button_width * 2, button_top, button_width, button_width)];
        [_switchCameraButton setImage:ImageNamed(@"unswitch_camera") forState:UIControlStateSelected];
        [_switchCameraButton setImage:ImageNamed(@"switch_camera") forState:UIControlStateNormal];
        [_switchCameraButton addTarget:self action:@selector(didClickSwitchCameraButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraButton;
}

- (UIButton *)hangUpButton
{
    if (!_hangUpButton) {
        _hangUpButton = [[UIButton alloc] initWithFrame:CGRectMake(button_padding * 4 + button_width * 3, button_top, button_width, button_width)];
        [_hangUpButton setImage:ImageNamed(@"hangup") forState:UIControlStateNormal];
        [_hangUpButton addTarget:self action:@selector(hangUpButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hangUpButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeAgoraEngine
{
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:appID delegate:self];
}

- (void)setupVideo {
    [self.agoraKit enableVideo];
    // Default mode is disableVideo
    
    // Set up the configuration such as dimension, frame rate, bit rate and orientation
    AgoraVideoEncoderConfiguration *encoderConfiguration =
    [[AgoraVideoEncoderConfiguration alloc] initWithSize:AgoraVideoDimension640x360
                                               frameRate:AgoraVideoFrameRateFps15
                                                 bitrate:AgoraVideoBitrateStandard
                                         orientationMode:AgoraVideoOutputOrientationModeAdaptative];
    [self.agoraKit setVideoEncoderConfiguration:encoderConfiguration];
}

- (void)setupLocalVideo {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    // UID = 0 means we let Agora pick a UID for us
    
    videoCanvas.view = self.localVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupLocalVideo:videoCanvas];
    // Bind local video stream to view
}

- (void)joinChannel
{
    [self.agoraKit joinChannelByToken:token channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
        // Join channel "demoChannel1"
    }];
    // The UID database is maintained by your app to track which users joined which channels. If not assigned (or set to 0), the SDK will allocate one and returns it in joinSuccessBlock callback. The App needs to record and maintain the returned value as the SDK does not maintain it.
    
    [self.agoraKit setEnableSpeakerphone:YES];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}


/// Callback to handle the event such when the first frame of a remote video stream is decoded on the device.
/// @param engine - RTC engine instance
/// @param uid - user id
/// @param size - the height and width of the video frame
/// @param elapsed - lapsed Time elapsed (ms) from the local user calling JoinChannel method until the SDK triggers this callback.
- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size: (CGSize)size elapsed:(NSInteger)elapsed
{
    if (self.remoteVideo.hidden) {
        self.remoteVideo.hidden = NO;
    }
    
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    // Since we are making a simple 1:1 video chat app, for simplicity sake, we are not storing the UIDs. You could use a mechanism such as an array to store the UIDs in a channel.
    
    videoCanvas.view = self.remoteVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupRemoteVideo:videoCanvas];
    // Bind remote video stream to view
}

- (void)hangUpButton:(UIButton *)sender
{
    [self leaveChannel];
    [self.navigationController popViewControllerAnimated:NO];
}



///  Leave the channel and handle UI change when it is done.
- (void)leaveChannel {
    [self.agoraKit leaveChannel:^(AgoraChannelStats *stat) {
        [self hideControlButtons];
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        [self.remoteVideo removeFromSuperview];
        [self.localVideo removeFromSuperview];
    }];
}


/// Callback to handle an user offline event.
/// @param engine - RTC engine instance
/// @param uid - user id
/// @param reason - why is the user offline
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    self.remoteVideo.hidden = true;
}

- (void)setupButtons {
    [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remoteVideoTapped:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.userInteractionEnabled = true;
}

- (void)hideControlButtons {
    self.controlButtons.hidden = true;
}

- (void)remoteVideoTapped:(UITapGestureRecognizer *)recognizer {
    if (self.controlButtons.hidden) {
        self.controlButtons.hidden = false;
        [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
    }
}

- (void)resetHideButtonsTimer {
    [VideoCallViewController cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
}

- (void)didClickMuteButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.agoraKit muteLocalAudioStream:sender.selected];
    [self resetHideButtonsTimer];
}

- (void)didClickVideoMuteButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.agoraKit muteLocalVideoStream:sender.selected];
    self.localVideo.hidden = sender.selected;
    self.localVideoMutedBg.hidden = !sender.selected;
    self.localVideoMutedIndicator.hidden = !sender.selected;
    [self resetHideButtonsTimer];
}


/// A callback to handle muting of the audio
/// @param engine  - RTC engine instance
/// @param muted  - YES if muted; NO otherwise
/// @param uid  - user id
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didVideoMuted:(BOOL)muted byUid:(NSUInteger)uid
{
    self.remoteVideo.hidden = muted;
    self.remoteVideoMutedIndicator.hidden = !muted;
}

- (void) hideVideoMuted {
    self.remoteVideoMutedIndicator.hidden = true;
    self.localVideoMutedBg.hidden = true;
    self.localVideoMutedIndicator.hidden = true;
}

- (void)didClickSwitchCameraButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.agoraKit switchCamera];
    [self resetHideButtonsTimer];
}

@end
