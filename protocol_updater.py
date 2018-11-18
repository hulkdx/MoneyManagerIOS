#!/usr/bin/env python

# Script for updating swift protocol automatically based on the class.

import sys

def main():
  args = sys.argv
  if (len(args) != 2):
    show_usage(args)
  swift_filename_str = args[1]
  swift_file = open(swift_filename_str,"r")
  content = swift_file.read()
  started_class = content.find("class ")
  ended_class   = find_end_class(content, started_class)

  class_content = content[started_class: ended_class]
  functions = []
  for line in class_content.split("\n"):
    if line.strip().startswith("func "):
      functions.append(line.strip()[:-1])

  new_content = content[:ended_class]
  protocol_content = content[ended_class:]
  i = protocol_content.find("protocol ")
  protocol_content = protocol_content[i:]
  i = protocol_content.find("\n")
  protocol_content = protocol_content[:i]

  space = " " * 4
  new_content = "%s\n\n%s\n%s%s\n}\n" % (new_content, protocol_content, space, ("\n" + space).join(functions))
  #new_content = new_content + "\n\n" + protocol_content + "\n\t" + "\n\t".join(functions) + "\n}\n"
  swift_file = open(swift_filename_str,"w")
  swift_file.writelines(new_content)

  print(protocol_content)

def show_usage(args):
  print("USAGE: %s swift_filename" % args[0])

def find_end_class(content, start_index):
  substr = content[start_index:]

  counter = None
  end_class_index = start_index

  for c in substr:
    end_class_index += 1
    if c == "{":
      if (counter == None):
        counter = 0
      counter += 1
    elif c == "}":
      counter -= 1
    if counter == 0:
      break
  return end_class_index


if __name__ == "__main__":
  main()


