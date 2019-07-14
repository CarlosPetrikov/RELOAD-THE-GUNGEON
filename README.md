![1](https://user-images.githubusercontent.com/52867795/61187357-e3b93c80-a646-11e9-8c6b-97a4f0a3ba09.png)

# (AUTO) RELOAD THE GUNGEON

This script is intended to allow you to **backup and restore the save data** from the game Enter the Gungeon, either manually or automatically.

### INSTALLATION

- Download the &quot; **Reload\_the\_Gungeon.bat**&quot; script through the &quot; **Clone or Download**&quot; button and run it like any other program (easy, huh?).

- If you want to use the &quot; **Loop Mode**&quot; (automatic backup and restore mode): Open the batch file with your favorite text editor (it can be the Windows notepad). Right at the beginning, you will find the following line of code (put the location of your game&#39;s executable there):
<p align="center">
<img src="https://user-images.githubusercontent.com/52867795/61187368-f3388580-a646-11e9-9104-c6c030403eef.PNG">
</p>

- And if your **slot is different from A** , modify the following line:
<p align="center">
<img src="https://user-images.githubusercontent.com/52867795/61187378-03e8fb80-a647-11e9-8893-92e876683db1.png">
</p>

### USAGE EXAMPLE

The program has **3 modes** of operation:

**1 - Backup Mode**: Perform a backup of your current save (which is done by talking to the Save Button NPC and choosing the option &quot;Save and Exit&quot;).

**2 - Restore Mode**: Restores a previously made backup.

**3 - Loop Mode**: (It was because of this mode, that the project name has the &quot;auto&quot;) Restore a previously made backup and start the game. After this, every time the scripts detects that the player&#39;s life has reached to 0, the script restarts the game. Also, once a chamber is finished, you can go straight to the next one, because the current save backup will already be done automatically.

The only negative point in this mode, is **the following problem** that I still can&#39;t solve:: If you use it by **playing co-op** , once the life of one of the players reaches 0, the game will restart automatically (even if the other remains alive or not).

### TESTED ON

This script has been tested on the following software specifications:

**OS** - Windows 7 Professional x64 | **Game version** - 2.1.9A (Epic Games Store).

### RELEASE HISTORY

- **0.0.1** - First release!

### AUTHOR

**Carlos Petrikov** - Initial work

I do not have much experience programming, but I did my best to make the code clearer and commented as much as possible. So more experienced developers who visited my page, feel free to modify, replicate or even rewrite the code! The intention with this project is just to help people (and help me) who wanted an easier way to save scum this game.

### THANKS TO

**Lincoln Sposito** (by the base version of the code to separate a string from findstr), **DPSkinner** (by the layout and code of the batch menu), **CheatyMcCheater** (by the topic that explained which files and keys I have to modify, to enable save scumming), **BiluThanos and Mulder182** (by the README review and suggestions).

### LICENSE

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details

**This script is not approved or affiliated with Dodge Roll and Devolver Digital. We have no intentions to infringe upon the exclusive rights to the content belonging to Dodge Roll.**
