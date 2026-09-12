# Learning Vi/Vim


### INSERT MODE:

i - Default insert mode, where the curson stays at the same location

a - Add the next character (cursor will move to next location ready to add more text)

o - Insert a new line below and ready to insert text.



### VISUAL MODE:

Press v to enter visual mode, it can be used to select text, copy , cut etc.

Operations:

1. Select text - Use arrow keys to select text

2. Delete the seletec text -  d

3. Copy text - y (called as yank) . To copy and entire line use - yy

4. Paste the copied text - p (You can also add numbers infront to indicate how many times to paste, eg: 5 p will paste the text 5 times.)

By default p will paste the text below the current line. To paste it above the current line use capital P  (CAPS P)


### No mode / These commands are entered when the vi is in no specific mode (press esc)


1. dd - To delete entire line (5 dd will delete 5 lines below the cursor)

2. D - Deletes the text after the cursor of a line.

2. Change a line - cc  (This is similar to dd but it will not delete the line instead it clear all text in that line and waits at the start of the line to enter new text)

4. To replace a text/character - r  (It will replace the character with new character at the curstor location)


5. To move the cursor to next word - w (Useful when you want to jump to the middle of a long line)

6. To move the cursor to previous word - b

***

Note: " w and b"  are really powerful when combined with other commands, eg  To copy 3 word - y3w  (yank 3 words) or To delete 2 words - d2w (Delete 2 words) or 5w to move to 5th word of that line from the position of the cursor.

***


### UNDO/REDO

1. Undo -  u button  (Can also perform multiple undos based n the provided number before u . eg: 2 u  will undo last 2 chnage.)

2. Redo - crtl + r  (Same behavior like undo)


### Adding additional features:

line number -   Press : and type set number  (To remove -  : set nonumber)