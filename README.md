# Sign Language
A FiveM script written in LUA that implements the /sign command

The /sign command allows you to display a specific text above the player using this command.
It also make the player playing random animations by words.

<img src=https://i.imgur.com/Tdc8DPd.png>

## Installation
* Download the resource ;
* Drag and drop it into your resources folder ;
* Add ```ensure cham-signlanguage``` to your server configuration file.

## How to use
* In the chat, type /sign followed by the text you wanna sign.

## Options 
| Parameter | Line | Description |
| --- | --- | --- |
| color | ```config.lua``` : line 2 | Color of the text, default : ```color = { r = 230, g = 230, b = 230, a = 255 }``` |
| font | ```config.lua``` : line 3 | Font of the text, default : ```font = 0``` ([available fonts](https://imgur.com/a/oV3ciWs)) |
| time | ```config.lua``` : line 4 | Time displayed after last word in ms, default : ```time = 5000``` |
| wordInterval | ```config.lua``` : line 5 | Internval between words in ms, default : ```700``` |
| scale | ```config.lua``` : line 6 | Scale of texte, default : ```0.6``` |
| sdistcale | ```config.lua``` : line 7 | Distance max, default : ```250``` |
| animationSpeed | ```config.lua``` : line 8 | Speed of the animation, default : ```50.0f``` |
| lastAnimationSpeed | ```config.lua``` : line 9 | Speed of the last animation, default : ```1.0f``` |
| animationList | ```config.lua``` : line 10 | List of animations (dictionary and name)|


#### V1.0
* Adding de /sign command
* Adding animations durins text displaying
* Multiple `/sign` do not stack anymore but get replaced

## Note
* This script is base on the script [3D /me](https://github.com/eblio/3dme)
* This could conflict with other scripts registering a /sign command
* This script is fully standalone.
