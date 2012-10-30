# https://github.com/sandofsky/plist-to-json
# jsonify function is taken from w3schools http://www.w3schools.com/Dom/dom_loadxmldoc.asp

window.jsonify = (tag) ->
  switch tag.nodeName
    when "dict"
      d = {}
      i = 0
      nodes = tag.childNodes
      while i < nodes.length
        if nodes[i].nodeName is "key"
          key = nodes[i].textContent
          i++
          i++  while nodes[i].nodeName is "#text"
          d[key] = jsonify(nodes[i])
        i++
      d
    when "array"
      a = []
      i = 0
      nodes = tag.childNodes
      while i < nodes.length
        a.push jsonify(nodes[i])  unless nodes[i].nodeName is "#text"
        i++
      a
    when "string"  then tag.textContent
    when "data"    then tag.textContent
    when "real"    then tag.textContent
    when "integer" then tag.textContent
    when "true"    then true
    when "false"   then false

window.loadXMLString = (txt) ->
  try
    xmlDoc = new ActiveXObject("Microsoft.XMLDOM")
    xmlDoc.async = "false"
    xmlDoc.loadXML txt
    return (xmlDoc)
  catch e
    try
      parser = new DOMParser()
      xmlDoc = parser.parseFromString(txt, "text/xml")
      return (xmlDoc)
    catch e
      alert e.message
  null

window.plist_to_json = (plist) ->
  doc = loadXMLString(plist)
  console.log doc
  i = 0
  while i < doc.documentElement.childNodes.length
    return jsonify(doc.documentElement.childNodes[i])  unless doc.documentElement.childNodes[i].nodeName is "#text"
    i++