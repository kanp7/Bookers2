class ChatsController < ApplicationController

  def show
  	@user = User.find(params[:id])
  	rooms = current_user.user_rooms.pluck(:room_id) 	#user1(ログインユーザー)に紐づく部屋の配列を取得(user1のroom1,room2)
  	user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)	#user2(表示先user)のuser1と紐ついたroomを取得

  	unless user_rooms.nil?
  		@room = user_rooms.room 	#user1とuser2の部屋があったら@roomに代入
  	else
  		@room = Room.new	#共通部屋がなければ、部屋を作って保存、id1のroomが作成される
  		@room.save
  		UserRoom.create(user_id: current_user.id, room_id: @room.id)	#id1のroom(@room.id)に対して、ユーザー2人分の入り口を作る
  		UserRoom.create(user_id: @user.id, room_id: @room.id)
  	end
  	@chat = Chat.new(room_id: @room.id)	#form_withに渡す空のインスタンスのルームIDを指定、Chat.newなのでフォームの内容をcreateアクションへ

  	# @chats = Chat.where(room_id: @room.id) 下記と同じ
  	@chats = @room.chats 	#部屋のidを指定して、その中のチャットの情報を@chatsへ代入
  end

  def create
  	# @chat = Chat.new(chat_params) 	form_withで送信された値をを受け取り
  	# @chat.user_id = current_user.id 	Chatモデルのuser_idに現在のログインユーザーのIDを保存する
  	@chat = current_user.chats.new(chat_params)
  	@chat.save
  end

  	private
	def chat_params
		params.require(:chat).permit(:message, :room_id)
	end
end

