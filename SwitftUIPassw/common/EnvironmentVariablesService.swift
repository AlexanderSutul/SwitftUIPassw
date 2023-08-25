import Foundation

enum EnvironmentVariablesService {
    static func getHost() -> String? {
        if let myEnvVar = ProcessInfo.processInfo.environment["HOST"] {
            return myEnvVar
        }
        return nil
    }
}
