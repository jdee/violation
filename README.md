Violation
=========

```
NOTE: This software is currently unreleased. Look for a release when Xcode 6 and iOS 8 near
production.
```

Violation is a framework comprising a custom gesture
recognizer for iOS, a custom control that uses it and a customizable, general-purpose button.

The word _violation_ is a loaded term in computing, referring to a runtime error or the failure to
observe the terms of a license. It's short and memorable, and happily it does not conflict with other
software companies or products.

See [iOS Knob Control and Violation](https://gist.github.com/jdee/f3eeadeb0eaec725edd8).

Requirements
============

Violation is an iOS framework you can build and import as an external dependency to any iOS project.
Building iOS frameworks is new in Xcode 6. You cannot build Violation directly with Xcode 5 or lower.
Xcode6-Beta6 is required.

Violation requires iOS 6.0 or higher.

Swift requires iOS 7.0 or higher. Use the Objective-C demo on an iOS 6 device.

Quick demo
==========

1. Open the Violation.xcworkspace file in this directory using Xcode6, either by double-clicking
the file or using File > Open in Xcode. The workspace contains projects to build the framework
and two demos.
2. In the upper left-hand corner of Xcode, select the app you want to run (ViolationDemo-ObjC
or ViolationDemo-Swift; the contents of the apps are the same) and a device or simulator to run on. 
Unlock the device if it's locked.
3. Click the triangular run button to the left. The framework and app will be built and run on the
device or simulator.

In this folder
==============

There are three subdirectories here that contain Xcode projects. Violation contains the project
to build the framework. ViolationDemo-ObjC and ViolationDemo-Swift contain two demo apps. Each app has
the same content; they are just examples of use in two different languages. The two demo projects share
the same asset catalog, Images.xcassets in this directory. Violation.xcworkspace is used to build the
framework and both the demo apps in the right order to satisfy dependencies.

The IOSKnobControl subdirectory contains an external dependency for the demo apps. See
[iOS Knob Control and Violation](https://gist.github.com/jdee/f3eeadeb0eaec725edd8).

The doc subdirectory contains HTML documentation generated from the public framework headers using
Doxygen in doc/html (see doc/html/index.html).

The ChangeLog contains the project's release history, not a record of individual changes (for which see
the commit history).

The project in the Violation subdirectory is a standalone framework project that can be built
separately, using command-line tools or Xcode. Each of the demo projects depends on Violation.framework,
the product of the framework project in the Violation subdirectory. The easiest way to build and run the
demo apps is using the Xcode workspace in this directory, Violation.xcworkspace. See Quick Start above.

Static library
==============

Currently, the framework is built as a static library. It should be possible instead to build a dynamic
library, but there are issues, including possibly bugs in Xcode and almost certainly driver error. For
now, the static library approach works in the demo apps and a separate app as well. Stay tuned for more
info.

Unfortunately, this means that Violation.framework cannot dynamically pull in its dependencies: UIKit,
CoreGraphics and CoreText. These dynamically-linked frameworks must be explicitly included in your
app's dependencies. UIKit and CoreGraphics are very common. You will likely have to add CoreText to
your app project, unless you are already using it.

Other versions of Xcode
=======================

It may be possible to use Violation with other versions of Xcode, in case you cannot use Xcode6-Beta6
for any reason. But these methods are not yet well tested and may lead to further issues that have not
yet been discovered. Please use Xcode6-Beta6 if possible, but if you cannot for some reason, here are
some workarounds.

Xcode5 (non-framework)
----------------------

You can still use Violation, but not as a framework. You can also simply add all the .h and .m files
from the Violation/Violation subdirectory to your project. Be sure to put them in a subdirectory
called Violation and `#import <Violation/Violation.h>`. `@import Violation;` will not work, since
Violation is not a framework or a module here. The individual source files will be compiled
into your app, much like using a static library. In this case, you should be sure to
`#define VIOLATION_NO_FRAMEWORK` when building. This suppresses some framework-related symbol
references that can otherwise cause a link error. This method should work with any version of Xcode,
but the framework should be preferred if you are able to build it.

Release builds
==============

It may be possible to perform Release builds to package Violation as a binary framework for direct 
inclusion as a dependency of other projects, but there may still be issues. Stay tuned for more 
information on this topic, and simply include Violation.xcodeproj in your project workspace for now.
Archiving your app for a Release build in this configuration should work fine.

API documentation
=================

The header (.h) files from the Violation framework contain extensive documentation that can be
processed by a program like Doxygen or AppleDoc to produce HTML documentation. The HTML documentation
generated by Doxygen using the Doxyfile in the top directory is included here. See
doc/html/index.html.

License
=======

The software and media here are available under
[The BSD 3-Clause License](http://opensource.org/licenses/BSD-3-Clause):

```
Violation
Copyright (c) 2014, Jimmy Dee
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions
and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions
and the following disclaimer in the documentation and/or other materials provided with the
distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse
or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
```
