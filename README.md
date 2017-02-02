#Bash Drum Kit  
###simply play

##Depends  
* bash
* aplay

##Help File  
```  
BDK - BASH DRUM KIT

    bdk [options] [kit-name]



    [options]  [Description]

    -k          Load drum kit
    -l          List available kits  
```

##Creating Kits  

All kits are just directories within the kits directory.  
Each directory has it's own confit with variables which contain file paths to sounds.  
These sounds are then carried over to BDK and used with hotkeys.  

##Directory Structures  
```
bdk -|
	kits (dir)-|
	           |
		default (dir)-|
		              |
			config (file)
```

##Using Kits  


Just point bdk to the kit you want to use:  

```
bdk.sh -k default  
```


You can see a list of available kits by typing:  

```
bdk -l
```  


##Example config  

located in: kits/default/config  

```  
#!/bin/bash


KICK=sounds/kick.wav
SNARE=sounds/snare.wav
HIHAT=sounds/hihat.wav
```
