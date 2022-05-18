_Note: this Rails application was created for a Shopify internship application_

_Note: this Rails application runs on **Ruby 2.7.4 and Rails 5.2.8, both must be installed in order to run this app locally.**_

<h1>Welcome to the Real Corp Shipment Service GitHub Repository!</h1>
<hr>
<h3>The Real Corp Shipment Service is a fully-tested Ruby on Rails app which allows users to create items and shipments for Real Corp. Every item has it's own inventory. Each shipment has it's own items and each item in the shipment has a quantity. When a shipment is created or recieved, the inventory of each item included in the shipment will be updated accordingly.</h3>



There are a few ways to run this app:

Option 1, run with Heroku:

  -  Simply open this link: https://real-corp-shipping.herokuapp.com/
  
  From there, follow the steps in __Functionality__ below!
  
<h6>Dearest Shopifolk: I truly attempted to deploy this application on Replit. Because I was not able to pull it off, I opted to create a gist to document everything I tried, then deploy to Heroku instead of simply sending out an un-deployed app.</h6>
<h6>You can find my gist here: https://gist.github.com/sandisz-d734m37/b92ac17a199cb9a5a025f2cdc76e09ea (sorry it's a little wordy, I really wanted to include everything!)</h6>
<h6>You can find my attempted replit here: https://replit.com/@sandisz-d734m37/fall22internshipapp-3</h6>
  
Option 2, clone and run locally:
 1. Clone this repo
 2. Navigate into this repo within your terminal (`$cd fall22_internship_app`)
 3. Run `$bundle` in your terminal
 4. Run `$rails db:create` in your terminal
 5. Run `$rails db:migrate` in your terminal
 6. Run `$rails s` in your terminal
 7. Navigate to `http://localhost:3000/` in your browser

From there, follow the steps in __Functionality__ below!

_If you stop the rails server (Crtl + C), you can also run `$bundle exec rspec` in your terminal at this point to see all of this apps tests pass and get a look at this apps SimpleCov coverage_
   

<hr>

<h2>Functionality</h2>

Now that you've made it this far, you should notice you don't have any items and you can't create a shipment without any items.

_note: this may differ on Heroku as anyone with the Heroku link will be able to create items and shipments. Items may have been created, but feel free to delete all of them and see what happens!_

To recognize the functionality of this app, follow these steps:
  1. Click `Create a new item` and fill out the form to create an item with some inventory (you can set the inventory to 0, but if the inventory is 0, you won't be able to create a shipment for it.)
  2. Click `Create item`
  3. After creating a new item, either navigate to the shipment index or the home page (use the navigation links at the top of every page!)
  4. Once on either of these pages, click `Create a new shipment` 
  5. Let's start with an __outging__ shipment: fill out the form you see and __select the `Outgoing` checkbox__ to create an __outgoing__ shipment. 
Be sure to select your item and specify how many of this item will be in this shipment!
  6. Click `Create shipment`
  7. Now, you should be on that shipment's page and see all of the information regarding this shipment, including the item(s) you added to it.
  8. From this page, click on the name of your item. You should now be on that item's page.
  9. Notice that that items inventory has been changed! Because we just made an _outgoing_ shipment, the item has a _lower_ inventory.

Notice some other updated info on this item's page such as: 
- The shipment you just created should be displayed under the item's "All Shipments" section
- If the shipment is outgoing, the item's latest shipment section should also be updated with the date the shipment was created (Presumably todays date)

10. Now, let's make an __incoming__ shipment! 
    
    10 A. if your item's inventory was brought down to 0 by the outgoing shipment you just created, you will have to edit the item to give it an inventory above 0. __If your item inventory is above 0 already, you can skip down to step 11__
    
    10 B. From the item's show page, click `Edit this item`
    
    10 C. Add some inventory and click `Update Item`
    
11. Navigate to the shipments index or the home page and click `Create a new shipment`
12. Fill Out the form, but this time __leave the `Outgoing` checkbox unselected__ to create an __incoming__ shipment!
13. After selecting your item and inputting the item count, click `Create Shipment`
14. You should now be taken to that shipment's show page! 
    
    14 A. If you navigate to the item show page, you'll see your shipment listen under the all shipments section, but note there's still no date next to `Latest Incoming Shipment` and the item's inventory has not been updated. This is because these sections will not be updated until the incoming shipment has arrived!
15. From your new shipment's show page, click `Edit shipment`
16. From here, you'll be able to set the shipment as `Arrived`!
17. Go ahead and check the `Arrived` box and click `Update shipment`
18. Now if we navigate back to your item's show page, you'll see todays date next to `Latest Incoming Shipment` and you'll see the item's inventory is _higher_ because we just made and recieved an _incoming_ shipment!
    


<h4>If you'd like to learn a little more about the entire functionality and everything you should be able to do as a user, check out the issues/stories in the "Completed and Merged" section of the <a href="https://github.com/sandisz-d734m37/fall22_internship_app/projects/1">Projects board!</a></h4>
