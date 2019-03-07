require 'pry'

def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    name = item.keys[0]
    item_data = item.values[0]
    item_data[:count] ||= 0
    new_hash[name] ||= item_data
    new_hash[name][:count] += 1
  end
  return new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    cart_item_hash = cart[item_name]
    if cart.has_key?(item_name)
      if cart_item_hash[:count] - coupon[:num] <= 0
        cart_item_hash[:count] = 0
        #cart.delete(item_name)
      else
        cart_item_hash[:count] -= coupon[:num]
      end
      item_name += " W/COUPON"
      cart[item_name] ||= {
        price:coupon[:cost],
        clearance:cart_item_hash[:clearance],
        count:-0
      }
      cart[item_name][:count] += 1
    end
  end
    return cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupon)
  # code here
end

def item_coupon
  item = {
    "AVOCADO" => {:price => 3.0, :clearance => true, :count => 2}
  }
  coupon = [
    {:item => "AVOCADO", :num => 2, :cost => 5.00}
  ]
  return item,coupon
end



binding.pry
puts "pry out"
