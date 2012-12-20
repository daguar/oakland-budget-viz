require 'json'
require 'pry'

file_contents = open('chicago_raw.json').read
parsed_contents = JSON.parse(file_contents)

temp_table = Array.new

# Extract fund name, department name, and amount from JSON file
parsed_contents['data'].each do |d|
  temp_table << [d[8], d[9], d[10]] if d[10].to_i > 50000000 # if clause to clean small entries
end

# Create a list of nodes from unique fund and department names
nodes = Array.new
temp_table.each do |row|
  nodes << row[0] unless nodes.include?(row[0])
  nodes << row[1] unless nodes.include?(row[1])
end
nodes.sort!

# Create a list of links between nodes
links = Array.new
temp_table.each do |row|
  links << { 'source' => nodes.index(row[0]), 'target' => nodes.index(row[1]), 'value' => row[2] }
end

# Convert array of nodes to a single-pair hash, as called for by the D3 Sankey plugin
nodes.collect! { |n| {"name" => n} }

final_hash = { "nodes" => nodes, "links" => links }

File.open('js/chicago.json', "w") do |f|
  f.write(final_hash.to_json)
end


