/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {
	/* 8 normal colors */
    "#45475A",
    "#F38BA8",
    "#A6E3A1",
    "#F9E2AF",
    "#89B4FA",
    "#F5C2E7",
    "#94E2D5",
    "#BAC2DE",

    "#45475A",
    "#F38BA8",
    "#A6E3A1",
    "#F9E2AF",
    "#89B4FA",
    "#F5C2E7",
    "#94E2D5",
    "#BAC2DE",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#F5E0DC", /* 256 -> cursor */
	"#B4BEFE", /* 257 -> rev cursor */
	"#CDD6F4",  /* 258 -> foreground */
	"#1E1E2E",   /* 259 -> background */
	"#1E1E2E",   /* 260 -> background unfocused */
	"#F5E0DC",  /* 261 -> visual bell */
};
