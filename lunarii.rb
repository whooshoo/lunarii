require "discordrb"
require "json"
require "dotenv/load"

##TODO
# I should really add to the existing commands to allow the taking of more than one item at a time.
# I should fix a small issue with the items that have more than one capital letter in their names "Golem Design III" for example.

bot = Discordrb::Commands::CommandBot.new token: ENV["TOKEN"], prefix: ENV["PREFIX"]

itemInfo = JSON.parse(File.read("data.json"))

class String
  def neatness
    split.map(&:capitalize).join(" ")
  end
end

bot.command :test do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Perfect Price!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price"]
  end
end

# Announcement Command
bot.command :an, usage: "::an title and then = and now this is content/body" do |event, *args|
  array = args.join(" ").split("=")
  title = array[0]
  content = array[1]
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.add_field(name: title, value: content)
  end
end

bot.command :color do |event, *color|
  event.message.delete
  color.each do |color|
    event.channel.send_embed() do |embed|
      embed.colour = color
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://via.placeholder.com/100x100/" + color + "/" + color)
      embed.add_field(name: "The color you asked for is: ", value: color)
    end
  end
  nil
end

# Perfect Price Command
bot.command :pp do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Perfect Price!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price"]
  end
end

# Pefect Price when Popular Command
bot.command :ppp do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Perfect Price when the item is popular!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price (Popular)"]
  end
end

# Perfect Price when the client's Rich Command
bot.command :ppr do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Perfect Price when the client's rich!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price (Rich)"]
  end
end

# Perfect Price when the item is Popular and the Client's Rich Command
bot.command :pppr do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Perfect Price when the item is popular and the client's are rich!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price (Popular + Rich)"]
  end
end

# Max Price Command
bot.command :mp do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Max Price!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price"]
  end
end

# Max Price when Popular Command
bot.command :mpp do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Max Price when the item is popular!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price (Popular)"]
  end
end

# Max Price when the Client's Rich Command
bot.command :mpr do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Max Price when the clients are rich!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price (Rich)"]
  end
end

# Max Price when the item is Popluar and the Client's Rich Command
bot.command :mppr do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Max Price when it is popular and when clients are rich!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price (Popular + Rich)"]
  end
end

# Tier Command
bot.command :tier do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Tier!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Tier"]
  end
end

# Culture Command
bot.command :culture do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Culture!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Culture"]
  end
end

# Max Stack Command
bot.command :maxstack do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "#{item.join(" ").neatness}'s Max Stack amount!"
    embed.description = itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["maxStack"]
  end
end

# Full Item Summary Command
bot.command :item do |event, *item|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = item.join(" ").neatness
    embed.add_field name: "Perfect Price", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price"]
    embed.add_field name: "Perfect Price (Popular)", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price (Popular)"]
    embed.add_field name: "Perfect Price (Rich)", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price (Rich)"]
    embed.add_field name: "Perfect Price (Popular + Rich)", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Perfect Price (Popular + Rich)"]
    embed.add_field name: "Max Price", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price"]
    embed.add_field name: "Max Price (Popular)", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price (Popular)"]
    embed.add_field name: "Max Price (Rich)", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price (Rich)"]
    embed.add_field name: "Max Price (Popular + Rich)", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Max Price (Popular + Rich)"]
    embed.add_field name: "Tier", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Tier"]
    embed.add_field name: "Culture", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["Culture"]
    embed.add_field name: "Max Stack", value: itemInfo.select { |hash| hash["Name"].downcase == item.join(" ").downcase }.first["maxStack"]
  end
end

# Information Command
bot.command :info do |event|
  event.message.delete
  event.channel.send_embed do |embed|
    embed.colour = 0xa45189
    embed.title = "Commands"
    embed.description = ("```yaml
      ITEMS
Everything on an Item               | ::item Vine
Culture                             | ::culture Vine
Max Price                           | ::mp Vine
Max Price (Popular)                 | ::mpp Vine
Max Price (Popular + Rich)          | ::mppr Vine
Max Price (Rich)                    | ::mpr Vine
Max Stack                           | ::maxstack Vine 
Perfect Price                       | ::pp Vine
Perfect Price (Popular)             | ::ppp Vine
Perfect Price (Popular + Rich)      | ::pppr Vine
Perfect Price (Rich)                | ::ppr Vine
Tier                                | ::tier Vine
      Other Commands
Show the command menu               | ::info 
Invite the bot to your server!      | ::invite
```")
    embed.footer = Discordrb::Webhooks::EmbedFooter.new text: "Please note that the item names are not case-sensitive! 💜"
  end
end

# Invitation Command
bot.command :invite, chain_usable: false do |event|
  event.message.delete
  event.channel.send "https://discord.com/api/oauth2/authorize?client_id=551965228305350677&permissions=8&scope=bot"
end

# We must run this bit so the Rich Presence Status is updated.
bot.run :async
bot.update_status("online", "::info", nil, since = 0, afk = false, activity_type = 3)
bot.sync
