import Foundation
#if canImport(secp256k1)
import secp256k1
#endif

// MARK: - FFI.ECDSAWithKeyRecovery.Wrapped
extension FFI.ECDSAWithKeyRecovery {
	struct Wrapped: @unchecked Sendable, ContiguousBytes, WrappedECDSASignature {
		typealias Raw = secp256k1_ecdsa_recoverable_signature
		let raw: Raw
		init(raw: Raw) {
			self.raw = raw
		}
	}
}

// MARK: Sign
extension FFI.ECDSAWithKeyRecovery.Wrapped {
	static func sign() -> (OpaquePointer, UnsafeMutablePointer<Raw>, UnsafePointer<UInt8>, UnsafePointer<UInt8>, secp256k1_nonce_function?, UnsafeRawPointer?) -> Int32 {
		secp256k1_ecdsa_sign_recoverable
	}
}

// MARK: ContiguousBytes
extension FFI.ECDSAWithKeyRecovery.Wrapped {
	func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
		var rawData = raw.data
		return try Swift.withUnsafeBytes(of: &rawData) { pointer in
			try body(pointer)
		}
	}
}
