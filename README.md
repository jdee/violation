Violation
=========

Violation is a collection of utility software. For now, it's a framework comprising a custom
gesture recognizer for iOS and a custom control that uses it. In the future, it may
expand to include other sorts of software, for mobile platforms and otherwise.

The word _violation_ is a loaded term in computing, referring to a runtime error or
the failure to observe the terms of a license. It's short and memorable, and happily
it does not conflict with other software companies or products.

Requirements
============

Violation is an iOS framework you can build and import as an external dependency to any iOS
project. Building iOS frameworks is new in Xcode 6. You cannot build Violation directly with
Xcode 5 or lower. Xcode 6 is required.

Violation requires iOS 6.0 or higher.

Quick demo
==========

Open the Violation.xcworkspace file in this directory using Xcode 6, either by double-clicking
the file or using File > Open in Xcode. The workspace contains projects to build the framework
and two demos. In the upper left-hand corner of Xcode, select the app you want to run (ViolationDemo-ObjC
or ViolationDemo-Swift; the contents of the apps are the same) and a device or simulator to run on. 
Unlock the device if it's locked. Click the triangular run button to the left. The framework and app 
will be built and run on the device or simulator.

In this folder
==============

There are three subdirectories here that contain Xcode projects. Violation contains the project
to build the framework. ViolationDemo-ObjC and ViolationDemo-Swift contain two demo apps. Each app has the
same content; they are just examples of use in two different languages. The two demo projects share the
same asset catalog, Images.xcassets in this directory. Violation.xcworkspace is used to build the framework
and both the demo apps in the right order to satisfy dependencies.

The IOSKnobControl subdirectory contains an external dependency for the demo apps.

The project in the Violation subdirectory is a standalone framework project that can be built
separately, using command-line tools or Xcode. Each of the demo projects depends on Violation.framework,
the product of the framework project in the Violation subdirectory. The easiest way to build and run the
demo apps is using the Xcode workspace in this directory, Violation.xcworkspace. See Quick Start above.
