# Bash Shell Basics -- WORK IN PROGRESS

This is a concise refresher on the basic commands available with the Bash shell.  
It is designed as a prerequisite module to the Supercomputing User Training offered by Pawsey Supercomputing Research Centre, Perth (Australia).  
For a more detailed tutorial on the Bash shell, see [The Unix Shell](https://swcarpentry.github.io/shell-novice), by the [Software Carpentries](https://software-carpentry.org).  


## Some definitions

* **Command Line Interface** (CLI): a type of interface to use a computer, that requires the user to type textual **commands** and read their textual outputs by means of a prompt. Some commands may require optional or mandatory **arguments**.

* **Shell**: a program with a prompt providing a command line interface, and an interpreter to execute commands.  There are different implementations of a shell, using different **shell languages** for the commands.

* **Bash**: one of the most popular shells in the Linux world.

* **Shell script**: a text file containing a sequence of shell commands.  It can be executed via the shell, and is useful to increase reproducibility of a workflow.

* Main advantages of using a shell:
  * Productivity (lots of actions with few keystrokes)
  * Task automation
  * Reproducibility (using shell scripts)

* **Text editor**: a program used to open and edit textual files; some of them are designed for use within a command line interface, such as **nano**, **vi** and **emacs**.

NOTE: in all the examples below, by convention commands are identified by lines starting with `$`, which represents the prompt (not to be typed).  Other lines represent command outputs.  Also note how `#` denotes a comment line in Bash.


## Handling directories and files

First, navigate to the home directory using `cd`; here, `~` refers to the home, and can be omitted if used alone:
```
$ cd ~
$ # or also
$ cd
```

Check the path of the **current working directory** with `pwd`:
```
$ pwd
/home/*username*
```

Create a new directory with `mkdir`:
```
$ mkdir training
```

Enter it, and check where you are:
```
$ cd training
$ pwd
/home/*username*/training
```

The current directory can be referred to using a single dot, `.`:
```
$ cd .
$ pwd
/home/*username*/training
```

The **parent** directory can be referred to using a double dot, `..`:
```
$ cd ..
$ pwd
/home/*username*
$ cd training
```

Create two more directories inside `training`, enter the first one, and create one more:
```
$ mkdir dir1 dir2
$ cd dir1
$ mkdir one-more-dir
```
A **full path** does not depend on the current working directory, and starts with a slash, `/`, *e.g.*: `/home/*username*/training`.  
A **relative path** depends on the current working directory, and starts with a directory name, a `.` or a `..`, *e.g.*: `one-more-dir`, `./one-more-dir`, `../dir2`.

Go back to the `training` parent directory:
```
$ cd ..
$ pwd
/home/*username*/training
```

Now let us play with files.  Make new empty files using `touch` (the command is actually designed for altering file timestamps..):
```
$ touch file1
$ touch file2 file3
$ touch dir1/file4
```

Check the content of a directory with `ls`:
```
$ ls
dir1  dir2  file1  file2  file3l
$ ls dir1
file4  one-more-dir
```

Get more details about files and directories with:
```
$ ls -l
total 8
drwxr-x--- 3 *username* *username* 4096 Aug 26 14:10 dir1
drwxr-x--- 2 *username* *username* 4096 Aug 26 14:10 dir2
-rw-r----- 1 *username* *username*    0 Aug 26 14:10 file1
-rw-r----- 1 *username* *username*    0 Aug 26 14:10 file2
-rw-r----- 1 *username* *username*    0 Aug 26 14:10 file3
```

To make a copy of a file with another name use `cp`:
```
$ cp file1 copy1
```

To rename a file use `mv`:
```
$ mv copy1 another-file
```

To move a file to another directory use `mv` again, but now with the second argument as an existing directory:

```
$ mv another-file dir2/
```

Use `rm` to remove a file:
```
$ rm file3
```

Multiple files and/or directories can be selected using the **wildcard** characters `?` and `*`.  
The question mark, `?`, means any value of a single character:
```
$ ls file?
file1  file2
```

The asterisk, `*`, means any value of any number of characters:
```
$ ls f*
file1  file2
```

When the `*` also includes directories, `ls` will output their content, too:
```
$ ls *
file1  file2

dir1:
file4  one-more-dir

dir2:
another-file
```


## Using environment variables

You can assign a **value**, *i.e.* a string of characters, to an environment **variable**.  We call **shell environment** the whole set of variables defined in the current shell session.  
Assign a variable using the equal operator, `=`:
```
$ HELLO="world"
```

The value can be reused later in the same shell session by referring to the corresponding variable.  For instance, use `echo` to just display the variable value:
```
$ echo $HELLO
world
```

To make the variable accessible inside sub-processes, you need to `export` it:
```
$ export BYE="moon"
```

A process could be a program, a shell script, or just another Bash shell.  Let us verify the latter case.  Start a new Bash shell with `bash`, and then `exit` it when done:
```
$ bash
$ echo $HELLO

$ echo $BYE
moon
$ exit
exit
```

You can use a variable to store a directory path:
```
$ pwd
/home/*username*/training
$ MYDIR="/home/*username*/training"
```

And then to use it:
```
$ echo $MYDIR
/home/*username*/training
$ ls $MYDIR
dir1  dir2  file1  file2
```

There is a method to store the output of a command inside the variable: ncapsulating the command within the syntax `$( )`.  For instance, use this syntax to capture and store the output of `pwd`:
```
$ MYDIR_AGAIN="$(pwd)"
$ echo $MYDIR_AGAIN
/home/*username*/training
```

Every shell session automatically defines a number of environment variables, some of which can be quiteuseful.  
Among others, `$HOME` contains the path to your home directory, `$USER` contains your username, and `$PATH` has the list of paths where the shell looks for executable programs and scripts:
```
$ echo $HOME
/home/*username*
$ echo $USER
*username*
$ echo $PATH
/usr/local/bin:/usr/bin:/bin
```


## Visualising contents of text files

Let's now create a text file with some words in it.  We'll use a popular, friendly text editor called `nano`:
```
$ nano words.txt
```

In the editor screen, write something random.

To save this text, press `Ctrl-O`, then `Enter`.  
To exit, press `Ctrl-X`.

Now we want to visualise the contents of this file on our terminal.

We can use `cat` to display it all in one go:
```
$ cat words.txt

random words that we just saved in this file
```

For very long files, we might want to be able to navigate the content in chunks.  We can achieve this with `less`:
```
$ less words.txt
```

Go forward by pressing `Ctrl-F`, go backwards with `Ctrl-B`.  
Quit the navigation by pressing `q`.
