# Stupid Pong

Stupid Pong is a project which play hack the classic video game pong with creative coding tools. 
It can be controlled by via OSC message transmitted with UDP on port 6000.

## OSC API

/left  [0.-1.] 
move left paddle

/right [0.-1.]
move right paddle

/ball/size [0.-inf.]
change balls size

/ball/add
add one ball

/ball/suppr
remove one ball

/invert
reverse color
