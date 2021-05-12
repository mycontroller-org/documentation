---
title: "Setup Telegram Bot"
linkTitle: "Setup Telegram Bot"
weight: 1
---
This document helps to setup your telegram to receive messages from MyController.<br>
MyController needs a telegram `token` and a `chat id` and/or `group id` to send a messages.<br>
  * [Create a bot and generate a token](#create-a-telegram-bot)
  * [Get user `chat id`](#get-user-chat-id)
  * [Get `group id`](#get-group-chat-id)

## Create a telegram bot
Open [Telegram messenger](https://telegram.org/apps), sign in to your account or create a new one.
1. Enter `@Botfather` in the search tab and choose this bot.<br>
   **Note:** official Telegram bots have a <span style="color:blue">blue checkmark</span> beside their name
2. Click `START` to activate BotFather bot. In response, you receive a list of commands to manage bots.
3. Choose or type the `/newbot` command and send it.
4. Choose a name for your bot. And choose a username for your bot, the bot can be found by its username in searches.
   The username must be unique and end with the word `bot`
5. After you choose a suitable name for your bot, the bot is created. You will receive a message with a link to your bot `t.me/<bot_username>`, recommendations to set up a profile picture, description, and a list of commands to manage your new bot.
6. To connect a bot to MyController you need a token. Copy your token value and add it in to [Telegram handler](/docs/user-interface/operations/handlers/#telegram-handler).

## Get user chat id
User chat id can be extracted via API or with a supported bot.<br>
Here the details are given to get `chat id` via `MyController.org bot`<br>

* On your telegram application on the search input enter `mycontroller_org_bot`.<br>
  You can see `MyController.org bot` bot as shown blow.<br>
  ![telegram search mycontroller bot](/doc-images/telegram_chat_01_bot_search.png)<br>

* Click on the `START` to get connect with `MyController.org bot`<br>
  ![telegram start mc bot](/doc-images/telegram_chat_02_mc_bot_start.png)<br>

* `MyController.org bot` info will be as below,<br>
  ![telegram mc bot info](/doc-images/telegram_chat_03_mc_bot_info.png)<br>

* Send a text `chat id`, you will get a response with your `chat_id`<br>
  ![telegram get chat id](/doc-images/telegram_chat_04_chat_id.png)<br>


## Get group chat id
Group id can be extracted via API or with a known bot.<br>
Here the details are given to get group id via `MyController.org bot`<br>

* Open your group and click on `Add members`<br>
  ![telegram add member](/doc-images/telegram_group_01_add_member.png)<br>

* on the search input type `mycontroller_org` then select `MyController.org bot` and click on `ADD`<br>
  ![telegram add to group](/doc-images/telegram_group_02_add_mc_bot.png)<br>

* Send a text `chat id`, you will get a response with your `group_id` and `chat_id`<br>
  ![telegram group id](/doc-images/telegram_group_03_group_id.png)<br>