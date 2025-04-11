//
//  NitroBiometricsService.swift
//  Pods
//
//  Created by Patrick Kabwe on 10/04/2025.
//

import Foundation
import LocalAuthentication

final class NitroBiometricsService: NSObject {
    private let authContext = LAContext()
    private var error: NSError?
    
    
    func isBiometricAuthAvailable() -> Bool {
        #if os(iOS)
        guard #available(iOS 11.0, *) else {
            return false
        }
        #endif
        let canEvaluatePolicy = authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        if !canEvaluatePolicy {
            #if DEBUG
            print("NitroBiometrics authentication is not available.")
            #endif
            return false
        }
        #if DEBUG
        print("NitroBiometrics authentication is available.")
        #endif
        return authContext.biometryType != .none
    }
    
    func authenticate(reason: String) async throws -> Bool {
        return try await withUnsafeThrowingContinuation { continuation in
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticateError in
                DispatchQueue.main.async {
                    if success {
                        continuation.resume(returning: true)
                    } else if let error = authenticateError {
                        #if DEBUG
                        print("NitroBiometrics authentication failed: \(error.localizedDescription)")
                        #endif
                        continuation.resume(throwing: error)
                    } else if let error = self.error {
                        #if DEBUG
                        print("NitroBiometrics authentication failed: \(error.localizedDescription)")
                        #endif
                        continuation.resume(throwing: error)
                    } else {
                        #if DEBUG
                        print("NitroBiometrics authentication failed: unknown error")
                        #endif
                    }
                }
            }
        }
    }
    
    func getBiometricType() -> NitroBiometryType {
        switch authContext.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchid
        case .faceID:
            return .faceid
        default:
            print("NitroBiometrics: Unsupported biometry type")
            return .none
        }
    }
}
