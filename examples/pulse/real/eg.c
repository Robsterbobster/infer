#include <stdlib.h>
#include "slre.h"
#define MAX_BRANCHES 100
#define MAX_BRACKETS 100
/*
int main(void)
{
  char* bufr = "agfas";
  char* regex;
  //bufr = malloc(sizeof(char*));
  regex = malloc(sizeof(char*));
  slre_match(regex, bufr, 5, NULL, 0, 0);
}
*/
struct bracket_pair {
  const char *ptr;  /* Points to the first char after '(' in regex  */
  int len;          /* Length of the text between '(' and ')'       */
  int branches;     /* Index in the branches array for this pair    */
  int num_branches; /* Number of '|' in this bracket pair           */
};

struct branch {
  int bracket_index;    /* index for 'struct bracket_pair brackets' */
                        /* array defined below                      */
  const char *schlong;  /* points to the '|' character in the regex */
};

struct regex_info {
  /*
   * Describes all bracket pairs in the regular expression.
   * First entry is always present, and grabs the whole regex.
   */
  struct bracket_pair brackets[MAX_BRACKETS];
  int num_brackets;

  /*
   * Describes alternations ('|' operators) in the regular expression.
   * Each branch falls into a specific branch pair.
   */
  struct branch branches[MAX_BRANCHES];
  int num_branches;

  /* Array of captures provided by the user */
  struct slre_cap *caps;
  int num_caps;

  /* E.g. SLRE_IGNORE_CASE. See enum below */
  int flags;
};

int match(const char *re, struct slre_cap *caps, int num_caps, int flags){
  /* Initialize info structure */
  struct regex_info info;
  info.flags = flags;
  info.num_brackets = info.num_branches = 0;
  info.num_caps = num_caps;
  info.caps = caps;
  return foo(re, strlen(re), &info);
}

int foo(const char *re, int re_len, struct regex_info *info){
  info->brackets[0].ptr = re;
  //info->brackets[0].len = re_len;
  //info->num_brackets = 1;

  return 0;
}


