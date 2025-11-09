/* See LICENSE file for copyright and license details. */

/* Helper macros for spawning commands */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define CMD(...)   { .v = (const char*[]){ __VA_ARGS__, NULL } }

/* appearance */
static const unsigned int borderpx = 2; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const unsigned int gappih = 5;   /* horiz inner gap between windows */
static const unsigned int gappiv = 10;  /* vert inner gap between windows */
static const unsigned int gappoh = 4; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov = 2; /* vert outer gap between windows and screen edge */
static const int smartgaps_fact =1; /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps */
static const char autostartblocksh[] = "autostart_blocking.sh";
static const char autostartsh[] = "autostart.sh";
static const char dwmdir[] = "dwm";
static const char localshare[] = ".local/share";
static const int showbar = 1; /* 0 means no bar */
static const int topbar = 1;  /* 0 means bottom bar */
static const int statusmon = 'A';
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int showsystray = 1;             /* 0 means no systray */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype = INDICATOR_BOTTOM_BAR;
static int tiledindicatortype = INDICATOR_NONE;
static int floatindicatortype = INDICATOR_TOP_LEFT_SQUARE;
static const char *fonts[] = { "JetBrainsMono Nerd Font:style=Medium:pixelsize=12",
    "Calibri:style=Bold:size=10:antialias=true:autohint=true",
};

static char c000000[] = "#00ff00"; // placeholder value

static char black[]       = "#1e2122";
static char white[]       = "#c7b89d";
static char gray2[]       = "#282b2c"; // unfocused window border
static char gray3[]       = "#404344";
static char gray4[]       = "#282b2c";
static char blue[]        = "#6f8faf";  // focused window border
static char green[]       = "#89b482";
static char red[]         = "#ec6b64";
static char orange[]      = "#fe8019";
static char yellow[]      = "#d1b171";
static char pink[]        = "#cc7f94";
static char purple[]      = "#ae81ff";
static char cyan[]        = "#66d9ef";
static char darkred[]        = "#cc241d";

static char *colors[][ColCount] = {
    /*                       fg                bg                border float */
    [SchemeNorm] =      {red, black, black, black},
    [SchemeSel] =       {blue, white, gray3, red},
    [SchemeTitleNorm] = {cyan, black, red, darkred},
    [SchemeTitleSel] =  {green, black, green, red},
    [SchemeTagsNorm] =  {orange, black, gray2, black},
    [SchemeTagsSel] =   {pink, black, pink, pink},
    [SchemeHidNorm] =   {blue, black, c000000, c000000},
    [SchemeHidSel] =    {green, black, c000000, c000000},
    [SchemeUrg] =       {gray4, black, cyan, black},
    [SchemeTag1] =      {blue, black, c000000},
    [SchemeTag2] =      {green, black, c000000},
    [SchemeTag3] =      {red, black, c000000},
    [SchemeTag4] =      {orange, black, c000000},
    [SchemeTag5] =      {yellow, black, c000000},
    [SchemeTag6] =      {pink, black, c000000},
    [SchemeTag7] =      {purple, black, c000000},
    [SchemeTag8] =      {cyan, black, c000000},
    [SchemeTag9] =      {darkred, black, c000000},
    [SchemeLayout] =    {purple, black, c000000},
};

const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL};
const char *spcmd2[] = {"st", "-n", "scratch2", "-e", "htop", NULL};
static Sp scratchpads[] = {
    /* name          cmd  */
    {"spterm", spcmd1},
    {"scratch2", spcmd2},
};

static char *tagicons[][NUMTAGS] = {
    [DEFAULT_TAGS] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"},
};

/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields
 * depending on the patches you enable.
 */
static const Rule rules[] = {
RULE(.wintype = WTYPE "DIALOG", .isfloating = 1) 
RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1) 
RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)
RULE(.title = "Edit_Configs", .isfloating = 1, .iscentered = 1)
RULE(.class = "pavucontrol", .isfloating = 1, .iscentered = 1)
RULE(.class = "Qalculate-gtk", .isfloating = 1, .iscentered = 1)
RULE(.instance = "spterm", .tags = SPTAG(0), .isfloating = 1)
RULE(.instance = "scratch2", .tags = SPTAG(1), .isfloating = 1, .iscentered = 1)
RULE(.instance = "openvim", .tags = SPTAG(2), .isfloating = 1)
RULE(.instance = "network", .isfloating = 1, .iscentered = 1)
};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for
 * active?) bar - bar index, 0 is default, 1 is extrabar alignment - how the
 * module is aligned compared to other modules widthfunc, drawfunc, clickfunc -
 * providing bar module width, draw and click functions name - does nothing,
 * intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar    alignment         widthfunc                 drawfunc                clickfunc                hoverfunc                name */
	{ -1,        0,     BAR_ALIGN_LEFT,   width_tags,               draw_tags,              click_tags,              hover_tags,              "tags" },
	{  0,        0,     BAR_ALIGN_RIGHT,  width_systray,            draw_systray,           click_systray,           NULL,                    "systray" },
	{ -1,        0,     BAR_ALIGN_LEFT,   width_ltsymbol,           draw_ltsymbol,          click_ltsymbol,          NULL,                    "layout" },
	{ statusmon, 0,     BAR_ALIGN_RIGHT,  width_status2d,           draw_status2d,          click_statuscmd,         NULL,                    "status2d" },
	{ -1,        0,     BAR_ALIGN_NONE,   width_wintitle,           draw_wintitle,          click_wintitle,          NULL,                    "wintitle" },
};

/* layout(s) */
static const float mfact = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;   /* number of clients in master area */
static const int resizehints = 0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },


/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu_run", "-m", dmenumon, NULL};
static const char *termcmd[] = {"alacritty", NULL};
static const char *filecmd[] = {"pcmanfm", NULL};
static const char *browsercmd[] = {"librewolf", NULL};

#include <X11/XF86keysym.h>
#include <X11/keysym.h>
/* This defines the name of the executable that handles the bar (used for
 * signalling purposes) */
#define STATUSBAR "dwmblocks"

static const Key keys[] = {
/* modifier                     key            function argument */
{MODKEY, XK_p, spawn, {.v = dmenucmd}},
{MODKEY, XK_Return, spawn, {.v = termcmd}},
{MODKEY, XK_Escape, spawn, SHCMD("xkill")},
{MODKEY, XK_e, spawn, {.v = filecmd}},
{MODKEY, XK_w, spawn, {.v = browsercmd}},
{0, XF86XK_AudioRaiseVolume, spawn, SHCMD("media-control up")},
{0, XF86XK_AudioLowerVolume, spawn, SHCMD("media-control down")},
{0, XF86XK_AudioMute, spawn, SHCMD("media-control mute")},
{0, XF86XK_AudioPrev, spawn, SHCMD("media-control prev")},
{0, XF86XK_AudioNext, spawn, SHCMD("media-control next")},
{0, XF86XK_AudioPlay, spawn, SHCMD("media-control toggle")},
{0, XF86XK_Search, spawn, SHCMD("media-control stop")},
{Mod1Mask | ControlMask, XK_o, spawn, SHCMD("picom-toggle.sh")},
{MODKEY, XK_space, spawn, SHCMD("change_kbd.sh")},
{MODKEY, XK_b, togglebar, {0}},
{MODKEY, XK_j, focusstack, {.i = +1}},
{MODKEY, XK_k, focusstack, {.i = -1}},
{MODKEY, XK_i, incnmaster, {.i = +1}},
{MODKEY, XK_d, incnmaster, {.i = -1}},
{MODKEY, XK_h, setmfact, {.f = -0.05}},
{MODKEY, XK_l, setmfact, {.f = +0.05}},
{MODKEY | ShiftMask, XK_j, movestack, {.i = +1}},
{MODKEY | ShiftMask, XK_k, movestack, {.i = -1}},
{MODKEY | ShiftMask, XK_Return, zoom, {0}},
{MODKEY | Mod1Mask, XK_u, incrgaps, {.i = +1}},
{MODKEY | Mod1Mask | ShiftMask, XK_u, incrgaps, {.i = -1}},
{MODKEY | Mod1Mask, XK_i, incrigaps, {.i = +1}},
{MODKEY | Mod1Mask | ShiftMask, XK_i, incrigaps, {.i = -1}},
{MODKEY | Mod1Mask, XK_o, incrogaps, {.i = +1}},
{MODKEY | Mod1Mask | ShiftMask, XK_o, incrogaps, {.i = -1}},
{MODKEY | Mod1Mask, XK_6, incrihgaps, {.i = +1}},
{MODKEY | Mod1Mask | ShiftMask, XK_6, incrihgaps, {.i = -1}},
{MODKEY | Mod1Mask, XK_7, incrivgaps, {.i = +1}},
{MODKEY | Mod1Mask | ShiftMask, XK_7, incrivgaps, {.i = -1}},
{MODKEY | Mod1Mask, XK_8, incrohgaps, {.i = +1}},
{MODKEY | Mod1Mask | ShiftMask, XK_8, incrohgaps, {.i = -1}},
{MODKEY | Mod1Mask, XK_9, incrovgaps, {.i = +1}},
{MODKEY | Mod1Mask | ShiftMask, XK_9, incrovgaps, {.i = -1}},
{MODKEY | Mod1Mask, XK_0, togglegaps, {0}},
{MODKEY | Mod1Mask | ShiftMask, XK_0, defaultgaps, {0}},
{MODKEY, XK_Tab, view, {0}},
{MODKEY, XK_q, killclient, {0}},
{MODKEY | ShiftMask, XK_q, quit, {0}},
{MODKEY | ControlMask | ShiftMask, XK_q, quit, {1}},
{MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
{MODKEY, XK_n, setlayout, {.v = &layouts[1]}},
{MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
{MODKEY|ShiftMask, XK_space, setlayout, {0}},
{MODKEY | ShiftMask, XK_f, togglefloating, {0}},
{MODKEY, XK_grave, togglescratch, {.ui = 0}},
{MODKEY, XK_a, togglescratch, {.ui = 1}},
{MODKEY | ControlMask, XK_grave, setscratch, {.ui = 0}},
{MODKEY | ShiftMask, XK_grave, removescratch, {.ui = 0}},
{MODKEY, XK_f, togglefullscreen, {0}},
{MODKEY, XK_0, view, {.ui = ~SPTAGMASK}},
{MODKEY | ShiftMask, XK_0, tag, {.ui = ~SPTAGMASK}},
{MODKEY, XK_comma, focusmon, {.i = -1}},
{MODKEY, XK_period, focusmon, {.i = +1}},
{MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
{MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
TAGKEYS(XK_9, 8)};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask           button          function
       argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button1, sigstatusbar, {.i = 1}},
    {ClkStatusText, 0, Button2, sigstatusbar, {.i = 2}},
    {ClkStatusText, 0, Button3, sigstatusbar, {.i = 3}},
    {ClkStatusText, 0, Button4, sigstatusbar, {.i = 4}},
    {ClkStatusText, 0, Button5, sigstatusbar, {.i = 5}},
    {ClkStatusText, ShiftMask, Button2, sigstatusbar, {.i = 6}},
    /* placemouse options, choose which feels more natural:
     *    0 - tiled position is relative to mouse cursor
     *    1 - tiled postiion is - view all windows on screen.relative to window center
     *    2 - mouse pointer warps to window center
     *
     * The moveorplace uses movemouse or placemouse depending on the floating
     * state of the selected client. Set up individual keybindings for the two
     * if you want to control these separately (i.e. to retain the feature to
     * move a tiled window into a floating position).
     */
    {ClkClientWin, MODKEY, Button1, moveorplace, {.i = 1}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
