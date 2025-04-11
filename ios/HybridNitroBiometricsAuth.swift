import Foundation
import NitroModules
import LocalAuthentication


class HybridNitroBiometrics: HybridNitroBiometricsSpec {
    private let biometricAuthService = NitroBiometricsService()
    
    func isAvailable() throws -> Promise<Bool> {
        return .async { [weak self] in
            guard let self else {
                return false
            }
            return self.biometricAuthService.isBiometricAuthAvailable()
        }
    }
    
    func authenticate(options: NitroBiometricsOptions) throws -> Promise<Bool> {
        return .async { [weak self] in
            guard let self else {
                return false
            }
            do {
                return try await self.biometricAuthService.authenticate(reason: options.reason)
            } catch {
                throw error
            }
        }
    }
    
    func getAvailableBiometryType() throws -> Promise<NitroBiometryType> {
        return .async { [weak self] in
            guard let self else {
                return .none
            }
            return self.biometricAuthService.getBiometricType()
        }
    }
}
