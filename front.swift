mport SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var note: String = ""
    @State private var day: String = ""
    
    var body: some View {
        VStack {
            TextField("通知したいことを入力", text: $note)
                .padding()
            
            TextField("通知する日付を入力", text: $day)
                .padding()
            
            Button("通知を予定する") {
                scheduleNotification()
            }
            .padding()
        }
        .padding()
    }
    
    func scheduleNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("通知が許可されていません")
                return
            }

            let content = UNMutableNotificationContent()
            content.title = "通知"
            content.body = note
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("通知のスケジュールに失敗しました: \(error.localizedDescription)")
                } else {
                    print("通知がスケジュールされました")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
