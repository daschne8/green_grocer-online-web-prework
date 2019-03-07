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

      if cart_item_hash[:count] - coupon[:num] >= 0
        cart_item_hash[:count] -= coupon[:num]
        item_name += " W/COUPON"
        cart[item_name] ||= {
          price:coupon[:cost],
          clearance:cart_item_hash[:clearance],
          count:-0
        }
        cart[item_name][:count] += 1
      end
    end
  end
    return cart
end

def apply_clearance(cart)
  cart.each do |item,item_data|
    if item_data[:clearance]
      item_data[:price] = (item_data[:price] * 0.80).round(2)
    end
  end
end

def checkout(cart, coupon)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupon)
  cart = apply_clearance(cart)
  cart.each do |item_name,item_data|
    total += (item_data[:price] * item_data[:count])
  end

  if total > 100
    total = (total * 0.90).round(2)
  end
  return total
end

puts "pry out"
