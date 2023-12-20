class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
	if current_customer.cart_items.count >= 1 #カート内に商品があるか？
	  if nil != current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #カートに入れた商品はすでにカートに追加済か？
		   @cart_item_u = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #カート内のすでにある商品の情報取得
		   @cart_item_u.amount += params[:cart_item][:number_of_items].to_i #既にある情報に個数を合算
		   @cart_item_u.update(amount: @cart_item_u.amount) #情報の更新　個数カラムのみ
		   redirect_to cart_items_path #カートページ遷移
		else
			 	@cart_item = CartItem.new(cart_item_params) #新しくカートの作成
			  @cart_item.customer_id = current_customer.id #誰のカートか紐付け
		  if @cart_item.save #情報を保存できるか？
				 redirect_to cart_items_path #カートページ遷移
		  else
				@items = Item.where(is_active: 0) #販売ステータスが「0」のものを見つける
		    @quantity = Item.count #商品の数をカウント
		     #有効、無効ステータスが0のものを見つける
				render 'index' #indexアクションを呼び出す
		  end
	  end

	else
		@cart_item = CartItem.new(cart_item_params)#新しくカートの作成
		@cart_item.customer_id = current_customer.id#誰のカートか紐付け
		if @cart_item.save#情報を保存できるか？
			 redirect_to cart_items_path#カートページ遷移
		else
			@items = Item.where(is_active: 0)#販売ステータスが「0」のものを見つける
	    @quantity = Item.count#商品の数をカウント
	    #有効、無効ステータスが0のものを見つける
			render 'index'#indexアクションを呼び出す
		end
	end
  end

  def update
  end

  def destroy
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
