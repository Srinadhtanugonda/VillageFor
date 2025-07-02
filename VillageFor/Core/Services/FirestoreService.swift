import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    
    // Get a reference to the 'users' collection in Firestore
    private let usersCollection = Firestore.firestore().collection("users")
    
    // Saves the user's profile data to Firestore
    func saveUserProfile(user: User) async throws {
        // We use the user's unique ID (from Firebase Auth) as the document ID
        // This links the auth user to their database record.
        // The `Codable` conformance on our User model lets us do this easily.
        try usersCollection.document(user.id).setData(from: user, merge: true)
    }
}