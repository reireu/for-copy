require 'thread'

# スレッド間でデータをやり取りするためのキューを作成
queue = Queue.new

# スレッドを作成
background_thread = Thread.new do
  loop do
    # キューからデータを取り出して処理する
    note, day = queue.pop
    puts "通知: '#{note}' を '#{day}' に予定しました。"
  end
end

# メインスレッドの処理
puts "メインスレッドの処理を実行中..."

loop do
  # ユーザーの入力を受け取る
  puts "通知したいことを入力してください (終了するには 'exit' と入力してください)"
  note = gets.chomp
  break if note == 'exit'

  puts "通知する日付を入力してください"
  day = gets.chomp

  # 入力されたデータをキューに渡す
  queue << [note, day]
end

# プログラムが終了する前にスレッドを終了させる
background_thread.kill
puts "プログラムを終了します。"
