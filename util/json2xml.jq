# 💝 Use with jq 💝
# jq -r -f ./xml.jq some.json
# cat some.json | jq -r -f ./xml.jq

# Download or install jq from: https://jqlang.github.io/jq/download/ 
# Or: brew install jq
# Check out the manual: https://jqlang.github.io/jq/manual/

# To understand how content_key and attr_prefix work, run this script on the following JSON:
# https://gist.github.com/doramatadora/5623ea90e63ea1c6a15141e2fea054e8

def attr_prefix: "@";

def content_key: "#text" | "$t";

def escapes:
   {
      "&": "&amp;",
      "<": "&lt;", 
      ">": "&gt;"
   }
;

def attr_escapes:
   {
      "&": "&amp;",
      "<": "&lt;",
      "\"": "&quot;"
   }
;

def text_to_xml:
   split("") |
   map(escapes[.] // .) | 
   join("")
;

def text_to_xml_attr_val:
   split("") |
   map(attr_escapes[.] // .) | 
   join("")
;

def node_to_xml:
   if type == "string" then
      text_to_xml
   else
      (
         if .attrs then
            .attrs |
            to_entries |
            map(" \(.key)=\"\(.value | text_to_xml_attr_val)\"") |
            join("")
         else
            ""
         end
     ) as $attrs |

      if .children and (.children | length) > 0 then
         (
            .children |
            map(node_to_xml) |
            join("")
         ) as $children |
         "<\(.name)\($attrs)>\($children)</\(.name)>"
      else
         "<\(.name)\($attrs)>"
      end
   end
;

def fix_tree($name):
   type as $type |
   if $type == "array" then
      .[] | fix_tree($name)
   elif $type == "object" then
      reduce to_entries[] as { key: $k, value: $v } (
         { name: $name, attrs: {}, children: [] };

         if $k[0:1] == attr_prefix then
            .attrs[$k[1:]] = $v
         elif $k == content_key then
            .children += [$v]
         else
            .children += [$v | fix_tree($k)]
         end
     )
   else
      { name: $name, attrs: {}, children: [.] }
   end
;

def fix_tree: 
   fix_tree("") |
   .children[]
;

def leaves_to_string:
   walk(
      if type == "object" then 
         with_entries(.value |= leaves_to_string) 
      elif type == "array" then 
         map(leaves_to_string)
      else 
         tostring
      end
   )
;

def to_xml: 
   leaves_to_string |
   fix_tree |
   node_to_xml
;

# Remove this line if you want to use this file as a library.
to_xml
