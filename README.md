# 說明

此文件為 AmazingTalker 的 Backend 模擬考題

目標是協助面試者了解評分的標準

題目和需求為面試題目，瀏覽者可以先停下來，思考自己的解法

範例啟動與測試方法以下，則是示範解法與導覽

# 題目

實作通知推播系統

使用者的通知管道有
- email
- sms
- telegram

使用者的語系有
- zh-TW
- en

PD 會希望在特定的時間通知使用者，例如
- 註冊成功: email & sms
- 學生預約課程: email & telegram
- 學生取消課程: email & telegram

# 需求

請以程式碼的描述性以及擴充性為主設計該通知推播系統

寄送實體不用實作，直接將結果以字串印出來即可

例如
```
def send_to_apple(token)
  puts("[apple][%{token}] message")
end
```

# 範例啟動 及 測試方式

```
docker-compose build
docker-compose run --rm rails bin/rails c
```

因為有事先在資料庫放入兩個使用者與一堂預約，可以直接在 rails console 測試

```
# 不同語系的使用者
en_user = User.find_by(email: 'john@email.com')
zh_user = User.find_by(email: 'jane@email.com')

# 模擬事件觸發
Event::User::Auth::Register.dispatch(en_user)
Event::User::Auth::Register.dispatch(zh_user)

# 其它事件
appointment = Appointment.first
Event::Teacher::Appointment::Booked.dispatch(appointment.teacher, appointment: appointment)
Event::Teacher::Appointment::Canceled.dispatch(appointment.teacher, appointment: appointment)
```

# 範例評分

該範例的指標實作位置為 `app/amazingtalker/event`

將寄發的邏輯與各種方式的實作盡可能在 `app/amazingtalker/event/base.rb` 裡去做自動化

而未來每當舊事件異動或是新事件產生時，只需要維護`app/amazingtalker/event/user/*` 或是 `app/amazingtalker/event/teacher/*`

而該檔案裡面的結構，也只留下必要的參數以提昇自描述的效果

如果有新增通知方法，只要先在 base 裡挷定推播實體，就可以大量運用在其它事件

# 其它說明

* 翻譯檔位於 `config/locales/event/*`
* 日常的情境為request 進入到controller時，跑完business layer 即可觸發事件。參考`app/controllers/application_controller.rb`
