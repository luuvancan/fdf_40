Category.create!(name: "Bong da")

Category.create!(name: "Bong da 1",
                 parent: 1)

Category.create!(name: "Bong da 2",
                 parent: 2)

categories = Category.order(:created_at).take(3)
10.times do
  name = Faker::Lorem.sentence(5)
  description = Faker::Lorem.sentence(15)
  categories.each {|category| category.products.create!(name: name,
    price: 20, description: description)}
end

User.create!(full_name: "Tran Thi Mai Hoa",
             email: "maihoa100996@gmail.com",
             password: "1234567",
             password_confirmation: "1234567",
             address: "Nam Dinh",
             phone: "0974879729",
             sex: 1,
             role: 1)

10.times do |n|
  full_name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  address = "Nam Dinh"
  phone = "0974879729"
  User.create!(full_name: full_name,
               email: email,
               password: password,
               password_confirmation: password,
               address: address,
               phone: phone,
               sex: 1,
               role: 0)
end

users = User.order(:created_at).take(6)
10.times do
  date_order = Date.today
  users.each {|user| user.orders.create!(date_order: date_order, total_price: 300, status: 1)}
end

orders = Order.all
products = Product.all[1..5]
5.times do
  orders.each {|order| products.each{|product| order.order_details.create!(price: product.price, quantity: 6, product_id: product.id)}}
end
