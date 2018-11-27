# XCUITestRecorder

Records each UI Test to a video file and log file, so that you can see how the UI Test failed.

Works on Xcode 10 (well I've used 10.1 but it probably works on 10 too)

## Usage

`xcuitestrecorder SIMULATOR_NAME OUTPUT_DIRECTORY`

Simply pipe the xcodebuild output to xcuitestrecorder:

    xcodebuild -destination 'platform=iOS Simulator,name=iPhone 8' \
               -workspace MyApp.xcworkspace \
               -scheme MyAppUITests \
               -parallel-testing-enabled NO \
               test | xcuitestrecorder "iPhone 8" videos`
               
If your scheme has parallel testing enabled then the `-parallel-testing-enabled NO` is required as unfortunately `simctl` doesn't seem to work with simulator clones that were added in Xcode 10 to enable running UI Tests in parallel. 

Using the command line argument to disable parallel testing allows you to still have parallel testing within Xcode, without having another scheme.

## To Do

* Automatically detect the simulator name/identifier from the Xcode output
* Create a viewer which can sync up the log and video and allow stepping through
