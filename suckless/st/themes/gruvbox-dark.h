/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {
	/* 8 normal colors */
    "#282828",
    "#cc241d",
    "#98971a",
    "#d79921",
    "#458588",
    "#b16286",
    "#689d6a",
    "#a89984",

    "#928374",
    "#fb4934",
    "#b8bb26",
    "#fabd2f",
    "#83a598",
    "#d3869b",
    "#8ec07c",
    "#ebdbb2",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#a89984", /* 256 -> cursor */
	"#928374", /* 257 -> rev cursor */
	"#ebdbb2",  /* 258 -> foreground */
	"#282828",   /* 259 -> background */
	"#282828",   /* 260 -> background unfocused */
	"#ebdbb2",  /* 261 -> visual bell */
};
