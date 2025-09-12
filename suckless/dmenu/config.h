/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"JetBrainsMono Nerd Font:size=12",
                              "Courier New:style=Bold:size=12"};
static const char *prompt =
    "Launch: "; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] = {"#ebdbb2", "#1d2021"},
    [SchemeSel] = {"#1d2021", "#D49721"},
    [SchemeOut] = {"#ebdbb2", "#8ec07c"},
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 10;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
