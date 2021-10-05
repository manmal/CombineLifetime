import Combine
import Foundation

public final class Lifetime: Hashable, Cancellable {
    private let uuid = UUID()
    private var cancellables: Set<AnyCancellable> = .init()
    public private(set) var hasEnded = false

    public init() {}

    deinit {
        cancel()
    }

    public func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables = .init()
        hasEnded = true
    }

    public func observeEnded(_ closure: @escaping () -> Void) {
        cancellables.insert(AnyCancellable(closure))
    }

    public static func += (lifetime: Lifetime, cancellable: Cancellable?) {
        guard let cancel = cancellable?.cancel else { return }
        lifetime.observeEnded(cancel)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    public static func == (lhs: Lifetime, rhs: Lifetime) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
