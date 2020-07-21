require_relative './part_1_solution.rb'
require 'pry'
  
  #iterate through cart
  #compare item : value with coupon item 
  #subtract current item count with coupon num 
  #if( count / num ) >= 1  
  # then i modify cart item count to equal (count / num rounded down)  * num 
  #add to cart item with item + discount 

  # REMEMBER: This method **should** update cart

def apply_coupons(cart, coupons)
  copy_item = nil
  original_item_count=0
  text= ' W/COUPON'
  coupon_tot = 0

  cart.each do |item|
    coupons.each do |coupon|
      if(item[:item] == coupon[:item] && item[:count] / coupon[:num] >=1)
        original_item_count = item[:count]
        coupuon_tot = (item[:count] / coupon[:num]).floor
        item[:count] = item[:count] - (((item[:count] / coupon[:num]).floor) * coupon[:num])
        copy_item = item.clone
        copy_item[:count] = original_item_count - item[:count]
        copy_item[:item] = copy_item[:item] + text
        copy_item[:price] = coupon[:cost] / coupon[:num]
        cart.push(copy_item)
      end
    end 
  end 
  cart
end


def apply_clearance(cart)
  cart.each do |item|
    if(item[:clearance] == true)
      item[:price] = (item[:price] * 0.8).round(2)
    end 
  end 
end

def checkout(cart, coupons)
  tot = 0
  new_consolidated = consolidate_cart(cart)
  apply_coupons(new_consolidated, coupons)
  apply_clearance(new_consolidated)
  
  new_consolidated.each do |item|
    tot += (item[:count] * item[:price])
  end 
  if(tot > 100)
    tot = (tot * 0.9).round(2)
  end
  tot
end




