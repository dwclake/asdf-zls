#!/usr/bin/awk -f
BEGIN {
  FS = "[ /^]+"
  while ("git ls-remote " "https://github.com/zigtools/zls" "| sort -Vk2" | getline) {
    if (!sha)
      sha = substr($0, 1, 7)
    tag = $3
  }
  while ("curl -s " "https://github.com/zigtools/zls" "/releases/tag/" tag | getline)
    if ($3 ~ "commits")
      com = $2
  major = substr(tag, 0, 1)
  minor = substr(tag, 3, 6) + 1
  patch = substr(tag, 7, 8)
  printf com ? "%d.%d.%d-dev.%s+%s\n" : "%s\n", major, minor, patch, com, sha
}
