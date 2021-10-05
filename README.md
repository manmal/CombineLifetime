# CombineLifetime

When subscribing to a Swift Combine Publisher, we use a `Set<AnyCancellable>` most of the time, like this:

```swift
publisher
  .sink { value in
    // Do something with value
  }
  .store(in: &cancellables)
```

The problem with this is that `Set` is a value type, so it cannot be mutated if the owner is immutable. It is painful to use when the  `Set<AnyCancellable>` needs to be stored in a `struct` or `enum`.

The solution for this is `Lifetime`, heavily inspired by [ReactiveSwift's implementation](https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Sources/Lifetime.swift). It's a `final class`, wraps a `Set<AnyCancellable>`, conforms to `Cancellable` and `Hashable`, and offers a convenient `+=` operator:

```swift
lifetime += publisher
  .sink { value in
    // Do something with value
  }
```

Like any other `Cancellable`, it cancels the work automatically when it is deallocated, so make sure to keep its instance around.

## Contact

🐦 Contact me via Twitter [@manuelmaly](https://twitter.com/manuelmaly)

## 1.0.0

- Added initial implementation and tests
