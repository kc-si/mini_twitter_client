def read_order
  if ARGV[0]
    input = ARGV[0]
  else
    puts( "Type number of order (or type/chose EXIT if you want to quit) end press ENTER : \n
          1. Create tweet \n
          2. Get and view an author tweets \n
          3. Get and view all tweets \n
          4. Delete tweet \n
          5. Delete author's tweets \n
          6. Delete all tweets \n
          0. Exit "
        )
    input = gets
    input = input.chop
  end
end

def get_input(kind)
  case kind
  when 'author'
    puts( "Type tweet author name and press ENTER : \n" )
  when 'message'
    puts( "Type tweet message and press ENTER : \n" )
  when 'id'
    puts( "Type tweet id and press ENTER : \n" )
  end
  input = gets
  input.chop
end
