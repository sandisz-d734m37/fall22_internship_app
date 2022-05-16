# README
_Note: this Rails application was created for a Shopify internship application_
_Note: this Rails application runs on Ruby 2.7.4 and Rails 5.2.8, both must be installed in order to run this app._

<h1>Welcome to the Real Corp Shipment Service GitHub Repository!</h1>
<hr>
<h3>The Real Corp Shipment Service is a fully-tested Ruby on Rails app which allows users to create items and shipments for Real Corp. Each item will have has it's own inventory. When a shipment is created, each of the inventory of each item included in the shipment will be updated accordingly.</h3>



There are a few ways to run this app:

Option 1, run with Replit:
  (something something something replit)
  
Option 2, clone and run locally:
 1. Clone this repo
 2. Navigate into this repo within your terminal (`$cd fall22_internship_app`)
 3. Run `$bundle` in your terminal
 4. Run `$rails db:create` in your terminal
 5. Run `$rails db:migrate` in your terminal
 6. Run `$rails s` in your terminal
 7. Navigate to `http://localhost:3000/` in your browser

<hr>

<h2>Functionality</h2>

Now that you've made it this far, you'll notice you don't have any items and you can't create a shipment without any items.

To recognize the functionality of this app, follow these steps:
  1. Click `Create a new item` and create an item with some inventory (if the inventory is 0, you won't be able to create a shipment for it)
  2. After creating a new item, either navigate to the shipment index or the home page (links at top of page)
  3. Once on either of these pages, click `Create a new shipment` and create a shipment and select how many of your item you'd like to add to your shipment.
  4. Click `Create shipment`
  5. Now, you should be on that shipment's page and see all of the information regarding this shipment, including the item you added to it.
  6. From this page, click on the name of your item. You should now be on that item's page
  7. Notice that that items inventory has been changed! If you created an _incoming_ shipment, it should have a _higher_ inventory. If your shipment was _outgoing_, the item should have a _lower_ inventory.
