## Night Writer

### Overview

This project implements systems for generating Braille-like text from normal characters and the reverse.

Braille uses a two-by-three grid of dots to represent characters. Night Writer simulates that concept by using three lines of symbols:

0.0.0.0.0....00.0.0.00

00.00.0..0..00.0000..0

....0.0.0....00.0.0...


The 0 represents a raised dot. The period is an unraised space. The above code reads "hello world" in normal text.
The application uses the lowercase letters a-z from the American Foundation for the Blind.
It also supports capitalization. In Braille, capitalization comes from a shift character. You'll find that character at the end of the fourth row of the previous graphic. When that character appears, the next character (and only the next character) is a capital. So e comes out as one 2x3 set of Braille points, but E is 4x3: the shift character followed by the normal e. This affected the line width restrictions of 80 characters.

### The tool is used from the command line like so:

$ ruby ./lib/night_write.rb message.txt braille.txt
Created 'braille.txt' containing 256 characters
That will use the plaintext file message.txt to create a Braille simulation file braille.txt.

To convert that Braille simulation back to normal text write:

$ ruby ./lib/night_read.rb braille.txt original_message.txt
Created 'original_message.txt' containing 256 characters.
Character Support


### Learning Goals / Areas of Focus

* Practice breaking a program into logical components
* Testing components in isolation and in combination
* Applying Enumerable techniques in a real context
* Reading text from and writing text to files


### Development Phases

#### 1. The Runner

Write a Ruby program that can just output a string like:

$ ruby ./lib/night_write.rb message.txt braille.txt
Created 'braille.txt' containing 256 characters
Then work to:

Pull the specified output filename from the command line arguments and print it in the terminal
Get the actual number of characters from the message.txt and output it in the terminal

#### 2. Echo Characters

Your Braille-simulation file will need three lines of output for every one line of input. Start by outputting your input in three repeated rows.

#### 3. Mapping

You'll need a component that takes a normal text character and returns the Braille equivalent.

#### 4. Triple Replacement

Bringing together the Echo Characters idea with the Mapping idea, you can actually output your Braille characters to the file. Consider building a component that would take in a plain-text letter and a position (maybe numbered 0-5) and would return either a 0 or ..

#### 5. Next Steps

About this point, you should try Braille-ifying a message. Then it's time to dive into the reading.

#### Extension Supporting Numbers

The representations for 1-9 are actually the same as a-i. This number sign # is a "switch" which means that all of the following "letters", up to the next space, are actually numbers. After the space it's assumed that we're back to words/letters unless we see another number switch.

### Project process

I enjoyed working on this project despite its difficulty 2 weeks into the program. It was very satisfying to see the en- and decoding process live in the text files.
To transform a one line and one character letter into a character consisting of 6 parts that span over three lines was not too difficult. It became really challenging when I had to implement the line break after 80 characters. Each of the three parallel running strings had to be cut into pieces and be printed 3 lines later. Reversing this process and collecting the lines in the right order into the original strings was another challenge. Pry was the perfect tool to understand what each of the methods actually did and returned in order to get to the right output. The encoding of each letter made TDD pretty difficult and tedious to use. Because of these challenges I was not able to fully complete the project in time.
