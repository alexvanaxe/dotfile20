/**
 * ROFI Color theme
 * User: Qball
 * Copyright: Dave Davenport
 */

/**
 * User: Qball
 * Copyright: Dave Davenport
 */
* {
    foreground:  #foreground;
    backlight:   #backlight;
    background-color:  transparent;
    dark: #1c1c1c;
    // Black
    black:       #3d352a;
    lightblack:  #554444;
    tlightblack:  #tlightblack;
    //
    // Red
    red:         #cd5c5c;
    lightred:    #cc5533;
    //
    // Green
    green:       #86af80;
    lightgreen:  #88cc22;
    //
    // Yellow
    yellow:      #e8ae5b;
    lightyellow:     #ffa75d;
    //
    // Blue
    blue:      #6495ed;
    lightblue:     #87ceeb;
    //
    // Magenta
    magenta:      #magenta;
    lightmagenta:     #996600;
    //
    // Cyan
    cyan:      #b0c4de;
    tcyan:      #ccb0c4de;
    lightcyan:     #b0c4de;
    //
    // White
    white:      #bbaa99;
    lightwhite:     #ddccbb;
    //
    // Bold, Italic, Underline

    transparent: rgba(0,0,0,0);
    font-default: "Source Code Pro 10";
}
window {
    location: center;
    anchor:   center;
    transparency: "real";
    padding: 250px;
    border:  0px;
    border-radius: 10px;
    color: #000000;
    background-color: @transparent;
    spacing: 0;
    children:  [mainbox];
    orientation: horizontal;
    fullscreen: true;
    font: @font-default;
}

mainbox {
    spacing: 0;
    children: [ inputbar, message, listview ];
    color:#000000;

}

message {
    border-color: @foreground;
    border:  0px 2px 2px 2px;
//    border-radius: 10px;
    padding: 5;
    background-color: @tcyan;
    text-color:#000000;
}
message {
    font: "Source Code Pro 8";
    color:#000000;
}

    color: #00
    padding: 11px;
    background-color: @tlightblack;
    border: 2px 2px 2px 2px;
    border-radius:  15px 15px 0px 0px;
    border-color: @foreground;
    font: "Source Code Pro 18";
    text-color:#000000;
}
entry,prompt,case-indicator {
    text-font: inherit;
    text-color:inherit;
}
prompt {
    margin:     0px 0.3em 0em 0em ;
    text-color:#000000;
}
listview {
    padding: 8px;
    border-radius: 0px 0px 15px 15px;
    border-color: @foreground;
    border: 0px 2px 2px 2px;
    background-color: #ffffff;
    dynamic: false;
    columns: 2;
    text-color: #ffffff;
    lines: 10;
}
element {
    padding: 3px;
    vertical-align: 0.5;
//    border: 2px;
    border-radius: 4px;
    background-color: transparent;
    text-color: #ffffff;
    font:inherit;
}
element selected.normal {
    background-color: #ffffff;
    color: #selectedFgActiveItem;
    text-color: #ffffff;
}
element normal active {
    background-color: #ffffff;
    foreground: #activeItem;
    text-color: #ffffff;
}
element normal urgent {
    foreground: @lightred;
    text-color: #ffffff;
}
element alternate normal {
    background-color: #ffffff;
    text-color: #ffffff;
}
element alternate active {
    background-color: #ffffff;
    foreground: @lightblue;
    text-color: #ffffff;
}
element alternate urgent {
    foreground: @lightred;
}
element selected active {
    text-color: #ffffff;
    background-color: #ffffff;
    color: #selectedFgActiveItem;
}
element selected urgent {
    background-color: @lightred;
    foreground: @dark;
    highlight: #highlightActive;
}
element normal normal {

    background-color: #ffffff;
    text-color: #ffffff;

}

vertb {
    expand: false;
    children: [ dummy0, mode-switcher, dummy1  ];
}
dummy0,  dummy1 {
    expand: true;
}

mode-switcher {
    expand: false;
    orientation: vertical;
    spacing: 0px;
    border: 0px 0px 0px 0px;
}
button {
    font: "FontAwesome 22";
    padding: 6px;
    border: 2px 0px 2px 2px;
    border-radius: 4px 0px 0px 4px;
    background-color: @tlightblack;
    border-color: @foreground;
    color: @foreground;
    horizontal-align: 0.5;
}
button selected normal {
    color: @dark;
    border: 2px 0px 2px 2px;
    background-color: @backlight;
    border-color: @foreground;
}

error-message {
    expand: true;
    background-color: red;
    border-color: darkred;
    border: 2px;
    padding: 1em;
}
