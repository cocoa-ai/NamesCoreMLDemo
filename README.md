# Names CoreML Demo

A Demo application using `CoreML` framework for predicting gender from first
names.

<div align="center">
<img src="https://github.com/cocoa-ml/NamesCoreMLDemo/blob/master/Screenshot.png" alt="NamesCoreMLDemo" width="300" height="533" />
</div>

## Model

This demo is based on [An introduction to Machine Learning](http://nlpforhackers.io/introduction-machine-learning/) tutorial, which describes how to build a classifier able to distinguish between
boy and girl names using [datasets](https://www.ssa.gov/oact/babynames/limits.html)
with the popularity of baby names over the years from The US Social Security
Administration.

[CoreML model](https://github.com/cocoa-ml/NamesCoreMLDemo/blob/master/Names/Resources/NamesDT.mlmodel)
were converted from [Scikit-learn Pipeline](http://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html)
using [coremltools](https://pypi.python.org/pypi/coremltools) python package.

You can find training and conversion source code [here](https://github.com/cocoa-ml/NamesCoreMLDemo/blob/master/Classifier/names.py).

## Requirements

- Xcode 9
- iOS 11

## Installation

```sh
git clone https://github.com/cocoa-ml/FacesVisionDemo.git
cd FacesVisionDemo
pod install
open FacesVisionDemo.xcworkspace/
```

Build the project and run it on a simulator or a device with iOS 11.

## Author

Vadym Markov, markov.vadym@gmail.com

## Credits

- [Is it a boy or a girl? An introduction to Machine Learning](http://nlpforhackers.io/introduction-machine-learning/) from http://nlpforhackers.io

## References
- [Apple Machine Learning](https://developer.apple.com/machine-learning/)
- [CoreML Framework](https://developer.apple.com/documentation/coreml)
- [coremltools](https://pypi.python.org/pypi/coremltools)
