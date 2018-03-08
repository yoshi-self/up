Shell script to go up directories

## Installation
Put up.sh somewhere  
Add following line in your .bashrc  
(alias name is whatever you choose)
```
alias up="source path/to/up.sh"
```
NOTE: cd doesn't work in current shell unless execute by source command

## Usage
```
up [option]
```

### Options
* none : Go up to parent directory
* number : Go up to parent directory [number] times
* word : Go up to the directory named [word]
* -g, --git : Go up to the root directory of git repository
