### somewear-ios
Example iOS application using the Somewear SDKs.

# Somewear SDK
The Somewear SDK includes the Somewear Core and UI SDKs that are used in the Somewear iOS application. It currently provides device scanning, device info, permission handling, bluetooth prompts, firmware update dialogs, and firmware update notification handling. You can directly use the Somewear Core SDK instead if your application requirements are not satisfied.
 
## Setup
1. Edit your podfile to include Somewear's Cocoapod spec repository and pod.
```ruby
source 'https://github.com/CocoaPods/Specs.git'

# 1. Add the Somewear spec repo.
source 'https://github.com/someweardev/somewear-specs.git'

target 'MyApp' do

  # 2. Add the Somewear pod.
  pod 'Somewear'

end
```
2. `pod install` - Install the podfile changes.

## Usage
Add the status bar view to your layout so the user scan for a Somewear device and see info such as current battery level.
```swift
private lazy var statusBar = SomewearViews.statusBarView(presenter: self)

override func viewDidLoad() {
    super.viewDidLoad()

    setupStatusBar()
}

private func setupStatusBar() {
    // setup status bar
    statusBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(statusBar)

    // setup constraints
    NSLayoutConstraint.activate([
        statusBar.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
        statusBar.leftAnchor.constraint(equalTo: view.leftAnchor),
        statusBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
}
```

Send a message over satellite.
```swift
private func sendEmailMessage() {
    #error("provide email to test")
    let email = ""
    let emailAddress = EmailAddress(unvalidated: email)!
    let messagePayload = MessagePayload(content: "Hello from space!", email: emailAddress)

    NSLog("send: start; parcelId=\(messagePayload.parcelId)")

    SomewearDevice.instance.send(payload: messagePayload)
        .then { _ in
            NSLog("send: success; parcelId=\(messagePayload.parcelId)")
        }
        .catch { error in
            NSLog("send: failure; error=\(error)")
    }
}
```

Handle progress updates for outbound payloads and receive inbound payloads.
```swift
private let disposeBag = DisposeBag()

override func viewDidLoad() {
    super.viewDidLoad()

    // handle status updates
    SomewearDevice.instance.payload
        .subscribe(onNext: { [unowned self] value in
            self.didReceivePayload(value)
        })
        .disposed(by: disposeBag)
}

private func didReceivePayload(_ payload: DevicePayload) {
    if let messagePayload = payload as? MessagePayload {
        NSLog("messageSendUpdate: parcelId=\(messagePayload.parcelId); status=\(messagePayload.status)")
    }
    else if let dataPayload = payload as? DataPayload {
        NSLog("dataSendUpdate: parcelId=\(dataPayload.parcelId); status=\(dataPayload.status)")
    }
}
```
