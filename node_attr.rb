module MKnifePlugin
  class NodeAttr < Chef::Knife
  banner "knife node attr NODE ATTRIBUTE 'NEW_VALUE'"
    def run
      if name_args.count < 2
        puts "You must specific a NODE and ATTRIBUTE"
        exit 1
      end
      node = name_args[0]
      attribute = name_args[1]

      @node = Chef::Node.load(node)
      *parts, last = attribute.split('.')
      tree = parts.inject(@node) { |h,attr| h[attr] }

      if(name_args.count == 2)
        if(tree[last].is_a? Chef::Node::Attribute)
          p tree[last].to_hash
        else
          p tree[last]
        end
      elsif(name_args.count == 3)
        tree[last] = name_args[2]
        @node.save
        p tree[last]
      end
    end
  end
end
