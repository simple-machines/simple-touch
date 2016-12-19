# SimpleTouch

Very simple swift wrapper for Biometric Authentication Services (Touch ID) on
iOS.

Sample Project
--------------
There is a `SimpleTouchDemo` target defined in the project file. This will run in
the Simulator or on a device.

Installation
------------

### Carthage

Add the following to your `Cartfile`

```
github "simple-machines/simple-touch"
```

### Manual

- Drag and drop `SimpleTouch.xcodeproj` into your project in Xcode.
- Add the SimpleTouch framework `SimpleTouch (SimpleTouch)` as a `Target
Dependency` in `Build Phases` in your project.
- Add `SimpleTouch.framework` in the `Link Binary With Libraries` step in `Build
Phases` in your project if it's not there already.

Use
---

First of all, import the framework:

```
import SimpleTouch
```

Then, check for Touch ID support:

```
switch SimpleTouch.isTouchIDEnabled {
case .success:
  // All is good. Can use Touch ID for authentication
  break
case .error(let error):
  // TouchID cannot be used. Interrogate error to see why
  break
}
```

Finally, attempt to authenticate with Touch ID:
```
SimpleTouch.presentTouchID("Testing Touch ID", fallbackTitle: "Fallback Method") { response in
  switch response {
  case .success:
    // Successful authentication
    break
  case .error(let error):
    // Authentication failed. Interrogate error to see why
    break
  }
}

```

Contributing
------------
We :heart: pull requests. If you'd like to see new features, fix bugs, or lodge
issues then please do so via Github.

License
-------
SimpleTouch is released under an MIT license. See LICENSE.md for more
information.
